#FROM php:7.2-fpm
FROM php:8.1.0-fpm
# copiar composer.lock y composer.json
COPY composer.lock composer.json /var/www/

# establecer directorio de trabajo
WORKDIR /var/www

# Instalar dependencias
#RUN apk add apt-get
RUN apt-get update && apt-get install -y \
    build-essential \
    default-mysql-client \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libzip-dev\
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev 
    #\
    #npm \
    #nodejs 
# limpiar cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar extensiones mbstring
RUN docker-php-ext-install pdo_mysql  zip exif pcntl
RUN docker-php-ext-configure gd  --enable-gd --with-freetype --with-jpeg 
#--enable-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd

# Instalar composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# añadir usuario para la aplicacion laravel
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# copiar el contenido del directorio de la aplicacion existente
COPY . /var/www

#  copiar  aplicacion y establecer permisos
COPY --chown=www:www . /var/www

# cambiar usuario actual a www
USER www

# abir puerto 9000 y empezar proceso php-fpm server
EXPOSE 9000
CMD ["php-fpm"]