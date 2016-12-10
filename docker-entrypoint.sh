#!/bin/sh
set -x

echo "Include: /home/mrtg/cfg/*.cfg" > /home/mrtg/mrtg.cfg

grep SG300 /usr/bin/cfgmaker || \
	sed -i '/my $descr = $routers->{$router}{deviceinfo}{sysDescr};/a push @Variables, "ifAlias" if $descr =~ /SG300/;' /usr/bin/cfgmaker

/usr/local/bin/generate-mrtg-config.sh 192.168.8.1 public
/usr/local/bin/generate-mrtg-config.sh 192.168.2.2 public

indexmaker /home/mrtg/mrtg.cfg --output /home/mrtg/data/index.html
chown -R mrtg:nogroup /home/mrtg

echo "3 * * * * /usr/local/bin/generate-mrtg-config.sh 192.168.8.1 public" >> /tmp/crontab
echo "7 * * * * /usr/local/bin/generate-mrtg-config.sh 192.168.2.2 public" >> /tmp/crontab
echo "0,5,10,15,20,25,30,35,40,45,50,55 * * * * /usr/bin/mrtg /home/mrtg/mrtg.cfg --logging /home/mrtg/logs/mrtg.log" >> /tmp/crontab

cat /tmp/crontab | crontab -u mrtg -
exec crond -l 2 -f
