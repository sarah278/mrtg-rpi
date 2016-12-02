FROM hypriot/rpi-alpine-scratch

RUN set -x \
        && apk update \
        && apk add mrtg \
	&& mkdir -p /home/mrtg/cfg \
	&& mkdir -p /home/mrtg/logs \
	&& mkdir -p /home/mrtg/data \
	&& adduser -S mrtg -h /home/mrtg -D -s /bin/ash \
	&& chown -R mrtg:nogroup /home/mrtg \
        && rm -rf /var/cache/apk/* 

COPY	docker-entrypoint.sh \
	generate-mrtg-config.sh \
	/usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
