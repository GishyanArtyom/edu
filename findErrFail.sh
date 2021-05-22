#!/bin/bash

# Find any line that contain sequences 'fail' or 'err' case insensitive from ARGUMENT_1
# and write to given ARGUMENT_2
# Must invoke findErrFail.sh FILE_1 FILE_2

nl $1 | egrep -i 'fail|err' >> $2
