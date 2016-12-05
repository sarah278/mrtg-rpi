#!/bin/sh
set -x

cfgmaker \
	--global "WorkDir: /home/mrtg/data" \
	--global 'Options[_]: bits,growright' \
	--output /home/mrtg/cfg/$1.mrtg.cfg \
	--ifref=name \
	--ifdesc=alias \
	$2@$1
