
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//
#pragma once
#include "essBaseScene.h"
#include "ofxPanZoom.h"

enum {
    MAP4_SCENE_FIRST,
    MAP4_SCENE_TOTAL
};

class map4Scene : public essBaseScene {
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
    
    vector <oralHist> OHmap4; 
    
    bool drawGuide; 
    
    ofxPanZoom	cam;
    int canvasW, canvasH; 
    
<<<<<<< HEAD
    //Chien 2012/10/14
//    ofSwipeGestureRecognizer *swipeDetect;
    
=======
>>>>>>> 7d1519fd360a8c936c4d7075fbd5fdfcafbb2a9f
    ofSoundPlayer audio;
    
    
private:
    
    ofImage map4Scene; 
    ofImage map4Guide; 
    
    
};

