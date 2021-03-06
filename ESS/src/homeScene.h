
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 Storywalks at Eldridge St.. All rights reserved.
//

#pragma once
#include "essBaseScene.h"
#include "baseButton.h"

enum {
    HOME_SCENE_FIRST,
    HOME_SCENE_TOTAL
};

class homeScene : public essBaseScene {
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
    
    //buttons
    baseButton buttAbout; 
    ofRectangle rectAbout, rectMap1, rectMap2, rectMap3, rectMap4; 
    baseButton buttMap1, buttMap2, buttMap3, buttMap4; 
    baseButton button;
	
	baseButton balcony, mainSanct, LowerSanc, Eldrige; 
	
	baseButton buttResetXML; 
	
	//fade-in
	int fadeTime, startTime; 
	int alpha, alphaInc; 
	int revAlpha; 
    bool guideOn; 
	
	ofColor textWhite;
	ofColor textGray; 
	ofColor darkGray; 
	int alphaWhite; 
	
private:
    
    ofImage homeScreen; //lia - replace pictures here. 
    ofImage homeScreenV;
	ofImage homeScreenVguide; 
	
};
