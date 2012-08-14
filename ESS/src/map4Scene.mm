
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "map4Scene.h"

//------------------------------------------------------------------
void map4Scene::setup() {
    
    
}



//------------------------------------------------------------------
void map4Scene::update() {
    switch(mgr.getCurScene()) {
        case MAP4_SCENE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void map4Scene::activate() {
    mgr.setCurScene(MAP4_SCENE_FIRST);
    
    
    
    map4Scene.loadImage("flattenFiles/Map4.jpg");
    button.setImage(&map4Scene,&map4Scene);
    
    rectHome.set(ofGetWidth()-50, ofGetHeight()-30, 70, 30);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
    

    
    
}

//------------------------------------------------------------------
void map4Scene::deactivate() {

    map4Scene.clear();
    
}


//------------------------------------------------------------------
void map4Scene::draw() {
    
    drawGrid();
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP4_SCENE_FIRST:
            
            ofEnableAlphaBlending();
                        
            ofSetColor(255, 255, 255); 
            map4Scene.draw(0,0, ofGetWidth(), ofGetHeight());

            buttHome.draw(); 
            
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map4Scene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    buttHome.touchDown(touch);
}


//--------------------------------------------------------------
void map4Scene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void map4Scene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == MAP4_SCENE_TOTAL-1) {
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