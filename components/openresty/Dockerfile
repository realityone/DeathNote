FROM debian:jessie

ENV OPENRESTY_VERSION=1.9.7.4

RUN apt-get update \
    && apt-get install -y \
        curl \
        libreadline-dev \
        libncurses5-dev \
        libpcre3-dev \
        libssl-dev \
        perl \
        make \
        build-essential

RUN curl -o openresty-$OPENRESTY_VERSION.tar.gz https://openresty.org/download/openresty-$OPENRESTY_VERSION.tar.gz \
    && tar -xzf openresty-$OPENRESTY_VERSION.tar.gz \
    && rm -f openresty-$OPENRESTY_VERSION.tar.gz \
    && cd openresty-$OPENRESTY_VERSION \
    && ./configure --with-pcre-jit --with-ipv6 \
    && make \
    && make install \
    && cd .. \
    && rm -rf openresty-$OPENRESTY_VERSION

ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD default.conf /usr/local/openresty/nginx/conf/conf.d/default.conf

RUN mkdir -p /var/log/nginx/ \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
EXPOSE 443
CMD ["/usr/local/openresty/nginx/sbin/nginx", "-g", "daemon off;"]