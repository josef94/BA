#!/bin/sh
while [ 1 ]
do
  value=$(cat /sys/class/thermal/thermal_zone0/temp)
  d=`date +%Y/%m/%d`
  d2=`date +%H:%M:%S`
  echo "$d $d2, $value" >> /var/www/html/temperatures.csv
  sleep 60
done
exit 0

