#!/bin/bash

#Variable Storage

IDRACIP="$IP_HERE$"
IDRACUSER="$USER$"
IDRACPASSWORD="$PASSWORD$"
TEMPTHRESHOLD="27"

#This uses ipmitool sdr to get current variables and then trims the object down to just be the ambient temerature value

echo "Current temperature is..."
T=$(ipmitool -I lanplus -H $IDRACIP -U $IDRACUSER -P $IDRACPASSWORD sdr type temperature | grep Ambient | cut -d"|" -f5 | cut -d" " -f2)
echo $T
sleep 1

if [[ $T > $TEMPTHRESHOLD ]]
  then
    #This disables manual speed control because the server is above the pre-set ambient temperature threshold
    echo "Enabling Authomatic Fan Control"
    ipmitool -I lanplus -H $IDRACIP -U $IDRACUSER -P $IDRACPASSWORD raw 0x30 0x30 0x01 0x01
  else
  	#This sets the manual speed control because the server is bellow the pre-set ambient temperature threshold
    echo "Disabling Automatic Fan Control"
    ipmitool -I lanplus -H $IDRACIP -U $IDRACUSER -P $IDRACPASSWORD raw 0x30 0x30 0x01 0x00
    sleep 2
    #This sets the manual fan speed 
    echo "Setting Fan Speed"
    ipmitool -I lanplus -H $IDRACIP -U $IDRACUSER -P $IDRACPASSWORD raw 0x30 0x30 0x02 0xff 0x0a
fi

sleep 1
echo "You're Handsome"
#duh
