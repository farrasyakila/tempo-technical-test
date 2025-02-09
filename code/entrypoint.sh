#!/bin/sh

# Tunggu MySQL agar siap menerima koneksi
echo "Menunggu database..."
until nc -z -v -w30 $DB_HOST $DB_PORT; do
  echo "Menunggu database untuk siap..."
  sleep 5
done

echo "Database siap! Melakukan migrasi..."
php artisan migrate 

echo "Menjalankan Nginx dan PHP-FPM..."
service nginx start
exec php-fpm

