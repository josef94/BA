#video abspeichern 
# Reset
OFF='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

#Datum 
d=`date +%d.%m.%Y_%H.%M.%S`

#sudo taskset 1 avconv -f oss -i /dev/dsp -f video4linux2 -t 00:00:30 -s 640*480 -i /dev/video0 -an ../Videos/$d.avi &
#sudo taskset 1 avconv -v quiet -f oss -f video4linux2 -t 00:15:00 -s 640*480 -i /dev/video0 -an /BA/Videos/$d.avi &
#sudo taskset 1 avconv -v quiet -f video4linux2 -s 640x480 -t 00:15:00 -i /dev/video0 -vb 8000k /BA/Videos/$d.avi &
sudo taskset 1 avconv -v quiet -f video4linux2 -s 640x480 -r 25 -t 00:15:00 -i /dev/video0 -qscale:v 4 /BA/Videos/$d.avi &