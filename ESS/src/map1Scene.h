//
//  callScene.h
//  SingWhale01
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef ESS_map1Scene_h
#define ESS_map1Scene_h

#pragma once
#include "swBaseScene.h"
#include "baseButton.h"

enum {
    MAP1_SCENE_FIRST,
    MAP1_SCENE_TOTAL
};

class map1Scene : public swBaseScene {
public:
    void setup();
    void update();
    void draw();
    
    void activate(); 
    void deactivate();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    
    baseButton button;
    baseButton play;
    
    baseButton buttHome; 
    ofRectangle rectHome; 
    
private:
    
    ofImage map1Scene; //lia - replace pictures here. 
    /*
     ofImage homeScreen;
     ofImage postit; 
     */
    
    ofSoundPlayer soundTrack;//Chien
    int x,y,w,h;
    int color;
    
};

#endif
