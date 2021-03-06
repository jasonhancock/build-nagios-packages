#!/bin/bash

PLUGIN_DIR=nagios-plugins-hancock/usr/lib/nagios/plugins
mkdir -p $PLUGIN_DIR

export GOPATH=/tmp/go
go get gopkg.in/olivere/elastic.v5
go get github.com/aws/aws-sdk-go
go get github.com/pkg/errors
go get github.com/matryer/m
go get github.com/jasonhancock/go-nagios
go get github.com/jasonhancock/nagios-aws-config/...
go get github.com/jasonhancock/nagios-elk/...
go get github.com/jasonhancock/nagios-goversion/...
go get github.com/jasonhancock/nagios-graphite/...
go get github.com/jasonhancock/nagios-healthz/...
go get github.com/jasonhancock/nagios-http-redirect/...
go get github.com/jasonhancock/nagios-nomad/...
install -m 0755 $GOPATH/bin/check_aws_config_aggregator $PLUGIN_DIR/
install -m 0755 $GOPATH/bin/check_elk_message $PLUGIN_DIR/
install -m 0755 $GOPATH/bin/check_goversion $PLUGIN_DIR/
install -m 0755 $GOPATH/bin/check_graphite $PLUGIN_DIR/
install -m 0755 $GOPATH/bin/check_healthz $PLUGIN_DIR/
install -m 0755 $GOPATH/bin/check_healthz_compare $PLUGIN_DIR/
install -m 0755 $GOPATH/bin/check_http_redirect $PLUGIN_DIR/
install -m 0755 $GOPATH/bin/check_nomad_unplaceable_jobs $PLUGIN_DIR/
install -m 0755 $GOPATH/bin/check_nomad_long_running $PLUGIN_DIR/

for p in nagios-memory nagios-cpu nagios-html-email nagios-puppet nagios-apache nagios-mysql nagios-redis nagios-iops nagios-slack nagios-elasticsearch
do
    wget -q -O $p.tar.gz https://github.com/jasonhancock/$p/archive/master.tar.gz
    mkdir $p
    tar --strip-components=1 -xvzf $p.tar.gz -C $p
    install -m 0755 */plugins/* $PLUGIN_DIR/
    rm -rf $p*
done
