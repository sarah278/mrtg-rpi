# mrtg-rpi

A simple MRTG container based on Alpine. The default tag is built for x86, the rpi tag is for ARM.

To use this container, attach the following volumes:

~~~~
        - /etc/localtime:/etc/localtime:ro  
        - /etc/timezone:/etc/timezone:ro  
        - nodes.csv:/home/mrtg/nodes.csv:ro  
        - mrtg-data:/home/mrtg/data  
~~~~

Localtime/timezone are nice-to-haves for making sure timezones are in sync. Totally optional.  
The nodes.csv is a file listing the nodes for MRTG to poll. The format is:  
~~~~
routername1,rocommunity@ipaddress  
routername2,rocommunity@ipaddress  
~~~~
For example:  
~~~~
core1,public@10.119.9.1  
gw1,public@10.119.9.2  
distro1,public@10.119.9.20  
~~~~

MRTG-data is a named volume where MRTG stores its polling data.

*Startup*
Upon startup the nodes.csv file is read and each node is queried by cfgmaker. A new ~/cfg/nodename.cfg file is created.
A printout of active targets (interfaces) is shown after each cfgmaker run for debugging purposes. It can be seen with docker logs <containername>.
After all node configs have been created, indexmaker is run to generate a static index.html file in ~/data/.
MRTG is then launched in foreground mode. The default polling cycle if 5 minutes.
MRTG data is stored in log format, not RRD.

You need a web server for displaying the index.html and graphs. A simple NGINX install will do.

Mount mrtg-data to an NGINX container:  

~~~~
        - mrtg-data:/mnt/mrtg:ro
~~~~

and use a simple file in conf.d to display it:  

~~~~
server {
        server_name mrtg;
        root /mnt/mrtg;
        location / {
        }
}
~~~~
