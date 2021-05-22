#!/bin/bash

# Find lines that contain IPv4 adresses from given ARGUMENT
# Must invoke findIPv4.sh FILE

exp='(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])'
egrep "($exp\.){3}$exp[^0-9]" $1 | egrep -v "($exp\.){5,}"
