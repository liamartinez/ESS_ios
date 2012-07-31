//
//  map2Scene.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "map2Scene.h"

//------------------------------------------------------------------
void map2Scene::setup() {
    
    
}



//------------------------------------------------------------------
void map2Scene::update() {
    switch(mgr.getCurScene()) {
        case MAP2_SCENE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void map2Scene::activate() {
    mgr.setCurScene(MAP2_SCENE_FIRST);
    
    
    
    map2Scene.loadImage("flattenFiles/Map2.jpg");
    //button.setImage(&map2Screen,&map2Screen);
    cout << "Activate Call" << endl;
    
    rectHome.set(ofGetWidth()-50, ofGetHeight()-30, 70, 30);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
    
    
}

//------------------------------------------------------------------
void map2Scene::deactivate() {
    cout << "Deactivate Call" << endl;
    
    map2Scene.clear();
    
}


//------------------------------------------------------------------
void map2Scene::draw() {

    drawGrid();
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP2_SCENE_FIRST:
            
            ofEnableAlphaBlending();
                        
            ofSetColor(255, 255, 255); 
            map2Scene.draw(0,0, ofGetWidth(), ofGetHeight()); 
                        
            buttHome.draw(); 
            
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map2Scene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    buttHome.touchDown(touch);
}


//--------------------------------------------------------------
void map2Scene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void map2Scene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == MAP2_SCENE_TOTAL-1) {
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