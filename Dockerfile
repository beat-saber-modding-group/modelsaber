# syntax=docker/dockerfile:1
FROM php:7-apache-buster

RUN apt-get update && \
  apt-get install -y libpq-dev python3 python3-pip libonig-dev zlib1g-dev libjpeg-dev git && \
  pip3 install git+https://github.com/HearthSim/UnityPack.git@f8cdc2516538d189606a76986ad2d71c3fad5f8b#egg=unitypack && \
  docker-php-ext-install pdo_pgsql exif mbstring && \
  cp -v "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
  echo "error_reporting = E_ALL & ~E_WARNING & ~E_NOTICE & ~E_DEPRECATED" >> "$PHP_INI_DIR/conf.d/modelsaber.ini" && \
  echo "post_max_size = 100M" >> "$PHP_INI_DIR/conf.d/modelsaber.ini" && \
  echo "upload_max_filesize = 100M" >> "$PHP_INI_DIR/conf.d/modelsaber.ini" && \
  rm -rf /var/lib/apt/lists/*

COPY . .
RUN chmod +x /var/www/html/Upload/getInfo.py

EXPOSE 80
VOLUME ["/var/www/html/files"]
