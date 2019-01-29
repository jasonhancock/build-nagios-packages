Packages the following projects into an RPM and a debian archive:

* [nagios-apache](https://github.com/jasonhancock/nagios-apache)
* [nagios-aws-config](https://github.com/jasonhancock/nagios-aws-config)
* [nagios-cpu](https://github.com/jasonhancock/nagios-cpu)
* [nagios-elasticsearch](https://github.com/jasonhancock/nagios-elasticsearch)
* [nagios-goversion](https://github.com/jasonhancock/nagios-goversion)
* [nagios-graphite](https://github.com/jasonhancock/nagios-graphite)
* [nagios-healthz](https://github.com/jasonhancock/nagios-healthz)
* [nagios-html-email](https://github.com/jasonhancock/nagios-html-email)
* [nagios-http-redirect](https://github.com/jasonhancock/nagios-http-redirect)
* [nagios-memory](https://github.com/jasonhancock/nagios-memory)
* [nagios-mysql](https://github.com/jasonhancock/nagios-mysql)
* [nagios-nomad](https://github.com/jasonhancock/nagios-nomad)
* [nagios-puppet](https://github.com/jasonhancock/nagios-puppet)
* [nagios-redis](https://github.com/jasonhancock/nagios-redis)

To build the RPM, you need to have docker installed, then run:
```
make
```

This will build a Docker container, then build everyting inside the container.

Two RPMs will be generated:

* nagios-plugins-hancock: The plugins to be installed on the edge servers
* nagios-plugins-hancock-pnp4nagios: The pnp4nagios configurations to be installed on the Nagios server
