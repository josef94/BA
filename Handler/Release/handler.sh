#Handler

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

#für While Schleife
duration=600	 	  #Dauer in Secunden
end=$((SECONDS + $duration))

#für Zeitsteuerung
startTime="122800"
endTime="132700"
isRunningVideo=false;

echo -e "$Blue Test avconv is running $OFF"

while [ 1 ]
do
if [[ ! "$((`date +"%H%M%S"`))" < "$startTime" && ! "$((`date +"%H%M%S"`))" > "$endTime" ]]
then
	isRunningVideo=true;
	if [ `pidof avconv` > "0" ]
	then
		echo -e "$Yellow Video is running $OFF"
	else
		echo -e "$Cyan Start MakeVideo: .. $OFF"
		./../../MakeVideo/makeVideo.sh
		sleep 5
	fi
else
	echo -e "$Red NOT ready for MakeVideo $OFF"
	isRunningVideo=false;
fi
	if [[ `find ../../Videos/* -maxdepth 0 -type f | wc -l` -gt "1" || ( "$isRunningVideo" = false && `pidof avconv` < "1" ) ]]
	then
	      if [ `find ../../Videos -prune -empty` ]
      	      then
                	echo -e "$Red No Videos left $OFF"
  	      else
        	        firstVideo=$(ls ../../Videos/ -tr | head -n 1)
			firstPath=${firstVideo:0:19}
	                     if [ `pidof CheckMotion` > "0" ]
           		     then
				echo -e "$Yellow CheckMotion still running $OFF"
			     else
				echo -e "$Cyan Start CheckMotion: $firstVideo $OFF"
				mkdir ../../Frames/$firstPath
			   	./../../CheckMotion/Release/CheckMotion $firstVideo $firstPath &
				sleep 2
			    fi
	       fi
	else
		echo -e "$Red NOT ready for CheckMotion $OFF"
	fi
	if [[ `find ../../Frames/* -maxdepth 0 -type d | wc -l` -gt "1" || ( "$isRunningVideo" = false && `pidof CheckMotion` < "1" ) ]]
	then
		if [ `find ../../Frames -prune -empty` ]
              	then
                        echo -e "$Red No Videos left $OFF"
              	else
			if [ `pidof VehicleCount` > "0" ]
			then
				echo -e "$Yellow VehicleCount is running $OFF"
			else
				echo -e "$Cyan VehicleCount started: $folderPath $OFF"
				folderPath=$(ls ../../Frames/ -tr | head -n 1)
               			./../../VehicleCount/Release/VehicleCount $folderPath &
			fi
		fi
	else
		echo -e "$Red NOT ready for VehicleCount $OFF"
	fi
	echo -e "$Purple ------------------------------------------- -__- $OFF"
	sleep 3
 
done

exit 0
