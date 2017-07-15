#!/bin/bash

FAIL2BAN_STATUS=$(fail2ban-client status)

JAIL_LIST=$(echo "${FAIL2BAN_STATUS}" | awk '/Jail list/{print}' | sed -r 's/^.*Jail list:[\t ]+//'|awk 'BEGIN{RS=","}{print}')
echo ${JAIL_LIST}
