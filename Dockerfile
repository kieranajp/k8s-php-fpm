FROM php:7.2-fpm-alpine

# Install application/service
ENV APP_DIR /server/http/
WORKDIR ${APP_DIR}
COPY . ${APP_DIR}

RUN set -ex \
    ## Customize PHP fpm configuration
    && sed -i -e "s/;clear_env\s*=\s*no/clear_env = no/g" /usr/local/etc/php-fpm.conf \
    && sed -i -e "s/;request_terminate_timeout\s*=[^\n]*/request_terminate_timeout = 300/g" /usr/local/etc/php-fpm.conf \
    && php-fpm --test

