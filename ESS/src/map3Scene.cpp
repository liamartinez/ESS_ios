
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "map3Scene.h"

//------------------------------------------------------------------
void map3Scene::setup() {
    
    
}



//------------------------------------------------------------------
void map3Scene::update() {
    switch(mgr.getCurScene()) {
        case MAP3_SCENE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void map3Scene::activate() {
    mgr.setCurScene(MAP3_SCENE_FIRST);
    
    
    
    map3Scene.loadImage("flattenFiles/Map3.jpg");
    button.setImage(&map3Scene,&map3Scene);
    cout << "Activate Call" << endl;
    
    rectHome.set(ofGetWidth()-50, ofGetHeight()-30, 70, 30);
    buttHome.setRect(rectHome);
    buttHome.disableBG();

    
    
}

//------------------------------------------------------------------
void map3Scene::deactivate() {
    cout << "Deactivate Call" << endl;
    
    map3Scene.clear();
    
}


//------------------------------------------------------------------
void map3Scene::draw() {

    drawGrid();
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP3_SCENE_FIRST:
            
            ofEnableAlphaBlending();
                        
            ofSetColor(255, 255, 255); 
            map3Scene.draw(0,0, ofGetWidth(), ofGetHeight());
            
            buttHome.draw(); 
            
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map3Scene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    buttHome.touchDown(touch);
}


//--------------------------------------------------------------
void map3Scene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void map3Scene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == MAP3_SCENE_TOTAL-1) {
            swSM->setCurScene(SCENE_ABOUT);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
     */
    
    if (buttHome.isPressed()) swSM->setCurScene(SCENE_HOME);
    
    buttHome.touchUp(touch);
    button.touchUp(touch);
}