//
//  map1Scene.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "map1Scene.h"

//------------------------------------------------------------------
void map1Scene::setup() {
    soundTrack.loadSound("sounds/Mason.caf");
    soundTrack.setVolume(0.75f);
    soundTrack.setMultiPlay(false);
    x = 100;
    y = 100;
    w = 100;
    h = 100;
    color = 255;
    
}



//------------------------------------------------------------------
void map1Scene::update() {
    switch(mgr.getCurScene()) {
        case MAP1_SCENE_FIRST:
            //Do stuff
            break;            
    }
     ofSoundUpdate();
}

//------------------------------------------------------------------
void map1Scene::activate() {
    mgr.setCurScene(MAP1_SCENE_FIRST);
    
    
    
    map1Scene.loadImage("flattenFiles/Map1.jpg");
//    button.setImage(&map1Scene,&map1Scene);
    button.setLabel("next",&swAssets->whitneySemiBold22);
    button.setPos(200,200);
    play.setLabel("play",&swAssets->whitneySemiBold22);
    play.setPos(100, 100);
    
    rectHome.set(ofGetWidth()-50, ofGetHeight()-30, 70, 30);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
    
    cout << "Activate Call" << endl;
    

    
    
}

//------------------------------------------------------------------
void map1Scene::deactivate() {
    cout << "Deactivate Call" << endl;
    
    map1Scene.clear();
    
}


//------------------------------------------------------------------
void map1Scene::draw() {

    drawGrid();
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP1_SCENE_FIRST:
            
            ofEnableAlphaBlending();
                        
            ofSetColor(255, 255, 255); 
            map1Scene.draw(0,0, ofGetWidth(), ofGetHeight());
            
            //button.draw();
            play.draw();
            buttHome.draw(); 
            
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map1Scene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    play.touchDown(touch);
    buttHome.touchDown(touch);
}


//--------------------------------------------------------------
void map1Scene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
    play.touchMoved(touch);

}


//--------------------------------------------------------------
void map1Scene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == MAP1_SCENE_TOTAL-1) {
            swSM->setCurScene(SCENE_ABOUT);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
    */
    
    if(play.isPressed()){
        printf("yes\n");
        soundTrack.play();
    }
    
    if (buttHome.isPressed()) {
        soundTrack.stop();
        swSM->setCurScene(SCENE_HOME);
    }
    
    button.touchUp(touch);
    play.touchUp(touch);
    buttHome.touchUp(touch);
}