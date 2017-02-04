#!/bin/bash

PLUGIN_DIR=nagios-plugins-hancock/usr/lib/nagios/plugins
mkdir -p $PLUGIN_DIR

for p in nagios-memory nagios-cpu nagios-html-email nagios-puppet nagios-apache nagios-mysql nagios-redis nagios-iops nagios-slack nagios-elasticsearch
do
    wget -q -O $p.tar.gz https://github.com/jasonhancock/$p/archive/master.tar.gz
    mkdir $p
    tar --strip-components=1 -xvzf $p.tar.gz -C $p
    install -m 0755 */plugins/* $PLUGIN_DIR/
    rm -rf $p*
done
