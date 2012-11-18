
//  Created by Lia Martinez on 2/27/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef ESS_aboutScene_h
#define ESS_aboutScene_h

#pragma once

#include "essBaseScene.h"
#include "baseButton.h"
#include "ofxPanZoom.h"
#include "ofxTweenzor.h"

enum {
    ABOUT_SCENE_APP,
    ABOUT_SCENE_FAQ,
    ABOUT_SCENE_ORALHISTORIES,
    ABOUT_SCENE_CREATORS,
    ABOUT_SCENE_THANKYOU,
    ABOUT_SCENE_TOTAL
};

class aboutScene : public essBaseScene {
public:
    void setup();
    void update();
    void draw();
	void exit(); 
    
    void activate(); 
    void deactivate();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    void touchDoubleTap(ofTouchEventArgs &touch);

    baseButton button;
    baseButton buttResetXML;
    
    baseButton buttHome; 
    ofRectangle rectHome; 
    ofRectangle TrectHome; 
	
	baseButton lEldridge, lAnna, lCarlin, lLia, lChien, lMerche, lRyan, lFiber; 
    
    ofxPanZoom	cam;
    int canvasW;
    int canvasH;
	    
    int navY, textY; 
	int leftMargin, dotMargin; 
    
	int appL, faqL, OHL, creatL;
	
    baseButton nApp, nOralHistories, nCreators, nThanks, nFAQ; 
    ofImage pApp, pOralHistories, pCreators, pThanks, pFAQ; 
	
	//tweening
	float startY, endY; 
	float downY; 
	float tweenie;
	int offset; 
	
	int liaTween(int start, int end);
	bool tweenGo; 
	int maxBottom; 
private:
    
    ofImage aboutScreen; //lia - replace pictures here. 
    /*
     ofImage homeScreen;
     ofImage postit; 
     */
    
    
};

#endif
