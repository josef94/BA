#Nach der Installation des Betriebssystemes ausführen

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

echo -e  "$Cyan Update $OFF"
sudo apt-get -y -q update
echo -e "$Cyan Upgrade $OFF"
sudo apt-get -y -q upgrade

echo -e "$Cyan Install OpenCV $OFF"
sudo apt-get -y -q install build-essential
sudo apt-get -y -q install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
cd ../../
git clone https://github.com/josef94/opencv.git
cd opencv/build
chmod +x buildOpenCV
./buildOpenCV
make 
sudo make install
echo -e "$Yellow OpenCV successfully installed $OFF"

echo -e "$Cyan Make all $OFF"
cd /BA/CheckMotion/Release
cmake .
make clean 
make all 

cd /BA/VehicleCount/Release
cmake .
make clean 
make all
echo -e "$Yellow Make all finished $OFF"

echo -e "$Cyan chmod +x $OFF"
cd /BA/
chmod +x MakeVideo/makeVideo.sh
chmod +x Handler/Release/handler.sh
echo -e "$Cyan chmod +x $OFF"







echo -e "$Green Finished"
