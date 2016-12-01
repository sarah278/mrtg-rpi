FROM hypriot/rpi-alpine-scratch

RUN set -x \
        && apk update \
        && apk add apache2 \
        && rm -rf /var/cache/apk/* 

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
