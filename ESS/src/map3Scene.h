
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef ESS_map3Scene_h
#define ESS_map3Scene_h

#pragma once
#include "essBaseScene.h"
#include "baseButton.h"

enum {
    MAP3_SCENE_FIRST,
    MAP3_SCENE_TOTAL
};

class map3Scene : public essBaseScene {
public:
    void setup();
    void update();
    void draw();
    
    void activate(); 
    void deactivate();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    

    baseButton buttHome; 
    ofRectangle rectHome; 
    ofRectangle rectLoc; 
    ofRectangle tempRect; 
    
    int buttonState; 
    int currentButton, lastButton; 
    bool touched; 
    bool dragged; 
    
    bool drawGuide; 
    
    vector <oralHist> OHmap3; 
    
private:
    
    ofImage map3Scene;    
    ofImage map3Guide; 
    /*
     ofImage homeScreen;
     ofImage postit; 
     */
    
    
};

#endif
