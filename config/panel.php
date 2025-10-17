<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Panel KelasMaster Configuration
    |--------------------------------------------------------------------------
    |
    | Configuration settings specific to panel.kelasmaster.id
    |
    */

    'app_name' => env('APP_NAME', 'SpecMaster Demo'),
    'app_url' => env('APP_URL', 'https://panel.kelasmaster.id'),
    'app_env' => env('APP_ENV', 'production'),
    
    // Database configuration
    'db_connection' => env('DB_CONNECTION', 'mysql'),
    'db_host' => env('DB_HOST', '127.0.0.1'),
    'db_port' => env('DB_PORT', '3306'),
    'db_database' => env('DB_DATABASE', 'specmaster_demo'),
    'db_username' => env('DB_USERNAME', 'specmaster_user'),
    'db_password' => env('DB_PASSWORD', 'password'),
    
    // Cache configuration
    'cache_driver' => env('CACHE_DRIVER', 'file'),
    
    // Session configuration
    'session_driver' => env('SESSION_DRIVER', 'file'),
    
    // Queue configuration
    'queue_driver' => env('QUEUE_DRIVER', 'sync'),
];