
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef ESS_map2Scene_h
#define ESS_map2Scene_h

#pragma once
#include "essBaseScene.h"
#include "baseButton.h"

enum {
    MAP2_SCENE_FIRST,
    MAP2_SCENE_TOTAL
};

class map2Scene : public essBaseScene {
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
    
    ofImage map2Scene; //lia - replace pictures here. 
    /*
     ofImage homeScreen;
     ofImage postit; 
     */
    
    
};

#endif
