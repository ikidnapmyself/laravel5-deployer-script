#!/usr/bin/env bash

echo "Hibernation begins..."
php artisan down --retry=30
echo "Updating project"
git pull origin master
echo "Updating dependencies"
composer update --no-dev --optimize-autoloader
echo "Clearing cache"
php artisan cache:clear
php artisan route:cache
php artisan config:cache
echo "Migrating"
php artisan migrate --force
echo "Cache things"
php artisan route:cache
php artisan config:cache
echo "Welcome back Neo..."
php artisan up
phpunit
