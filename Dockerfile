FROM wordpress:php7.4-fpm

RUN apt-get update && apt-get install -y \
        libicu-dev \
        libmcrypt-dev \
        libmagickwand-dev \
        libsodium-dev \
        libzip-dev \
        --no-install-recommends && rm -r /var/lib/apt/lists/*

RUN pecl install redis-5.3.4 imagick-3.5.0 libsodium-2.0.23 mcrypt-1.0.4\
        && docker-php-ext-enable redis imagick sodium mcrypt \
        && docker-php-ext-install -j$(nproc) exif gettext intl sockets zip \
        && sed -i -e '/listen/d' /usr/local/etc/php-fpm.d/zz-docker.conf \
        && { echo 'listen = /sock/docker.sock'; } >> /usr/local/etc/php-fpm.d/zz-docker.conf
