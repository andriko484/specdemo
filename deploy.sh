#!/bin/bash
# Deployment script for Laravel application

# Variables
APP_NAME="specmaster-demo"
APP_PATH="/var/www/$APP_NAME"
REPO_URL="https://github.com/yourusername/$APP_NAME.git"
BRANCH="main"

# Update system
echo "Updating system packages..."
sudo apt update

# Install required packages
echo "Installing required packages..."
sudo apt install -y git curl wget unzip nginx mysql-server php php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath

# Install Composer
echo "Installing Composer..."
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install Node.js and npm
echo "Installing Node.js and npm..."
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs

# Clone the repository
echo "Cloning repository..."
sudo mkdir -p $APP_PATH
sudo chown -R $USER:$USER $APP_PATH
git clone $REPO_URL $APP_PATH
cd $APP_PATH
git checkout $BRANCH

# Install PHP dependencies
echo "Installing PHP dependencies..."
composer install --no-dev --optimize-autoloader

# Install Node dependencies and build assets
echo "Installing Node dependencies..."
npm install
npm run build

# Set permissions
echo "Setting permissions..."
sudo chown -R www-data:www-data $APP_PATH
sudo chmod -R 755 $APP_PATH/storage $APP_PATH/bootstrap/cache

# Create .env file
echo "Creating .env file..."
cp .env.example .env
php artisan key:generate

# Configure database
echo "Configuring database..."
sudo mysql -e "CREATE DATABASE IF NOT EXISTS ${APP_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER IF NOT EXISTS 'laravel_user'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${APP_NAME}.* TO 'laravel_user'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Update .env with database credentials
sed -i "s/DB_DATABASE=laravel/DB_DATABASE=${APP_NAME}/" .env
sed -i "s/DB_USERNAME=root/DB_USERNAME=laravel_user/" .env
sed -i "s/DB_PASSWORD=/DB_PASSWORD=password/" .env

# Run migrations
echo "Running database migrations..."
php artisan migrate --force

# Configure Nginx
echo "Configuring Nginx..."
sudo tee /etc/nginx/sites-available/$APP_NAME > /dev/null <<EOF
server {
    listen 80;
    server_name your_domain.com;
    root $APP_PATH/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    index index.php;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/$APP_NAME /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

# Set up supervisor for queue workers (optional)
echo "Setting up supervisor for queue workers..."
sudo apt install -y supervisor

sudo tee /etc/supervisor/conf.d/$APP_NAME.conf > /dev/null <<EOF
[program:laravel-worker]
process_name=%(program_name)s_%(process_num)02d
command=php $APP_PATH/artisan queue:work --sleep=3 --tries=3
autostart=true
autorestart=true
user=www-data
numprocs=8
redirect_stderr=true
stdout_logfile=$APP_PATH/storage/logs/worker.log
EOF

sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start laravel-worker:*

echo "Deployment completed successfully!"