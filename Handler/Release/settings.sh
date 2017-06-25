#!/bin/bash

if [ ! -d /tmp/videoStart ]
 then
   export LD_LIBRARY_PATH=/usr/local/lib
   mjpg_streamer -i "input_uvc.so -d /dev/video0" -o "output_http.so -p 8080 -w /usr/local/www" &
fi
