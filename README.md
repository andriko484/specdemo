# SpecMaster Demo Laravel Application for panel.kelasmaster.id

This is a simple Laravel application configured for deployment on panel.kelasmaster.id. It includes a basic CRUD functionality for posts with MySQL database integration.

## Features

- Create, Read, Update, and Delete posts
- Responsive UI with Tailwind CSS
- MySQL database integration
- Ready for deployment to panel.kelasmaster.id

## Requirements

- PHP 8.1+
- MySQL
- Composer
- Node.js and npm

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/andriko484/specdemo.git
   cd specmaster-demo
   ```

2. Install PHP dependencies:
   ```bash
   composer install
   ```

3. Install Node.js dependencies:
   ```bash
   npm install
   npm run build
   ```

4. Copy the environment file and configure your settings:
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

5. Configure your database settings in `.env`:
   ```
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=specmaster_demo
   DB_USERNAME=specmaster_user
   DB_PASSWORD=password
   ```

6. Run database migrations:
   ```bash
   php artisan migrate
   ```

7. Start the development server:
   ```bash
   php artisan serve
   ```

## Deployment to panel.kelasmaster.id

The application includes a deployment script (`deploy.sh`) that automates the deployment process to panel.kelasmaster.id.

### Automated Deployment

1. Upload the application files to your VPS
2. Make the deployment script executable:
   ```bash
   chmod +x deploy.sh
   ```
3. Run the deployment script:
   ```bash
   ./deploy.sh
   ```

### Manual Deployment

1. Install required packages:
   - Nginx
   - MySQL
   - PHP 8.1+ with extensions: json, common, mysql, zip, gd, mbstring, curl, xml, pear, bcmath
   - Composer
   - Node.js and npm

2. Clone the repository to `/var/www/panel.kelasmaster.id`

3. Install dependencies:
   ```bash
   composer install --no-dev --optimize-autoloader
   npm install
   npm run build
   ```

4. Set proper permissions:
   ```bash
   sudo chown -R www-data:www-data /var/www/panel.kelasmaster.id
   sudo chmod -R 755 /var/www/panel.kelasmaster.id/storage /var/www/panel.kelasmaster.id/bootstrap/cache
   ```

5. Configure environment variables and generate app key:
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

6. Set up the database and run migrations

7. Configure Nginx with the included configuration

## GitHub Deployment

This application is designed to be deployed via GitHub:

1. Push your changes to your GitHub repository
2. Set up your VPS to pull from GitHub
3. Use webhooks or manual pulling to update the application

## License

This project is open-source and available under the [MIT License](LICENSE).