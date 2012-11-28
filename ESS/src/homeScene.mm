
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 Storywalks at Eldridge St.. All rights reserved.
//

#include <iostream>

#include "homeScene.h"

//------------------------------------------------------------------
void homeScene::setup() {
    
}



//------------------------------------------------------------------
void homeScene::update() {
    switch(mgr.getCurScene()) {
        case HOME_SCENE_FIRST:
            //Do stuff


			
            break;            
    }
}

//------------------------------------------------------------------
void homeScene::activate() {
    mgr.setCurScene(HOME_SCENE_FIRST);
	
    homeScreen.loadImage("flattenFiles/Home.png");
	//homeScreenVguide.loadImage("flattenFiles/HomeV-guide.png");
    
	buttAbout.disableBG(); 
	alphaWhite = 0; 
	textWhite.set(255, 255, 255, alphaWhite);
	buttAbout.setColor(textWhite, essAssets->ess_grey);
	buttAbout.setLabel("ABOUT", &essAssets->ostrich24);
	rectAbout.set(ofGetWidth()-70, ofGetHeight() -30, 70, 30);
	buttAbout.setRect(rectAbout);
	
	buttMap1.disableBG();
	buttMap2.disableBG();
	buttMap3.disableBG();
	buttMap4.disableBG();
	
	//buttResetXML.setLabel("RESET", &essAssets->ostrich20);
    //buttResetXML.setColor(essAssets->ess_white, essAssets->ess_grey);
	
	textGray.set(230, 230, 230, alphaWhite); 
	darkGray.set (210, 210, 210); 
    buttResetXML.disableBG();
	buttResetXML.setPos(-10, -15);
	buttResetXML.setColor(textWhite, darkGray);
	buttResetXML.setLabel("RESET", &essAssets->ostrich20);
	buttResetXML.setSize(70, 60);
	
	rectMap1.set(150, 113, 200, 40);
	rectMap2.set(150, 174, 200, 40);
	rectMap3.set(150, 230, 200, 40);
	rectMap4.set(15, 255, 150, 40);
	
	buttAbout.setRect(rectAbout);
	buttMap1.setRect(rectMap1);
	buttMap2.setRect(rectMap2);
	buttMap3.setRect(rectMap3);
	buttMap4.setRect(rectMap4);
	
	fadeTime = 2000; 
	startTime = ofGetElapsedTimeMillis(); 
	
	alpha = 0; 
	revAlpha = 255; 
    
}

//------------------------------------------------------------------
void homeScene::deactivate() {
	
    homeScreen.clear();
	
}


//------------------------------------------------------------------
void homeScene::draw() {
	
	ofSetColor(0);
    ofRect(0, 0, 0, ofGetWidth(), ofGetHeight());

            
            ofEnableAlphaBlending();

			alphaInc = 5;
			
			if (alpha < 255) {
				alpha +=alphaInc; 
			}
			
			if (alphaWhite < 255) alphaWhite += 3; 
				
			
			textWhite.set(255, 255, 255, alphaWhite);
			textGray.set(230, 230, 230, alphaWhite);
			buttAbout.setColor (textWhite, essAssets->ess_grey); 
			buttResetXML.setColor(textGray, darkGray);
            ofSetColor(255, 255, 255, alpha); 

			homeScreen.draw (0,0, ofGetWidth(), ofGetHeight()); 

			buttAbout.draw(); 
			buttResetXML.draw(); 
			buttMap1.draw();
			buttMap2.draw();
			buttMap3.draw();
			buttMap4.draw();
			

			
            ofDisableAlphaBlending();
			

    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void homeScene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    buttAbout.touchDown(touch);
    buttMap1.touchDown(touch);
    buttMap2.touchDown(touch);
    buttMap3.touchDown(touch);
    buttMap4.touchDown(touch);
	
	buttResetXML.touchDown(touch);
}


//--------------------------------------------------------------
void homeScene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
    buttAbout.touchMoved(touch);
	
	
}


//--------------------------------------------------------------
void homeScene::touchUp(ofTouchEventArgs &touch){

    if (buttAbout.isPressed()) essSM->setCurScene(SCENE_ABOUT);
    
    if (buttMap1.isPressed()) essSM->setCurScene(SCENE_MAP1);
    
    if (buttMap2.isPressed()) essSM->setCurScene(SCENE_MAP2);
    
    if (buttMap3.isPressed()) essSM->setCurScene(SCENE_MAP3);
	
    if (buttMap4.isPressed()) essSM->setCurScene(SCENE_MAP4);
    
    
    buttAbout.touchUp(touch);
    buttMap1.touchUp(touch);
    buttMap2.touchUp(touch);
    buttMap3.touchUp(touch);
    buttMap4.touchUp(touch);
    button.touchUp(touch);
	
	if (buttResetXML.isPressed()) resetPlayed();
    
    buttResetXML.touchUp(touch);

    
}
//--------------------------------------------------------------

void homeScene::touchDoubleTap(ofTouchEventArgs &touch) {
}