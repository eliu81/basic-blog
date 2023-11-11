#!/bin/bash
cd api;
cp .env.example .env
docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v "$(pwd):/var/www/html" \
    -w /var/www/html \
    laravelsail/php82-composer:latest \
    composer install --ignore-platform-reqs;
./vendor/bin/sail build web;
./vendor/bin/sail up -d;
./vendor/bin/sail artisan migrate;
./vendor/bin/sail artisan db:seed;