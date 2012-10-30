
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
    
    rectAbout.set(427, 290, 45, 20);
    buttAbout.setRect(rectAbout);
    buttAbout.disableBG();

    rectMap1.set(170, 113, 100, 40);
    buttMap1.setRect(rectMap1);
    buttMap1.disableBG(); 
    
    rectMap2.set(170, 174, 100, 40);
    buttMap2.setRect(rectMap2);
    buttMap2.disableBG(); 
    
    rectMap3.set(170, 230, 100, 40);
    buttMap3.setRect(rectMap3);
    buttMap3.disableBG();
    
    rectMap4.set(35, 266, 100, 40);
    buttMap4.setRect(rectMap4);
    buttMap4.disableBG(); 

	alphaInc = 10;
    
    
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

			if (alpha < 255) {
				alpha += alphaInc; 
			}
                        
            ofSetColor(255, 255, 255, alpha); 
            homeScreen.draw (0,0, ofGetWidth(), ofGetHeight()); 
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
    
}