#! /bin/bash

sudo service ntp stop
sudo ntpd -gq
sudo service ntp start
/opt/voltdb/bin/voltdb init -f -C deployment.xml

if [ $1 -eq 1 ]; then
  /opt/voltdb/bin/voltdb start -B
else
  /opt/voltdb/bin/voltdb start -B --count=$1 --host=$2
fi
