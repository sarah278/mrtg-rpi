FROM registry.snafui.com:5000/alpine:3.5-armhf

#
#	Adding if statement to cfgmaker to detect Cisco SG300
#	and use ifAlias as the interface description.
#

COPY files/SG300.patch /tmp
COPY files/docker-entrypoint.sh /usr/local/bin/

RUN set -x \
        && apk --no-cache add mrtg \
	&& adduser -S mrtg -h /home/mrtg -D  \
	&& patch /usr/bin/cfgmaker /tmp/SG300.patch \
	&& rm /tmp/SG300.patch \
	&& chmod +x /usr/local/bin/docker-entrypoint.sh

COPY files/mrtg.cfg /home/mrtg
USER mrtg
WORKDIR /home/mrtg

RUN set -x \
	&& mkdir -p /home/mrtg/cfg /home/mrtg/data \
	&& touch /home/mrtg/cfg/nodes.csv

ENTRYPOINT ["docker-entrypoint.sh"]
