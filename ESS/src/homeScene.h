//
//  homeScene.h
//  SingWhale01
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_homeScene_h
#define SingWhale01_homeScene_h

#pragma once
#include "swBaseScene.h"
#include "baseButton.h"

enum {
    HOME_SCENE_FIRST,
    HOME_SCENE_TOTAL
};

class homeScene : public swBaseScene {
public:
    void setup();
    void update();
    void draw();
    
    void activate(); 
    void deactivate();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    
    //buttons
    baseButton buttAbout; 
    ofRectangle rectAbout, rectMap1, rectMap2, rectMap3, rectMap4; 
    baseButton buttMap1, buttMap2, buttMap3, buttMap4; 
    baseButton button;
    
private:
    
    ofImage homeScreen; //lia - replace pictures here. 
    /*
    ofImage homeScreen;
    ofImage postit; 
    */
    
    
};

#endif
