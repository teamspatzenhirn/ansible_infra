#!/bin/bash

remaining_attemps=20

while (( remaining_attemps-- > 0 ))
do
	host -W1 $1 && ping -c1 -W1 $1 && exit
    	sleep 1
done

exit 1
