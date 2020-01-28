FROM alpine:3.11.3

MAINTAINER Vasyl Plesiuk <v.plesuk@dev-company.com>

RUN set -e \
  && apk add --no-cache \
  curl \
  git \
  php7 \
  php7-json \
  php7-mbstring \
  php7-openssl \
  php7-phar \
  php7-simplexml \
  php7-tokenizer \
  php7-iconv \
  php7-xmlwriter \
  && curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin \
  && composer global require drupal/coder --update-no-dev --no-suggest --prefer-dist ^8.3.2 \
  && ln -s /root/.composer/vendor/bin/phpcs /usr/bin/phpcs \
  && ln -s /root/.composer/vendor/bin/phpcbf /usr/bin/phpcbf \
  && ln -s /root/.composer/vendor/drupal/coder/coder_sniffer/Drupal /root/.composer/vendor/squizlabs/php_codesniffer/src/Standards/Drupal \
  && ln -s /root/.composer/vendor/drupal/coder/coder_sniffer/DrupalPractice /root/.composer/vendor/squizlabs/php_codesniffer/src/Standards/DrupalPractice \
  && apk del --no-cache git curl \
  && rm -rf /root/.composer/cache/* \
  && sed -i "s/.*memory_limit = .*/memory_limit = -1/" /etc/php7/php.ini

VOLUME /work
WORKDIR /work

CMD ["phpcs", "--standard=Drupal,DrupalPractice", "."]
