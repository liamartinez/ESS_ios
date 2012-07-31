//
//  aboutScene.h
//  SingWhale01
//
//  Created by Lia Martinez on 2/27/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef ESS_aboutScene_h
#define ESS_aboutScene_h

#pragma once

#include "swBaseScene.h"
#include "baseButton.h"

enum {
    ABOUT_SCENE_FIRST,
    ABOUT_SCENE_TOTAL
};

class aboutScene : public swBaseScene {
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
    
    baseButton buttHome; 
    ofRectangle rectHome; 
    
private:
    
    ofImage aboutScreen; //lia - replace pictures here. 
    /*
     ofImage homeScreen;
     ofImage postit; 
     */
    
    
};

#endif
