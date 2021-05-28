#!/bin/bash
# Find any sequence like number.number.number.number template from given ARGUMNET
# Must invoke find4octnum.sh FILE

egrep  --color=auto '([0-9]+\.){3}[0-9]' $1 | egrep -v '([0-9]+\.){5,}'




