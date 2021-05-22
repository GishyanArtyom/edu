#!/bin/bash

# There thow cut command is for normal script behavior in different bash versions.
grep '^[A-Za-z]' /etc/services | cut -d' ' -f1 | cut -f1 | sort --unique > $HOME/uniqueservices.txt && nl $HOME/uniqueservices.txt
