
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
    button.setImage(&aboutScreen,&aboutScreen);
    
    rectHome.set(ofGetWidth()-50, ofGetHeight()-30, 70, 30);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
    
    cout << "Activate about" << endl;
    
    
}

//------------------------------------------------------------------
void aboutScene::deactivate() {
    cout << "Deactivate about" << endl;
    
    aboutScreen.clear();
    
}


//------------------------------------------------------------------
void aboutScene::draw() {
    
    drawGrid();
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case ABOUT_SCENE_FIRST:
            
            ofEnableAlphaBlending();
            
            sceneName = "First Sub Scene!";
            
            ofSetColor(255, 255, 255); 
            aboutScreen.draw (0,0, ofGetWidth(), ofGetHeight()); 
            
            buttHome.draw(); 
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
}


//--------------------------------------------------------------
void aboutScene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void aboutScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == ABOUT_SCENE_TOTAL-1) {
            swSM->setCurScene(SCENE_HOME);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
     */
    
    if (buttHome.isPressed()) swSM->setCurScene(SCENE_HOME);
    
    buttHome.touchUp(touch);
    button.touchUp(touch);
}