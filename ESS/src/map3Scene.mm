
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "map3Scene.h"

//------------------------------------------------------------------
void map3Scene::setup() {
//    //Chien
//    EAGLView *view = ofxiPhoneGetGLView();  
//    swipeDetect = [[ofSwipeGestureRecognizer alloc] initWithView:view]; 
    
}



//------------------------------------------------------------------
void map3Scene::update() {
    switch(mgr.getCurScene()) {
        case MAP3_SCENE_FIRST:
            //Do stuff
            break;            
    }
    
    ofSoundUpdate();
}

//------------------------------------------------------------------
void map3Scene::activate() {
    mgr.setCurScene(MAP3_SCENE_FIRST);
    
    
    setupMap("3"); //enter the map number
    setupTitle("LOWER SANCTUARY");
    
    map3Scene.loadImage("flattenFiles/Map3.png");
    map3Guide.loadImage("flattenFiles/Map3-guide.png");
    
    setupHomeButton();
    setupTextBoxHelper();
    
    drawGuide = false;     
    
    // for zooming
    
    canvasW = ofGetWidth();	//these define where the camera can pan to
    canvasH = ofGetHeight();
    
    cam.setZoom(1.0f);
	cam.setMinZoom(1.0f);
	cam.setMaxZoom(3.0f);
	cam.setScreenSize( ofGetWidth(), ofGetHeight() ); //tell the system how large is out screen
	float gap = 0;
	cam.setViewportConstrain( ofVec3f(-gap, -gap), ofVec3f(canvasW + gap, canvasH + gap)); //limit browseable area, in world units
	cam.lookAt( ofVec2f(canvasW/2, canvasH/2) );
    
    
    ofBackground(essAssets->ess_blue);
    
    
}

//------------------------------------------------------------------
void map3Scene::deactivate() {
    
    map3Scene.clear();
    
}


//------------------------------------------------------------------
void map3Scene::draw() {
    
    cam.apply(); //put all our drawing under the ofxPanZoom effect
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP3_SCENE_FIRST:
            
            ofEnableAlphaBlending();
            
            //the map
            ofSetColor(255, 255, 255); 
            map3Scene.draw(0,0, ofGetWidth(), ofGetHeight()); 
            
            drawHomeButton();
            drawTitle();
            
            drawMapPoints(); 
            
            ofDisableAlphaBlending();
            
            //style guide when left side is touched
            ofSetColor(255, 255, 255);
            if (drawGuide) map3Guide.draw(0, 0, ofGetWidth(), ofGetHeight());
            
            break;
            
    }
    
    cam.reset();	//back to normal ofSetupScreen() projection
	
	//cam.drawDebug(); //see info on ofxPanZoom status
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map3Scene::touchDown(ofTouchEventArgs &touch){
    
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y; 
    
    baseTouchDown(touchTemp);
    
    cam.touchDown(touch); //fw event to cam
    
}


//--------------------------------------------------------------
void map3Scene::touchMoved(ofTouchEventArgs &touch){
    
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y; 
    
    cam.touchMoved(touch); //fw event to cam
    
}


//--------------------------------------------------------------
void map3Scene::touchUp(ofTouchEventArgs &touch){
    
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y; 
    
    baseTouchUp(touchTemp);
    
    //for the guide
    if (touch.x > ofGetWidth() - 30) {
        drawGuide = true; 
    } else if (touch.x < 30) {
        drawGuide = false; 
    }
    
    cam.touchUp(touch);	//fw event to cam

    
//    if (swipeDetect->swipe) {
//        if (swipeDetect->direction == 1) {
//            essSM->setCurScene(SCENE_MAP4);
//        }else{
//            essSM->setCurScene(SCENE_MAP2);
//        }
//    }
}


//--------------------------------------------------------------
void map3Scene::touchDoubleTap(ofTouchEventArgs &touch){
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y; 
    
	cam.touchDoubleTap(touch); //fw event to cam
	cam.setZoom(1.0f);	//reset zoom
	cam.lookAt( ofVec2f(canvasW/2, canvasH/2) ); //reset position
}