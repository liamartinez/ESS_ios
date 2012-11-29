
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 Storywalks at Eldridge St.. All rights reserved.
//

#include <iostream>

#include "map1Scene.h"

//------------------------------------------------------------------
void map1Scene::setup() {

    
}



//------------------------------------------------------------------
void map1Scene::update() {
    switch(mgr.getCurScene()) {
        case MAP1_SCENE_FIRST:
            map1Scene.update();
            break;            
    }
    
    ofSoundUpdate();

}

//------------------------------------------------------------------
void map1Scene::activate() {
    mgr.setCurScene(MAP1_SCENE_FIRST);
    
    
    setupMap("1"); //enter the map number
    setupTitle("BALCONY");
    
    map1Scene.loadImage("flattenFiles/Map1.png");
    
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
void map1Scene::deactivate() {
    
    map1Scene.clear();

	audioTest.unloadSound();
    
}


//------------------------------------------------------------------
void map1Scene::draw() {
    
    cam.apply(); //put all our drawing under the ofxPanZoom effect
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP1_SCENE_FIRST:
            
            ofEnableAlphaBlending();
            
            //the map
            ofSetColor(255, 255, 255); 
            map1Scene.draw(0,0, ofGetWidth(), ofGetHeight()); 
			essAssets->arrowdown.draw(0,-20, ofGetWidth(), ofGetHeight());
            
            drawHomeButton();
            drawTitle();
            
            drawMapPoints();
            
            //audio display
            checkAudioStatus();
			
//			cout<<"the current overlay is"<<overlayShow<<endl;
			
            //For reset Pan
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

//the audio is too short to see the effect. Just keep it for now
//void map1Scene::resetZoom(float _zoomNum){
//    float tempZoom = 0;
//    tempZoom = _zoomNum;
//    while(tempZoom - 1.0f > 0.0000000001f) {
//        tempZoom = tempZoom -0.1f;
//        cam.setZoom(tempZoom);
//    }
//    cout<<"zoom number"<<tempZoom<<endl;
//}






//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map1Scene::touchDown(ofTouchEventArgs &touch){
    
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y; 
    
    baseTouchDown(touchTemp);
    
    cam.touchDown(touch); //fw event to cam
    
}


//--------------------------------------------------------------
void map1Scene::touchMoved(ofTouchEventArgs &touch){
    
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y;     
    cam.touchMoved(touch); //fw event to cam
	
	baseTouchMoved(touchTemp);
    
}


//--------------------------------------------------------------
void map1Scene::touchUp(ofTouchEventArgs &touch){
    
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y; 
    
    baseTouchUp(touch);

    cam.touchUp(touch);	//fw event to cam

}


//--------------------------------------------------------------
void map1Scene::touchDoubleTap(ofTouchEventArgs &touch){
	cout << "double tap" << endl; 
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y; 
    
	cam.touchDoubleTap(touch); //fw event to cam
	cam.setZoom(1.0f);	//reset zoom
	cam.lookAt( ofVec2f(canvasW/2, canvasH/2) ); //reset position
	
	
}