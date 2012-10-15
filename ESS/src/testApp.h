#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

//#include "ofxTweenzor.h"

#include "essSceneManager.h"

//create the main scenes
#include "homeScene.h"
#include "map1Scene.h"
#include "map2Scene.h"
#include "map3Scene.h"
#include "map4Scene.h"
#include "aboutScene.h"

// menu
#include "swMenu.h"

//-chien
#include "ofSwipeGestureRecognizer.h"






class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);

	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
    
    essBaseScene* scenes[SW_TOTAL_SCENES];
    
    //Managers
    essSceneManager* essSM;
    essAssetManager* essAssets;
    
    //Menu
    swMenu menu;
    
    //Swipe Detect
  
    ofSwipeGestureRecognizer *swipeDetect;
    bool swipe;
    int direction;


};


