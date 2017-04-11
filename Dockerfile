FROM armhf/alpine:3.5
LABEL architecture="ARMv7"

#
#	cfgmaker doesn't distinguish between normal Cisco IOS and Cisco IOS on SG300.
#	The sed tweak helps with the interface descriptions.
#	Someday I'll relearn how to do this with patch.
#

RUN set -x \
        && apk --no-cache add mrtg \
	&& adduser -S mrtg -h /home/mrtg -D -s /bin/ash \
	&& sed -i '/my $descr = $routers->{$router}{deviceinfo}{sysDescr};/a push @Variables, "ifAlias" if $descr =~ /SG300/;' /usr/bin/cfgmaker

COPY docker-entrypoint.sh /usr/local/bin/
COPY mrtg.cfg /home/mrtg

USER mrtg

RUN set -x \
	&& mkdir -p /home/mrtg/cfg /home/mrtg/data \
	&& touch /home/mrtg/nodes.csv

ENTRYPOINT ["docker-entrypoint.sh"]
