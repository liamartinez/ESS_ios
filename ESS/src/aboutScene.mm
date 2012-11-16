
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
        case ABOUT_SCENE_APP:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void aboutScene::activate() {
    mgr.setCurScene(ABOUT_SCENE_APP);
    
    canvasW = 480;	//these define where the camera can pan to
    canvasH = 600;
    
    cam.setZoom(1.0f);
	cam.setMinZoom(1.0f);
	cam.setMaxZoom(2.0f);
	cam.setScreenSize( ofGetWidth(), ofGetHeight() ); //tell the system how large is out screen
    
	cam.lookAt( ofVec2f(canvasW/2, 160) );
    cam.setViewportConstrain( ofVec3f(0,0), ofVec3f(canvasW, canvasH)); //limit browseable area, in world units

    
    aboutScreen.loadImage("flattenFiles/AboutHorizontal.png");
    
    pApp.loadImage ("flattenFiles/about/AboutTextAPP.png"); 
    pOralHistories.loadImage ("flattenFiles/about/AboutTextORALHISTORIES.png"); 
    pCreators.loadImage ("flattenFiles/about/AboutTextCREATORS.png"); 
    pThanks.loadImage ("flattenFiles/about/AboutTextTHANKYOU.png"); 
    pFAQ.loadImage("flattenFiles/about/AboutTextFAQ.png"); 
    
    //button.setImage(&aboutScreen,&aboutScreen);
    
    rectHome.set(ofGetWidth()-70, ofGetHeight() -30, 70, 30);
    
    buttHome.setLabel("HOME", &essAssets->ostrich24);
    buttHome.setPos(ofGetWidth()-70, ofGetHeight() -40); 
    buttHome.setColor(essAssets->ess_white, essAssets->ess_white);
    buttHome.disableBG();
    
    buttResetXML.setLabel("RESET", &essAssets->ostrich30);
    buttResetXML.setColor(essAssets->ess_white, essAssets->ess_grey);
    buttResetXML.disableBG();
    buttResetXML.setPos (ofGetWidth() - (essAssets->ostrich30.getStringWidth("RESET")*2), 30);
    
    ofBackground(essAssets->ess_blue);
    
    int leftMargin = 5; 
    int dotMargin = 20; 
    navY = 40; 
    
    int appL = essAssets->ostrich19.getStringWidth("APP"); 
    int faqL = essAssets->ostrich19.getStringWidth("FAQ"); 
    int OHL = essAssets->ostrich19.getStringWidth("ORAL HISTORIES");
    int creatL = essAssets->ostrich19.getStringWidth("CREATORS");
    
    nApp.setLabel("APP", &essAssets->ostrich19); 
    nApp.setPos (leftMargin, navY); 
    nApp.disableBG();

    nFAQ.setLabel("FAQ", &essAssets->ostrich19); 
    nFAQ.setPos (appL + leftMargin + dotMargin, navY); 
    nFAQ.disableBG();
    
    nOralHistories.setLabel("ORAL HISTORIES", &essAssets->ostrich19); 
    nOralHistories.setPos (appL + faqL + leftMargin + dotMargin*2, navY ); 
    nOralHistories.disableBG();
        
    nCreators.setLabel("CREATORS", &essAssets->ostrich19); 
    nCreators.setPos (appL + faqL + OHL + leftMargin + dotMargin*3, navY); 
    nCreators.disableBG();
    
    nThanks.setLabel("THANK YOU", &essAssets->ostrich19); 
    nThanks.setPos (appL + faqL + OHL + creatL + leftMargin + dotMargin*4, navY); 
    nThanks.disableBG();
    
}

//------------------------------------------------------------------
void aboutScene::deactivate() {
    aboutScreen.clear();
}


