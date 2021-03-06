
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 Storywalks at Eldridge St.. All rights reserved.
//

#include <iostream>

#include "map2Scene.h"

//------------------------------------------------------------------
void map2Scene::setup() {

    
}



//------------------------------------------------------------------
void map2Scene::update() {
    switch(mgr.getCurScene()) {
        case MAP2_SCENE_FIRST:
            //Do stuff
            break;            
    }
    
    ofSoundUpdate();
}

//------------------------------------------------------------------
void map2Scene::activate() {
    mgr.setCurScene(MAP2_SCENE_FIRST);

    
    setupMap("2"); //enter the map number
    setupTitle("MAIN SANCTUARY");
    
    map2Scene.loadImage("flattenFiles/Map2.png");
    
    setupHomeButton();
    
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
void map2Scene::deactivate() {
    
    map2Scene.clear();
	audioTest.unloadSound();
}


//------------------------------------------------------------------
void map2Scene::draw() {

    cam.apply(); //put all our drawing under the ofxPanZoom effect

    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP2_SCENE_FIRST:
            
            ofEnableAlphaBlending();
            
            //the map
            ofSetColor(255, 255, 255); 
            map2Scene.draw(0,0, ofGetWidth(), ofGetHeight()); 
			essAssets->arrows.draw(0,0, ofGetWidth(), ofGetHeight());
            
            drawHomeButton();
            drawTitle();
   
            drawMapPoints(); 
            //audio display
            checkAudioStatus();
            
            if (spotTouch == true) {
                cam.setZoom(1.0f);
				cam.lookAt( ofVec2f(canvasW/2, canvasH/2) );
                //tweenEntryExit(1);
                //                cout<<"someone touch the spot"<<endl;
            }
            spotTouch = false;

            ofDisableAlphaBlending();


            break;
            
    }
    
    cam.reset();	//back to normal ofSetupScreen() projection
	
	//cam.drawDebug(); //see info on ofxPanZoom status
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map2Scene::touchDown(ofTouchEventArgs &touch){
    
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y; 
    
    baseTouchDown(touchTemp);
    
    cam.touchDown(touch); //fw event to cam

}


//--------------------------------------------------------------
void map2Scene::touchMoved(ofTouchEventArgs &touch){
    
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y; 
    
    baseTouchMoved(touchTemp);
    
    cam.touchMoved(touch); //fw event to cam

}


//--------------------------------------------------------------
void map2Scene::touchUp(ofTouchEventArgs &touch){
    
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

}


//--------------------------------------------------------------
void map2Scene::touchDoubleTap(ofTouchEventArgs &touch){
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y; 
    
	cam.touchDoubleTap(touchTemp); //fw event to cam
	cam.setZoom(1.0f);	//reset zoom
	cam.lookAt( ofVec2f(canvasW/2, canvasH/2) ); //reset position
}

