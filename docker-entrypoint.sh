#!/bin/sh
set -x

#
#	8:07 GMT (3 AM EST)
#

cfgmaker \
	--global 'WorkDir: /home/mrtg/data' \
	--global 'Options[_]: bits,growright' \
	--output /home/mrtg/cfg/mrtg.cfg \
	--ifref=name \
	--ifdesc=name \
	public@192.168.8.1

indexmaker /home/mrtg/cfg/mrtg.cfg --output /home/mrtg/data/index.html

echo "0,5,10,15,20,25,30,35,40,45,50,55 * * * * /usr/bin/mrtg /home/mrtg/cfg/mrtg.cfg --logging /home/mrtg/logs/mrtg.log" | crontab -u mrtg -

exec crond -l 2 -f
