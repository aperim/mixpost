FROM httpd:alpine

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG VCS_URL

LABEL org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.url="https://github.com/aperim/mixpost" \
    org.opencontainers.image.source=$VCS_URL \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.vendor="Aperim" \
    org.opencontainers.image.title="Mixpost" \
    org.opencontainers.image.description="Mixpost in a container" \
    org.opencontainers.image.licenses="UNLICENSED" \
    maintainer="hello@aperim.com"

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    bash \
    composer \
    composer-zsh-completion \
    dcron \
    dcron-openrc \
    geoip \
    geoip-dev \
    imagemagick \
    openrc \
    php81-apache2 \
    php81-curl \
    php81-dom \
    php81-exif \
    php81-fileinfo \
    php81-fpm \
    php81-gd \
    php81-mysqli \
    php81-openssl \
    php81-pcntl \
    php81-pdo_mysql \
    php81-pecl-redis \
    php81-posix \
    php81-session \
    php81-tokenizer \
    php81-xml \
    php81-xmlwriter \
    php81-zip \
    shadow \
    supervisor \
    vim \
    zsh \
    && rm -rf /var/cache/apk/*

RUN sed -i \
    -e 's/^#\(Include .*httpd-vhosts.conf\)/\1/' \
    -e 's/^#\(LoadModule .*mod_proxy.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_proxy_fcgi.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_rewrite.so\)/\1/' \
    -e 's/DirectoryIndex index.html/DirectoryIndex index.php index.html/' \
    -e 's/\/proc\/self\/fd\/2/\/proc\/1\/fd\/2/g' \
    -e 's/\/proc\/self\/fd\/1/\/proc\/1\/fd\/2/g' \
    /usr/local/apache2/conf/httpd.conf

COPY rootfs /

ARG MIXPOST_VERSION=^1.0
ENV MIXPOST_VERSION=$MIXPOST_VERSION
ENV APP_PORT=80

WORKDIR /var/www/html

CMD ["/usr/local/sbin/start"]