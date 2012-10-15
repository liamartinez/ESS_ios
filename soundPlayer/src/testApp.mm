#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//If you want a landscape oreintation 
	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	ofBackground(127,127,127);
    
    soundTrack.loadSound("sounds/mason.mp3");
    soundTrack.setVolume(0.75f);
    soundTrack.setMultiPlay(false);
    x = 100;
    y = 100;
    w = 100;
    h = 100;
    color = 255;
}

//--------------------------------------------------------------
void testApp::update(){

    ofSoundUpdate();

}

//--------------------------------------------------------------
void testApp::draw(){
    ofSetColor(color,0,0);
	ofRect(100,100,100,100);
}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
    
    printf("touchx:%f touchy:%f\n",touch.x,touch.y);
    if (touch.x >= x && touch.x < x+w && touch.y >= y && touch.y < y+h)  {
        color = 100;
        printf("yes\n");
        soundTrack.play();
        
    }

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}

