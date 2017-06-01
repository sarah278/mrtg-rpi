#!/bin/sh
set -x

#
#	Read nodes.csv. For each line, parse out the
#	nodename and nodesnmp fields. Execute cfgmaker
#	for each node. Use grep for a simple report.
#

while IFS=',' read -r nodename nodesnmp
do

	#
	#	Keep global options bits before output
	#	or the max speed appears as bytes.
	#
	cfgmaker \
		--global "Options[_]: bits,growright,logscale" \
		--output /home/mrtg/cfg/$nodename.cfg \
		--ifref=name,nr \
		--ifdesc=alias \
		$nodesnmp \
	2>/dev/null

	#
	#	So we can see in the docker logs if polling succeeded.
	#
	grep '^Title' /home/mrtg/cfg/$nodename.cfg

done </home/mrtg/cfg/nodes.csv


#
#	Creates a simple static html page.
#
indexmaker /home/mrtg/mrtg.cfg --output /home/mrtg/data/index.html


echo "NOTE: Rateup warnings are normal the first time a target is polled."
exec /usr/bin/mrtg /home/mrtg/mrtg.cfg
