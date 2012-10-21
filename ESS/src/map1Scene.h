
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.

#pragma once
#include "essBaseScene.h"
#include "ofxPanZoom.h"

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
    void touchDoubleTap(ofTouchEventArgs &touch);
	
    
    vector <oralHist> OHmap1; 
    
    bool drawGuide; 
    
    ofxPanZoom	cam;
    int canvasW, canvasH; 
    
    ofSoundPlayer audio;

//    ofSwipeGestureRecognizer *swipeDetect;
    
    int swipeNumber;

    
    
private:
    
    ofImage map1Scene; 
    ofImage guide1; 
    
};


