#!/bin/bash

set -eu

echo "Configuring postfix"

postconf -e "inet_protocols = ipv4"
postconf -e "maillog_file = /dev/stdout"
postconf -e "mydestination = localhost.localdomain, localhost"
# postconf -e "mydomain = ${mydomain}"
# postconf -e "myhostname = ${myhostname:-mail}.${mydomain}"
postconf -e "mynetworks = ${MYNETWORKS:-172.16.0.0/12}"
# postconf -e "myorigin = ${mydomain}"
postconf -e "relayhost = [${RELAYHOST}]:${RELAYPORT:-587}"
postconf -e "smtp_host_lookup = native,dns"
postconf -e "smtp_use_tls = yes"
# echo "nameserver 1.1.1.1" > /var/spool/postfix/etc/resolv.conf
# echo "nameserver 1.1.1.1" > /etc/resolv.conf

echo "Starting postfix"
exec /usr/sbin/postfix start-fg