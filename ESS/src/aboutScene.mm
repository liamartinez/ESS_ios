
//  Created by Lia Martinez on 2/27/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "aboutScene.h"

//------------------------------------------------------------------
void aboutScene::setup() {
    
    
}



//------------------------------------------------------------------
void aboutScene::update() {
    switch(mgr.getCurScene()) {
        case ABOUT_SCENE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void aboutScene::activate() {
    mgr.setCurScene(ABOUT_SCENE_FIRST);
    
    aboutScreen.loadImage("flattenFiles/About.jpg");
    //button.setImage(&aboutScreen,&aboutScreen);
    
    rectHome.set(ofGetWidth()-50, ofGetHeight()-30, 70, 30);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
    
    buttResetXML.setLabel("RESET", &essAssets->ostrich30);
    buttResetXML.setColor(essAssets->ess_white, essAssets->ess_grey);
    buttResetXML.disableBG();
    buttResetXML.setPos (ofGetWidth()/2 - (essAssets->ostrich30.getStringWidth("RESET")/2), ofGetHeight()-60);
    
   

    
}

//------------------------------------------------------------------
void aboutScene::deactivate() {
    
    aboutScreen.clear();
    
}


//------------------------------------------------------------------
void aboutScene::draw() {
    

    switch(mgr.getCurScene()) {
        case ABOUT_SCENE_FIRST:
            
            ofEnableAlphaBlending();

            
            ofSetColor(255, 255, 255); 
            aboutScreen.draw (0,0, ofGetWidth(), ofGetHeight()); 
            
            buttHome.draw(); 
            buttResetXML.draw();
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void aboutScene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    buttHome.touchDown(touch);
    buttResetXML.touchDown(touch);
}


//--------------------------------------------------------------
void aboutScene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
    buttResetXML.touchMoved(touch);
}


//--------------------------------------------------------------
void aboutScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == ABOUT_SCENE_TOTAL-1) {
            essSM->setCurScene(SCENE_HOME);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
     */
    
    if (buttHome.isPressed()) essSM->setCurScene(SCENE_HOME);
    if (buttResetXML.isPressed()) resetPlayed();
    
    buttResetXML.touchUp(touch);
    buttHome.touchUp(touch);
    button.touchUp(touch);
}