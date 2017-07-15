#!/bin/bash
HOSTNAME="${COLLECTD_HOSTNAME:-$(/bin/hostname -s)}"
INTERVAL="${COLLECTD_INTERVAL:-60}"
PLUGIN='fail2ban-jails'

FAIL2BAN_STATUS=$(fail2ban-client status)

JAIL_LIST=$(fail2ban-client status | awk '/Jail list/{print}' | sed -r -e 's/^.*Jail list:[\t ]+//' -e 's/, ?/ /g')
for jail in  ${JAIL_LIST};
do
	JAIL_BANNED=$(fail2ban-client status ${jail} | grep 'Currently banned' | sed -r -e 's/^[^:]+:[ \t]*//')
	formatted_jail=${jail//-/.}
	formatted_plugin=${PLUGIN//-/.}
	printf "PUTVAL %s/%s-%s/gauge interval=%s N:%s\n" ${HOSTNAME} ${formatted_plugin} ${formatted_jail} ${INTERVAL} ${JAIL_BANNED}
done
