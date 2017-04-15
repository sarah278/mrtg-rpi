FROM ggosselin/alpine-rpi:3.5

#
#	Adding if statement to cfgmaker to detect Cisco SG300
#	and use ifAlias as the interface description.
#
COPY files/SG300.patch /tmp

RUN set -x \
        && apk --no-cache add mrtg \
	&& patch /usr/bin/cfgmaker /tmp/SG300.patch \
	&& rm /tmp/SG300.patch \
	&& adduser -S mrtg -h /home/mrtg -D 

COPY files/mrtg.cfg /home/mrtg
COPY files/docker-entrypoint.sh /usr/local/bin/

USER mrtg

RUN set -x \
	&& mkdir -p /home/mrtg/cfg /home/mrtg/data \
	&& touch /home/mrtg/cfg/nodes.csv

ENTRYPOINT ["docker-entrypoint.sh"]
