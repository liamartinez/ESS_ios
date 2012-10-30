
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "homeScene.h"

//------------------------------------------------------------------
void homeScene::setup() {
    
}



//------------------------------------------------------------------
void homeScene::update() {
    switch(mgr.getCurScene()) {
        case HOME_SCENE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void homeScene::activate() {
    mgr.setCurScene(HOME_SCENE_FIRST);

    homeScreen.loadImage("flattenFiles/Home.png");
	homeScreenV.loadImage("flattenFiles/HomeV-guide.png");
	//homeScreenVguide.loadImage("flattenFiles/HomeV-guide.png");
    
	buttAbout.disableBG(); 
	buttMap1.disableBG();
	buttMap2.disableBG();
	buttMap3.disableBG();
	buttMap4.disableBG();
	
	
	
	fadeTime = 2000; 
	startTime = ofGetElapsedTimeMillis(); 
    
}

//------------------------------------------------------------------
void homeScene::deactivate() {

    homeScreen.clear();

}


//------------------------------------------------------------------
void homeScene::draw() {

	ofSetColor(0);
    ofRect(0, 0, 0, ofGetWidth(), ofGetHeight());

    string sceneName = "";
    switch(mgr.getCurScene()) {
        case HOME_SCENE_FIRST:
            
            ofEnableAlphaBlending();
			
			
			//alphaInc = (fadeTime - startTime)/ 255;
			
			alphaInc = 5;
			
			if (alpha < 255) alpha +=alphaInc; 
			
			/*
			if (ofGetElapsedTimeMillis() < fadeTime) {
				alpha += alphaInc; 
			}
			 */
                        
			
            ofSetColor(255, 255, 255, alpha); 
			
			if (shiftRotate() == 0) {
				
				rectAbout.set(410, 270, 65, 40);
				rectMap1.set(150, 113, 200, 40);
				rectMap2.set(150, 174, 200, 40);
				rectMap3.set(150, 230, 200, 40);
				rectMap4.set(15, 255, 150, 40);
				
				homeScreen.draw (0,0, ofGetWidth(), ofGetHeight()); 
				
			} else if (shiftRotate() == 90) {
				
				rectMap1.set(250, 60, 40, 200);
				rectMap2.set(200, 60, 40, 200);
				rectMap3.set(140, 60, 40, 200);
				rectMap4.set(95, 6, 50, 100);
				rectAbout.set(10, 220, 40, 150);
				
				homeScreenV.draw(0,0, ofGetWidth(), ofGetHeight()); 
			}

			
			buttAbout.setRect(rectAbout);
			buttMap1.setRect(rectMap1);
			buttMap2.setRect(rectMap2);
			buttMap3.setRect(rectMap3);
			buttMap4.setRect(rectMap4);

			buttAbout.draw(); 
			buttMap1.draw();
			buttMap2.draw();
			buttMap3.draw();
			buttMap4.draw();
			
            ofDisableAlphaBlending();

            break;

    }

    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void homeScene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    buttAbout.touchDown(touch);
    buttMap1.touchDown(touch);
    buttMap2.touchDown(touch);
    buttMap3.touchDown(touch);
    buttMap4.touchDown(touch);
}


//--------------------------------------------------------------
void homeScene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
    buttAbout.touchMoved(touch);
	
	
}


//--------------------------------------------------------------
void homeScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == HOME_SCENE_TOTAL-1) {
            essSM->setCurScene(SCENE_MAP1);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
    */
   
    
    if (buttAbout.isPressed()) essSM->setCurScene(SCENE_ABOUT);
    
    if (buttMap1.isPressed()) essSM->setCurScene(SCENE_MAP1);
    
    if (buttMap2.isPressed()) essSM->setCurScene(SCENE_MAP2);
    
    if (buttMap3.isPressed()) essSM->setCurScene(SCENE_MAP3);
       
    if (buttMap4.isPressed()) essSM->setCurScene(SCENE_MAP4);
    
    
    buttAbout.touchUp(touch);
    buttMap1.touchUp(touch);
    buttMap2.touchUp(touch);
    buttMap3.touchUp(touch);
    buttMap4.touchUp(touch);
    button.touchUp(touch);
	
	cout << "                TOUCHED!! " << touch.x << " " << touch.y << endl; 
    
}
//--------------------------------------------------------------

void homeScene::touchDoubleTap(ofTouchEventArgs &touch) {
	guideOn = !guideOn; 
}
