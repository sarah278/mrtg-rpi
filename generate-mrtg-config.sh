#!/bin/sh
set -x

cfgmaker \
	--global "WorkDir: /home/mrtg/data" \
	--global 'Options[_]: bits,growright' \
	--output /home/mrtg/cfg/$1.mrtg.cfg \
	--ifref=name \
	--ifdesc=alias \
	$2@$1

indexmaker /home/mrtg/cfg/$1.mrtg.cfg --output /home/mrtg/data/$1.html
