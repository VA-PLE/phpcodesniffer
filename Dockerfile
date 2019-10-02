FROM alpine:3.10.2

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.schema-version="1.0" \
  org.label-schema.name="phpcodesniffer" \
  org.label-schema.description="PHP codesniffer for Drupal - phpcs & phpcbf"

RUN set -e \
  && apk add --no-cache \
  curl \
  git \
  patch \
  php7 \
  php7-apcu \
  php7-ctype \
  php7-dom \
  php7-json \
  php7-mbstring \
  php7-opcache \
  php7-openssl \
  php7-phar \
  php7-simplexml \
  php7-tokenizer \
  php7-xml \
  php7-xmlwriter \
  && curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin \
  && composer global require drupal/coder --update-no-dev --no-suggest --prefer-dist ^8.3.2 \
  && ln -s /root/.composer/vendor/bin/phpcs /usr/bin/phpcs \
  && ln -s /root/.composer/vendor/bin/phpcbf /usr/bin/phpcbf \
  && ln -s /root/.composer/vendor/drupal/coder/coder_sniffer/Drupal /root/.composer/vendor/squizlabs/php_codesniffer/src/Standards/Drupal \
  && ln -s /root/.composer/vendor/drupal/coder/coder_sniffer/DrupalPractice /root/.composer/vendor/squizlabs/php_codesniffer/src/Standards/DrupalPractice \
  && apk del --no-cache git \
  && rm -rf /root/.composer/cache/* \
  && sed -i "s/.*memory_limit = .*/memory_limit = -1/" /etc/php7/php.ini

VOLUME /work
WORKDIR /work

CMD ["phpcs", "--standard=Drupal,DrupalPractice", "."]
