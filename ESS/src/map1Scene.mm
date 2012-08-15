
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "map1Scene.h"

//------------------------------------------------------------------
void map1Scene::setup() {

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
    button.setLabel("next",&essAssets->whitneySemiBold22);
    button.setPos(200,200);

    rectHome.set(ofGetWidth()-50, ofGetHeight()-30, 70, 30);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
    
    OHmap1 = loadXML ("1"); //load first floor map

    for (int i = 0; i < OHmap1.size(); i++) {  
        OHmap1[i].setup(); 
        cout << "setting up " + OHmap1[i].name << endl;

//        OHmap1[i].audio.loadSound(OHmap1[i].path);  
//        cout << "loaded from " + OHmap1[i].path << endl; 

    }
    

}

//------------------------------------------------------------------
void map1Scene::deactivate() {
    
    map1Scene.clear();

}


//------------------------------------------------------------------
void map1Scene::draw() {

    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP1_SCENE_FIRST:
            
            ofEnableAlphaBlending();
                        
            ofSetColor(255, 255, 255); 
            map1Scene.draw(0,0, ofGetWidth(), ofGetHeight());
            
            //button.draw();

            buttHome.draw(); 
            
            for (int i = 0; i < OHmap1.size(); i++) {            
                OHmap1[i].drawDot(); 
                if (OHmap1[i].isDrawn) OHmap1[i].drawInfo();
            }

            ofDisableAlphaBlending();
            
            break;
    }

}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map1Scene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    
    for (int i = 0; i < OHmap1.size(); i++) {
        OHmap1[i].playButn.touchDown(touch);
        OHmap1[i].spotButn.touchDown(touch);
    }

    buttHome.touchDown(touch);
}


//--------------------------------------------------------------
void map1Scene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
    for (int i = 0; i < OHmap1.size(); i++) {
        OHmap1[i].playButn.touchMoved(touch);
        OHmap1[i].spotButn.touchMoved(touch);
    }

}


//--------------------------------------------------------------
void map1Scene::touchUp(ofTouchEventArgs &touch){

    for (int i = 0; i < OHmap1.size(); i++) { 
        
        if (OHmap1[i].spotButn.isPressed()) {
            for (int j = 0; j < OHmap1.size(); j++) {
                OHmap1[j].isDrawn = false; 
            }
            OHmap1[i].isDrawn = true; 
        }
        

        if (OHmap1[i].playButn.isPressed()) {
            if (!OHmap1[i].audio.getIsPlaying()){
                OHmap1[i].play(); 
                cout << OHmap1[i].name + "is playing" << endl; 
            } else {
                OHmap1[i].pause();
                cout << OHmap1[i].name + "is paused" << endl; 
            }
        } 
       
    }

    if (buttHome.isPressed()) {
        essSM->setCurScene(SCENE_HOME);
    }
    
    button.touchUp(touch);
    for (int i = 0; i < OHmap1.size(); i++) {
        OHmap1[i].playButn.touchUp(touch);
        OHmap1[i].spotButn.touchUp(touch);
    }
    buttHome.touchUp(touch);
}