# mrtg-rpi

A simple MRTG container based on Alpine. The default tag is built for x86, the rpi tag is for ARM.

To use this container, attach the following volumes:
        - /etc/localtime:/etc/localtime:ro
        - ./nodes.csv:/home/mrtg/nodes.csv:ro
        - mrtg-data:/home/mrtg/data

* Localtime is a nice-to-have for making sure timezones are in sync. Totally optional.
* nodes.csv is a file listing the nodes for MRTG to poll. The format is:
routername1,rocommunity@ipaddress
routername2,rocommunity@ipaddress

For example:
core1,public@10.119.9.1
gw1,public@10.119.9.2
distro1,public@10.119.9.20

MRTG-data is a named volume where MRTG stores its polling data.
