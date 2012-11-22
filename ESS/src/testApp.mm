//  modified by Chien on 10/15/12.


#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
    
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	//If you want a landscape oreintation 
	iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
//    iPhoneSetOrientation(OFXIPHONE_ORIENTATION_PORTRAIT);
	
	ofBackground(0,0,0);
    
    //Load Assets
    essAssets = essAssetManager::getInstance();
    if(essAssets->loadData()) {
        essAssets->loadFonts();
        
        //setup scene manager/Scenes
        essSM = essSceneManager::getInstance();
        
        scenes[SCENE_HOME]      = new homeScene();
        scenes[SCENE_MAP1]      = new map1Scene();
        scenes[SCENE_MAP2]      = new map2Scene();
        scenes[SCENE_MAP3]      = new map3Scene();
        scenes[SCENE_MAP4]      = new map4Scene();
        scenes[SCENE_ABOUT]     = new aboutScene();
        
        
        try {
            for(int i=0; i<SW_TOTAL_SCENES; i++) {
                scenes[i]->setup();
            }
        } catch(string error) {
            cout << "View not intitialized! Please make sure every scene is created above!" << endl;
        }
    } else {
        cout << "Could not load the data!" << endl;
    }

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

    
    //Chien-Swipe Detect
    EAGLView *view = ofxiPhoneGetGLView();  
    swipeDetect = [[ofSwipeGestureRecognizer alloc] initWithView:view];
    swipe = 0;
    
	/*
    //Reset
    for(int i=0; i<SW_TOTAL_SCENES; i++) {
        scenes[i]->resetPlayed();
    }

    */
    //MainAudio Track
    volume = 1.0f;
	
    mainAudio.setMultiPlay(true); 
    mainAudio.setVolume(volume);
    mainAudio.loadSound("sounds/Master_fCaf.caf");
    mainAudio.setLoop(true);
    mainAudio.play();

    

}

//--------------------------------------------------------------
void testApp::update(){
    ofSoundUpdate();


	if (!essSM->getIsDragging()) { //only work when overlay didn't show up
		if (swipeDetect->swipe == 1) {
			cout<<"HE DID SWIPE"<<endl;
			if (essSM->getCurScene()==1 ) {
				if (swipeDetect->direction == 2) {
					essSM->setCurScene(SCENE_MAP2); 
				}
			}else if (essSM->getCurScene()==2) {
				if (swipeDetect->direction == 2) {
					essSM->setCurScene(SCENE_MAP3);  
				}else{
					essSM->setCurScene(SCENE_MAP1); 
				}

			}else if (essSM->getCurScene()==3) {
				if (swipeDetect->direction == 2) {
					essSM->setCurScene(SCENE_MAP4);  
				}else{
					essSM->setCurScene(SCENE_MAP2); 
				}

			}else if (essSM->getCurScene()==4) {
				if (swipeDetect->direction == 1) {
					essSM->setCurScene(SCENE_MAP3);  
				}        
			}
			swipeDetect->swipe = 0;
		}
        
        
	  }else {
  	  swipeDetect->swipe = 0;
          
      }
    
    
    
    
    //-----Main Audio Fade In & Out----------------------------
    volumeInc = 0.01;
    if (essSM->getIsDragging()){//If someone start to listen to a track, the sound fade out
        if(volume > 0.3f) volume = volume-volumeInc;
        
    }else{//If someone end a track, the sound fade in

        if(volume < 1.0f) volume = volume+volumeInc;
    }
    mainAudio.setVolume(volume);


    if(essSM->getCurSceneChanged()) {
        for(int i=0; i<SW_TOTAL_SCENES; i++) {
            scenes[i]->deactivate();
    
        }
        scenes[essSM->getCurScene()]->activate();
        
    }
    scenes[essSM->getCurScene()]->update();


     

}

//--------------------------------------------------------------
void testApp::draw(){
    
    if(!essSM->getCurSceneChanged(false)) {
        scenes[essSM->getCurScene()]->draw();
    }
     
}

//--------------------------------------------------------------
void testApp::exit(){
    
     [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
	mainAudio.stop();
	mainAudio.unloadSound();
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
    
    scenes[essSM->getCurScene()]->touchDown(touch);
    

     
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
    scenes[essSM->getCurScene()]->touchMoved(touch);

     
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    
    scenes[essSM->getCurScene()]->touchUp(touch);

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::lostFocus(){
	mainAudio.stop();
	mainAudio.unloadSound();
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


//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){

}

//---------------------------------------------------------
void testApp::keyPressed(int key){
    
    if (key == 'h'){
        iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT); // do something
    } else if (key == 'v'){
        iPhoneSetOrientation(OFXIPHONE_ORIENTATION_PORTRAIT); // do something else
    }
}

