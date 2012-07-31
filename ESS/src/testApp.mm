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
	
	ofBackground(127,127,127);
    
    //Load Assets
    swAssets = swAssetManager::getInstance();
    if(swAssets->loadData()) {
        swAssets->loadFonts();
        
        //setup scene manager/Scenes
        swSM = swSceneManager::getInstance();
        
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
    
    
    
    //Setup Menu
    //menu.setup();
    //menu.show();
}

//--------------------------------------------------------------
void testApp::update(){
    
   // Tweenzor::update();
    if(swSM->getCurSceneChanged()) {
        for(int i=0; i<SW_TOTAL_SCENES; i++) {
            scenes[i]->deactivate();
        }
        
        scenes[swSM->getCurScene()]->activate();
    }
    
    scenes[swSM->getCurScene()]->update();
    
    menu.update();
     

}

//--------------------------------------------------------------
void testApp::draw(){
    
    if(!swSM->getCurSceneChanged(false)) {
        scenes[swSM->getCurScene()]->draw();
    }
    
    //menu.draw();
     
}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
    
    scenes[swSM->getCurScene()]->touchDown(touch);
    
    menu.touchDown(touch);
     
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
    scenes[swSM->getCurScene()]->touchMoved(touch);
    
    menu.touchMoved(touch);
     
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    
    scenes[swSM->getCurScene()]->touchUp(touch);
    menu.touchUp(touch);
    
    if(menu.touchMenuRes){
        
        cout<<"touch menu res true"<<endl;
        scenes[swSM->getCurScene()]->activate();
        
    }
    menu.touchMenuRes = false;
     
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    scenes[swSM->getCurScene()]->touchDoubleTap(touch);
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


//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){

}

