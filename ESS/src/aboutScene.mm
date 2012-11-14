
//  Created by Lia Martinez on 2/27/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "aboutScene.h"

//------------------------------------------------------------------
void aboutScene::setup() {
    
    
}



//------------------------------------------------------------------
void aboutScene::update() {
    switch(mgr.getCurScene()) {
        case ABOUT_SCENE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void aboutScene::activate() {
    mgr.setCurScene(ABOUT_SCENE_FIRST);
    
    canvasW = 480;	//these define where the camera can pan to
    canvasH = 600;
    
    cam.setZoom(1.0f);
	cam.setMinZoom(1.0f);
	cam.setMaxZoom(2.0f);
	cam.setScreenSize( ofGetWidth(), ofGetHeight() ); //tell the system how large is out screen
    
	cam.lookAt( ofVec2f(canvasW/2, 160) );
    cam.setViewportConstrain( ofVec3f(0,0), ofVec3f(canvasW, canvasH)); //limit browseable area, in world units
    
    cout << "width is " << ofGetWidth() << endl; 
    
    aboutScreen.loadImage("flattenFiles/ESS-iPhone-About.png");
    //button.setImage(&aboutScreen,&aboutScreen);
    
    rectHome.set(canvasW-70, canvasH-30, 70, 30);
    TrectHome.set(canvasW-70, ofGetHeight() - 30, 70, 30);
    cout << "rectHome is " << rectHome.x << " " <<  rectHome.y << endl; 
    
    buttHome.setLabel("HOME", &essAssets->ostrich24);
    buttHome.setRect(rectHome);
    buttHome.setGLRect(TrectHome);
    buttHome.setColor(essAssets->ess_white, essAssets->ess_grey);
    buttHome.disableBG();
    
    buttResetXML.setLabel("RESET", &essAssets->ostrich30);
    buttResetXML.setColor(essAssets->ess_white, essAssets->ess_grey);
    buttResetXML.disableBG();
    buttResetXML.setPos (ofGetWidth() - (essAssets->ostrich30.getStringWidth("RESET")*2), 30);
    
    ofBackground(essAssets->ess_blue);
    

	//navigation buttons
	nApp.setLabel("APP", &essAssets->ostrich23);
	nOralHist.setLabel("ORAL HISTORIES", &essAssets->ostrich23);
	nCreators.setLabel("CREATORS", &essAssets->ostrich23);
	nThanks.setLabel("THANK YOU", &essAssets->ostrich23);

    
}

//------------------------------------------------------------------
void aboutScene::deactivate() {
    aboutScreen.clear();
}


//------------------------------------------------------------------
void aboutScene::draw() {
    
    
    cam.apply(); //put all our drawing under the ofxPanZoom effect


    switch(mgr.getCurScene()) {
        case ABOUT_SCENE_FIRST:
            
            ofEnableAlphaBlending();

            
            ofSetColor(255, 255, 255); 
            aboutScreen.draw (0,0, 480, 523); 
            
            buttHome.draw(); 
            buttResetXML.draw();
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    cam.reset();	//back to normal ofSetupScreen() projection

    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void aboutScene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    buttHome.GLtouchDown(touch);
    buttResetXML.touchDown(touch);
    
    cam.touchDown(touch); //fw event to cam
}


//--------------------------------------------------------------
void aboutScene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
    buttResetXML.touchMoved(touch);
    
    cam.touchMoved(touch); //fw event to cam
}


//--------------------------------------------------------------
void aboutScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == ABOUT_SCENE_TOTAL-1) {
            essSM->setCurScene(SCENE_HOME);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
     */
    
    if (buttHome.isPressed()) {
        essSM->setCurScene(SCENE_HOME);
        cout << "button pressed" << endl; 
    }
    if (buttResetXML.isPressed()) resetPlayed();
    
    buttResetXML.touchUp(touch);
    buttHome.GLtouchUp(touch);
    button.touchUp(touch);
    
    cam.touchUp(touch); //fw event to cam
}

//--------------------------------------------------------------

void aboutScene::touchDoubleTap(ofTouchEventArgs &touch){
	cam.touchDoubleTap(touch); //fw event to cam
	cam.setZoom(1.0f);	//reset zoom
	cam.lookAt( ofVec2f(canvasW/2, canvasH/2) ); //reset position
}