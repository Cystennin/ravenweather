#!/bin/bash

# Update Satellite Information

wget -qr https://www.celestrak.com/NORAD/elements/weather.txt -O /home/pi/wx-ground-station/weather.txt
grep "NOAA 15" /home/pi/wx-ground-station/weather.txt -A 2 > /home/pi/wx-ground-station/weather.tle
grep "NOAA 18" /home/pi/wx-ground-station/weather.txt -A 2 >> /home/pi/wx-ground-station/weather.tle
grep "NOAA 19" /home/pi/wx-ground-station/weather.txt -A 2 >> /home/pi/wx-ground-station/weather.tle



#Remove all AT jobs

for i in `atq | awk '{print $1}'`;do atrm $i;done

rm -f /home/pi/wx-ground-station/upcoming_passes.txt

#Schedule Satellite Passes:

/home/pi/wx-ground-station/schedule_satellite.sh "NOAA 19" 137.1000
/home/pi/wx-ground-station/schedule_satellite.sh "NOAA 18" 137.9125
/home/pi/wx-ground-station/schedule_satellite.sh "NOAA 15" 137.6200

node /home/pi/wx-ground-station/aws-s3/upload-upcoming-passes.js /home/pi/wx-ground-station/upcoming_passes.txt
