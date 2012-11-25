
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 Storywalks at Eldridge St.. All rights reserved.
//

#pragma once
#include "essBaseScene.h"
#include "ofxPanZoom.h"

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
    void touchDoubleTap(ofTouchEventArgs &touch);
    
    vector <oralHist> OHmap3; 
    
    bool drawGuide; 
    
    ofxPanZoom	cam;

    int canvasW, canvasH;
    

    
    ofSoundPlayer audio;
    
    
private:
    
    ofImage map3Scene; 
    ofImage map3Guide; 
    
    
};


