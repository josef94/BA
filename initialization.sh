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

############################# Update & Upgrade #############################
echo -e  "$Cyan Update... $OFF"
sudo apt-get -y -q update
echo -e "$Cyan Upgrade... $OFF"
sudo apt-get -y -q upgrade

############################# Ordnerstruktur #############################
echo -e "$Cyan Ordnerstruktur erstellen... $Off"
cd /BA
if [ ! -d /BA/Crops ]
then
  mkdir /BA/Crops
fi

if [ ! -d /BA/Frames ]
then
  mkdir /BA/Frames
fi

if [ ! -d /BA/Videos ]
then
  mkdir /BA/Videos
fi

############################# OpenCV  #############################
echo -e "$Cyan Installing OpenCV... $OFF"
if ! dpkg --get-selections | grep -q build-essential
then
  echo -e "$Yellow build-essential $OFF"
  sudo apt-get -y -q install build-essential
fi

if ! dpkg --get-selections | grep -q cmake
then
  echo -e "$Yellow cmake $OFF"
  sudo apt-get -y -q install cmake
fi

if ! dpkg --get-selections | grep -q git
then
  echo -e "$Yellow git $OFF"
  sudo apt-get -y -q install git
fi

if ! dpkg --get-selections | grep -q libgtk2.0-dev
then
  echo -e "$Yellow libgtk2.0-dev $OFF"
  sudo apt-get -y -q install libgtk2.0-dev
fi

if ! dpkg --get-selections | grep -q pkg-config
then
  echo -e "$Yellow pkg-config $OFF"
  sudo apt-get -y -q install pkg-config
fi

if ! dpkg --get-selections | grep -q libavcodec-dev
then
  echo -e "$Yellow libavcodec-dev $OFF"
  sudo apt-get -y -q install libavcodec-dev
fi

if ! dpkg --get-selections | grep -q libavformat-dev
then
  echo -e "$Yellow libavformat-dev $OFF"
  sudo apt-get -y -q install libavformat-dev
fi

if ! dpkg --get-selections | grep -q libswscale-dev
then
  echo -e "$Yellow libswscale-dev $OFF"
  sudo apt-get -y -q install libswscale-dev
fi

if ! pkg-config --exists opencv
then
  echo -e "$Yellow OpenCV $OFF"
  if [ ! -d ~/opencv ]
  then
  cd ~/
  git clone https://github.com/josef94/opencv.git
  fi

  if [ -d ~/opencv/build ]
  then
    if [ ! -d ~/opencv/build/CMakeFiles ]
    then
    cd ~/opencv/build
    chmod +x buildOpenCV
    ./buildOpenCV
    fi

    if [[ -d ~/opencv/build/CMakeFiles && ! -f ~/opencv/build/Makefile ]]
    then
    cd ~/opencv/build
    make
    fi

    if [ -f ~/opencv/build/Makefile ]
    then
    cd ~/opencv/build
    sudo make install
    echo -e "$Yellow OpenCV successfully installed $OFF"
    fi
  fi
fi

############################# avconv #############################
echo -e "$Cyan Installing Avconv... $OFF"
if ! dpkg --get-selections | grep -q libav-tools
then
  echo -e "$Yellow avconv $OFF"
  sudo apt-get -y -q install libav-tools
fi

############################# apache2 #############################
echo -e "$Cyan Installing Apache2... $OFF"
if ! dpkg --get-selections | grep -q apache2
then
  echo -e "$Yellow apache2 $OFF"
  sudo apt-get -y -q install apache2
fi

############################# mjpg-streamer #############################
echo -e "$Cyan Installing Mjpg-streamer... $OFF"
if ! dpkg --get-selections | grep -q libjpeg-dev
then
  echo -e "$Yellow libjpeg-dev $OFF"
  sudo apt-get -y -q install libjpeg-dev
fi

if ! dpkg --get-selections | grep -q imagemagick
then
  echo -e "$Yellow imagemagick $OFF"
  sudo apt-get -y -q install imagemagick
fi

if ! dpkg --get-selections | grep -q subversion
then
  echo -e "$Yellow subversion $OFF"
  sudo apt-get -y -q install subversion
fi

if ! dpkg --get-selections | grep -q libv4l-dev
then
  echo -e "$Yellow libv4l-dev $OFF"
  sudo apt-get -y -q install libv4l-dev
fi

if ! dpkg --get-selections | grep -q checkinstall
then
  echo -e "$Yellow checkinstall $OFF"
  sudo apt-get -y -q install checkinstall
fi

if ! dpkg --get-selections | grep -q mjpg-streamer
then
  echo -e "$Yellow mjpg-streamer $OFF"
  if [ ! -d ~/mjpg-streamer ]
  then
    cd ~
    svn co svn://svn.code.sf.net/p/mjpg-streamer/code/ mjpg-streamer
  fi

  if [ -d ~/mjpg-streamer/mjpg-streamer ]
  then
    cd ~/mjpg-streamer/mjpg-streamer
    make USE_LIBV4L2=true
    sudo make install
  fi

  if [ ! -f /BA/mjpgStreamerTemp ]
  then
    mv /BA/mjpgStreamerTemp /BA/Crops/
    cd /BA/Crops
    mv mjpgStreamerTemp rc.local
    echo -e "$Yellow Mjpg-streamer successfully installed $OFF"
  fi
fi


############################# Make all #############################
echo -e "$Cyan Make all... $OFF"
if [ -d /BA/CheckMotion/Release ]
then
  cd /BA/CheckMotion/Release
  if [ ! -d /BA/CheckMotion/Release/CMakeFiles ]
  then
  cmake .
  fi

  if [ -d /BA/CheckMotion/Release/CMakeFiles ]
  then
  make clean
  make all
  fi
fi

if [ -d /BA/VehicleCount/Release ]
then
  cd /BA/VehicleCount/Release
  if [ ! -d /BA/VehicleCount/Release/CMakeFiles ]
  then
  cmake .
  fi

  if [ -d /BA/VehicleCount/Release/CMakeFiles ]
  then
  make clean
  make all
  fi
fi

############################# chmod  #############################
echo -e "$Cyan chmod... $OFF"
if [ -f /BA/MakeVideo/makeVideo.sh ]
  then
  chmod +x /BA/MakeVideo/makeVideo.sh
  fi

if [ -f /BA/Handler/Release/handler.sh ]
  then
  chmod +x /BA/Handler/Release/handler.sh
  fi

echo -e "$Green Finished $OFF"
