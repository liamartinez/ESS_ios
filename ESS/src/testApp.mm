<<<<<<< HEAD
//  modified by Chien on 10/15/12.

=======
>>>>>>> 7d1519fd360a8c936c4d7075fbd5fdfcafbb2a9f
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
    
    //Setup Menu
    //menu.setup();
    //menu.show();
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
<<<<<<< HEAD
    
    //Chien-Swipe Detect
    EAGLView *view = ofxiPhoneGetGLView();  
    swipeDetect = [[ofSwipeGestureRecognizer alloc] initWithView:view];
    swipe = 0;
    

    
=======
>>>>>>> 7d1519fd360a8c936c4d7075fbd5fdfcafbb2a9f
}

//--------------------------------------------------------------
void testApp::update(){
    
<<<<<<< HEAD
//    cout<<"swipe value"<<swipeDetect->swipe<<endl;
    if (swipeDetect->swipe == 1) {
        cout<<"HE DID SWIPE"<<endl;
        if (essSM->getCurScene()==1) {
            cout<<"hi";
            if (swipeDetect->direction == 1) {
                essSM->setCurScene(SCENE_MAP2); 
                
            }
        }else if (essSM->getCurScene()==2) {
            if (swipeDetect->direction == 1) {
                essSM->setCurScene(SCENE_MAP3);  
            }else{
                essSM->setCurScene(SCENE_MAP1); 
            }

        }else if (essSM->getCurScene()==3) {
            if (swipeDetect->direction == 1) {
                essSM->setCurScene(SCENE_MAP4);  
            }else{
                essSM->setCurScene(SCENE_MAP2); 
            }

        }else if (essSM->getCurScene()==4) {
            if (swipeDetect->direction == 2) {
                essSM->setCurScene(SCENE_MAP3);  
            }        
        }
        swipeDetect->swipe = 0;

        
        
    }
=======
>>>>>>> 7d1519fd360a8c936c4d7075fbd5fdfcafbb2a9f
   // Tweenzor::update();
    if(essSM->getCurSceneChanged()) {
        for(int i=0; i<SW_TOTAL_SCENES; i++) {
            scenes[i]->deactivate();
<<<<<<< HEAD
    
        }

        scenes[essSM->getCurScene()]->activate();
    }
    

    
=======
        }
        
        scenes[essSM->getCurScene()]->activate();
    }
    
>>>>>>> 7d1519fd360a8c936c4d7075fbd5fdfcafbb2a9f
    scenes[essSM->getCurScene()]->update();
    
    menu.update();
     

}

//--------------------------------------------------------------
void testApp::draw(){
    
    if(!essSM->getCurSceneChanged(false)) {
        scenes[essSM->getCurScene()]->draw();
    }
    
    //menu.draw();
    

     
}

//--------------------------------------------------------------
void testApp::exit(){
    
     [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
    
    scenes[essSM->getCurScene()]->touchDown(touch);
    
    menu.touchDown(touch);
     
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
    scenes[essSM->getCurScene()]->touchMoved(touch);
    
    menu.touchMoved(touch);
     
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    
    scenes[essSM->getCurScene()]->touchUp(touch);
    menu.touchUp(touch);
    
    if(menu.touchMenuRes){

        scenes[essSM->getCurScene()]->activate();
        
    }
    menu.touchMenuRes = false;
     
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    scenes[essSM->getCurScene()]->touchDoubleTap(touch);
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

