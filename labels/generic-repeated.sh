#!/bin/bash

START=1
LOOPS=$2
EXTRA=""

for (( i=$START; i<=$LOOPS; i++ ))
do
    EXTRA="$EXTRA --pad 15 --text $1"
done

sudo ptouch-print --fontsize 40 --text $1$EXTRA
