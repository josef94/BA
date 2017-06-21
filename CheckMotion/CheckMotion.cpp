#include <iostream>
#include <stdio.h>
#include <ctime>

#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/videoio.hpp>

using namespace cv;
using namespace std;

string framePath = "../../Frames/";
string videoPath = "../../Videos/";
string video;
string frames;

int main(int argc, char* argv[]) {

	video = videoPath + argv[1];
	cout << video << endl;
	frames = framePath + argv[2] +"/";
	
	VideoCapture cap(video); // open the default camera
	if (!cap.isOpened()){  // check if we succeeded
		cout << "video not opened" << endl;
		return -1;
	}
	int i = 0;
	char file[256];
	Mat pic1, pic2, dif;
	cap >> pic1;
	cap >> pic2;
	dif = pic1.clone();
	while(!pic2.empty()&&!pic1.empty()){
		dif = pic1 - pic2;
		double s = sum(dif)[0];
		if (s > 1000000) {
			sprintf(file, "pic%05i.tif", i);
			imwrite(frames + file, pic1);
		}

		if (i & 1) {
			cap >> pic2;
		}
		else {
			cap >> pic1;
		}
		i++;
	}

	if( remove(video.c_str()) != 0 ) {
    		cout << "Error deleting file" << endl;
  	} 
	else {
    		cout <<  "File successfully deleted" << endl;
	}
	return 0;
}
