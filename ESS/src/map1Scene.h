
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef ESS_map1Scene_h
#define ESS_map1Scene_h

#pragma once
#include "essBaseScene.h"
#include "baseButton.h"
#include "ess_oralHist.h"

enum {
    MAP1_SCENE_FIRST,
    MAP1_SCENE_TOTAL
};

class map1Scene : public essBaseScene {
public:
    void setup();
    void update();
    void draw();
    
    void activate(); 
    void deactivate();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    
    vector <oralHist> OHmap1; 
    
    baseButton button;
    int buttonState; 
    int currentButton, lastButton; 
    
    baseButton buttHome; 
    ofRectangle rectHome; 
    
    ofSoundPlayer audio;
    
    bool somethingActive; 
    
private:
    
    ofImage map1Scene; //lia - replace pictures here
    int x,y,w,h;
    int color;
    
};

#endif