//------------------------------------------------------------------
void aboutScene::draw() {

    cam.apply(); //put all our drawing under the ofxPanZoom effect
    //aboutScreen.draw (0,0, ofGetWidth(), ofGetHeight()); 
    nApp.draw(); 
    nFAQ.draw(); 
    nOralHistories.draw();
    nCreators.draw(); 
    nThanks.draw(); 
    
    textY = navY + 50; 
    

    
    switch(mgr.getCurScene()) {
        case ABOUT_SCENE_APP:
            
            
            
            nApp.setColor (essAssets->ess_yellow); 
            pApp.draw(0,textY,ofGetWidth(), pApp.height/2); 
            cam.reset();	//back to normal ofSetupScreen() projection            
            break;
            
        case ABOUT_SCENE_FAQ:
            
            nFAQ.setColor (essAssets->ess_yellow); 
            pFAQ.draw(0,textY,ofGetWidth(), pFAQ.height/2); 
            cam.reset();	//back to normal ofSetupScreen() projection            
            break;
            
        case ABOUT_SCENE_ORALHISTORIES:
            
            nOralHistories.setColor (essAssets->ess_yellow); 
            pOralHistories.draw(0,textY,ofGetWidth(), pOralHistories.height/2); 
            cam.reset();	//back to normal ofSetupScreen() projection            
            break;
            
        case ABOUT_SCENE_CREATORS:
            
            nCreators.setColor (essAssets->ess_yellow); 
            pCreators.draw(0,textY,ofGetWidth(), pCreators.height/2); 
            cam.reset();	//back to normal ofSetupScreen() projection            
            break;
            
        case ABOUT_SCENE_THANKYOU:
            
            nThanks.setColor (essAssets->ess_yellow); 
            pThanks.draw(0,textY,ofGetWidth(), pThanks.height/2); 
            cam.reset();	//back to normal ofSetupScreen() projection            
            break;
            
    }

    ofPushMatrix();
    ofSetColor(255, 255, 255); 
    buttHome.draw(); 
    ofPopMatrix();
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void aboutScene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    //buttHome.GLtouchDown(touch);
    buttResetXML.touchDown(touch);
    
    cam.touchDown(touch); //fw event to cam
    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y;     
    buttHome.touchDown(touch);
    nApp.touchDown(touchTemp); 
    nOralHistories.touchDown(touchTemp); 
    nCreators.touchDown(touchTemp); 
    nThanks.touchDown(touchTemp); 
    nFAQ.touchDown(touchTemp); 
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
    
    
    if (nApp.isPressed()) {
        canvasW = pApp.width;	
        canvasH = pApp.height;
        cam.lookAt( ofVec2f(canvasW/2, ofGetHeight()) );
        cam.setViewportConstrain( ofVec3f(0,0), ofVec3f(canvasW, canvasH));
        mgr.setCurScene(ABOUT_SCENE_APP); 
    } else if (nFAQ.isPressed()) {
        canvasW = pFAQ.width;	
        canvasH = pFAQ.height;
        cam.lookAt( ofVec2f(canvasW/2, ofGetHeight()) );
        cam.setViewportConstrain( ofVec3f(0,0), ofVec3f(canvasW, canvasH));
        mgr.setCurScene(ABOUT_SCENE_FAQ); 
    } else if (nOralHistories.isPressed()) {
        canvasW = pOralHistories.width;	
        canvasH = pOralHistories.height;
        cam.lookAt( ofVec2f(canvasW/2, ofGetHeight()) );
        cam.setViewportConstrain( ofVec3f(0,0), ofVec3f(canvasW, canvasH));
        mgr.setCurScene(ABOUT_SCENE_ORALHISTORIES); 
    } else if (nCreators.isPressed()) {
        canvasW = pCreators.width;	
        canvasH = pCreators.height;
        cam.lookAt( ofVec2f(canvasW/2, ofGetHeight()) );
        cam.setViewportConstrain( ofVec3f(0,0), ofVec3f(canvasW, canvasH));
        mgr.setCurScene(ABOUT_SCENE_CREATORS); 
    } else if (nThanks.isPressed()) {
        canvasW = pThanks.width;	
        canvasH = pThanks.height;
        cam.lookAt( ofVec2f(canvasW/2, ofGetHeight()) );
        cam.setViewportConstrain( ofVec3f(0,0), ofVec3f(canvasW, canvasH));
        mgr.setCurScene(ABOUT_SCENE_THANKYOU); 
    }


    if (buttHome.isPressed()) {
        essSM->setCurScene(SCENE_HOME);
    }
    if (buttResetXML.isPressed()) resetPlayed();
    
    buttResetXML.touchUp(touch);
    buttHome.touchUp(touch);
    button.touchUp(touch);
    
    cam.touchUp(touch); //fw event to cam

    ofVec3f panTouch =  cam.screenToWorld( ofVec3f( touch.x, touch.y) );	//convert touch (in screen units) to world units
    
    ofTouchEventArgs touchTemp;
    touchTemp.x = panTouch.x;
    touchTemp.y = panTouch.y;     
    
    nApp.touchUp(touchTemp); 
    nOralHistories.touchUp(touchTemp); 
    nCreators.touchUp(touchTemp); 
    nThanks.touchUp(touchTemp); 
    nFAQ.touchUp(touchTemp);
    
    
    nApp.setColor (essAssets->ess_white); 
    nOralHistories.setColor(essAssets->ess_white); 
    nCreators.setColor (essAssets->ess_white); 
    nThanks.setColor(essAssets->ess_white); 
    nFAQ.setColor(essAssets->ess_white); 
    
}

//--------------------------------------------------------------

void aboutScene::touchDoubleTap(ofTouchEventArgs &touch){
	cam.touchDoubleTap(touch); //fw event to cam
	cam.setZoom(1.0f);	//reset zoom
	cam.lookAt( ofVec2f(canvasW/2, canvasH/2) ); //reset position
    
    
    
}