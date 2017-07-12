################################
#                              #
#   Ubuntu - PHP 7.0 CLI+FPM   #
#                              #
################################

FROM ubuntu:xenial

MAINTAINER Aseev Dmitriy <dimaaseev.94@gmail.com>

LABEL Vendor="z00m41k"
LABEL Description="PHP-FPM v7.0.18"
LABEL Version="1.0.0"

ENV LYBERTEAM_TIME_ZONE Europe/Kiev

## Install php7.0 extension
RUN apt-get update -yqq \
    && apt-get install -yqq \
	ca-certificates \
    git \
    gcc \
    make \
    wget \
    mc \
    curl \
    sendmail \
    php7.0-pgsql \
	php7.0-mysql \
	php7.0-opcache \
	php7.0-common \
	php7.0-mbstring \
	php7.0-mcrypt \
	php7.0-soap \
	php7.0-cli \
	php7.0-intl \
	php7.0-json \
	php7.0-xsl \
	php7.0-imap \
	php7.0-ldap \
	php7.0-curl \
	php7.0-gd  \
	php7.0-dev \
	php7.0-redis \
	php7.0-memcached \
	php7.0-mongodb \
    php7.0-imagick \
    php7.0-fpm \
    && apt-get install -y -q --no-install-recommends \
       ssmtp

# Add default timezone
RUN echo $LYBERTEAM_TIME_ZONE > /etc/timezone
RUN echo "date.timezone=$LYBERTEAM_TIME_ZONE" > /etc/php/7.0/cli/conf.d/timezone.ini

## Install composer globally
RUN echo "Install composer globally"
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Copy our config files for php7.0 fpm and php7.0 cli
COPY php-conf/php.ini /etc/php/7.0/cli/php.ini
COPY php-conf/php-fpm.ini /etc/php/7.0/fpm/php.ini
COPY php-conf/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
COPY php-conf/www.conf /etc/php/7.0/fpm/pool.d/www.conf

RUN usermod -aG www-data www-data
# Reconfigure system time
RUN  dpkg-reconfigure -f noninteractive tzdata

# Clear all packages and temp files
RUN	apt-get clean -yqq \
	&& apt-get purge php7.0-dev -yqq \
	&& apt-get purge git -yqq \
	&& apt-get purge gcc -yqq \
	&& apt-get purge make -yqq \
	&& apt-get purge wget -yqq \
	&& apt-get purge curl -yqq

RUN rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/* \
	&& apt-get clean -yqq

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]

WORKDIR /var/www/z00m41k

EXPOSE 9000
