
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
	
	aboutScreen.loadImage("flattenFiles/AboutHorizontal.png");
    
    pApp.loadImage ("flattenFiles/about/AboutTextAPP.png"); 
    pOralHistories.loadImage ("flattenFiles/about/AboutTextORALHISTORIES.png"); 
    pCreators.loadImage ("flattenFiles/about/AboutTextCREATORS.png"); 
    pThanks.loadImage ("flattenFiles/about/AboutTextTHANKYOU.png"); 
    pFAQ.loadImage("flattenFiles/about/AboutTextFAQ.png"); 
    
    canvasW = pApp.width/2;	//these define where the camera can pan to
    canvasH = pApp.height/2;
    
    cam.setZoom(1.0f);
	cam.setMinZoom(1.0f);
	cam.setMaxZoom(2.0f);
	cam.setScreenSize( ofGetWidth(), ofGetHeight() ); //tell the system how large is out screen
    
	cam.lookAt( ofVec2f(canvasW/2, 160) );
    cam.setViewportConstrain( ofVec3f(0,0), ofVec3f(canvasW, canvasH)); //limit browseable area, in world units

    rectHome.set(ofGetWidth()-70, ofGetHeight() -30, 70, 30);
    
    buttHome.setLabel("HOME", &essAssets->ostrich24);
    buttHome.setRect(rectHome); 
    buttHome.setColor(essAssets->ess_white, essAssets->ess_white);
    buttHome.disableBG();
    
    ofBackground(essAssets->ess_blue);
    
	leftMargin = 5; 
    dotMargin = 20; 
    navY = 40; 
    
	appL = essAssets->ostrich19.getStringWidth("APP"); 
    faqL = essAssets->ostrich19.getStringWidth("FAQ"); 
    OHL = essAssets->ostrich19.getStringWidth("ORAL HISTORIES");
    creatL = essAssets->ostrich19.getStringWidth("CREATORS");
    
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

	string tEld = "THE MUSEUM AT ELDRIDGE STREET"; 
	string tAnna = "WWW.ANNAPINKAS.COM";
	string tCarlin = "WWW.CARLINWRAGG.NET";
	string tLia = "WWW.LIAMARTINEZ.COM";
	string tChien = "WWW.CHIENYULIN.COM";
	string tMerche = "HTTP://HALF-HALF.ES"; 
	string tRyan = "WWW.RYANBILLIA.COM";
	string tFiber = "FIBER INK STUDIO"; 
    
	//link buttons
	lEldridge.setLabel(tEld, &essAssets->ostrich20);
	lEldridge.setColor(essAssets->ess_white, essAssets->ess_grey);
	lEldridge.setPos(57, 169);
	lEldridge.disableBG();
		
	//creators page
	int linkPosX = 12;
	int linkPosY = 115; 
	int linkOffY = 48; 
	lAnna.setLabel(tAnna, &essAssets->ostrich20);
	lAnna.setColor(essAssets->ess_white, essAssets->ess_grey);
	lAnna.setPos(linkPosX, linkPosY);
	lAnna.disableBG();
	
	lCarlin.setLabel(tCarlin, &essAssets->ostrich20);
	lCarlin.setColor(essAssets->ess_white, essAssets->ess_grey);
	lCarlin.setPos(linkPosX, linkPosY + linkOffY);
	lCarlin.disableBG();
	
	lChien.setLabel(tChien, &essAssets->ostrich20);
	lChien.setColor(essAssets->ess_white, essAssets->ess_grey);
	lChien.setPos(linkPosX, linkPosY + linkOffY*2);
	lChien.disableBG();
	
	lLia.setLabel(tLia, &essAssets->ostrich20);
	lLia.setColor(essAssets->ess_white, essAssets->ess_grey);
	lLia.setPos(linkPosX, linkPosY + linkOffY*3);
	lLia.disableBG();
	
	lMerche.setLabel(tMerche, &essAssets->ostrich20); 
	lMerche.setColor(essAssets->ess_white, essAssets->ess_grey);
	lMerche.setPos(linkPosX, linkPosY + linkOffY*4);
	lMerche.disableBG();
	
	lRyan.setLabel(tRyan, &essAssets->ostrich20);
	lRyan.setColor(essAssets->ess_white, essAssets->ess_grey);
	lRyan.setPos(linkPosX, linkPosY + linkOffY*5);
	lRyan.disableBG();

	//thank you page
	lFiber.setLabel(tFiber, &essAssets->ostrich20);
	lFiber.setColor(essAssets->ess_white, essAssets->ess_grey);
	lFiber.setPos(140, 1125);
	lFiber.disableBG();
	
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
	
	ofSetColor(essAssets->ess_grey);
	ofCircle(leftMargin + appL + (dotMargin), navY + 18, 5);
	ofCircle(leftMargin + appL + faqL + (dotMargin*2), navY + 18, 5);
	ofCircle(leftMargin + appL + faqL + OHL + (dotMargin*3), navY + 18, 5);
	ofCircle(leftMargin + appL + faqL + OHL + creatL + (dotMargin*4), navY + 18, 5);
	
	ofSetColor(255);
    
    switch(mgr.getCurScene()) {
        case ABOUT_SCENE_APP:

            nApp.setColor (essAssets->ess_yellow); 
            pApp.draw(0,textY,ofGetWidth(), pApp.height/2); 
			lEldridge.draw();          
            break;
            
        case ABOUT_SCENE_FAQ:

            nFAQ.setColor (essAssets->ess_yellow); 
            pFAQ.draw(0,textY,ofGetWidth(), pFAQ.height/2);         
            break;
            
        case ABOUT_SCENE_ORALHISTORIES:
            
            nOralHistories.setColor (essAssets->ess_yellow); 
            pOralHistories.draw(0,textY,ofGetWidth(), pOralHistories.height/2);             
            break;
            
        case ABOUT_SCENE_CREATORS:
            
            nCreators.setColor (essAssets->ess_yellow); 
            pCreators.draw(0,textY,ofGetWidth(), pCreators.height/2); 
			lAnna.draw();
			lCarlin.draw();
			lChien.draw();
			lLia.draw();
			lMerche.draw();
			lRyan.draw();
            break;
            
        case ABOUT_SCENE_THANKYOU:
            
            nThanks.setColor (essAssets->ess_yellow); 
            pThanks.draw(0,textY,ofGetWidth(), pThanks.height/2); 
			lFiber.draw();
         
            break;
    }
	
	essAssets->ostrich24.drawString("ABOUT", 15, 15);
	cam.reset();	//back to normal ofSetupScreen() projection   
	

    ofPushMatrix();
    ofSetColor(essAssets->ess_blue);
	ofRect(rectHome.x, rectHome.y,60, 27);
    buttHome.draw(); 
    ofPopMatrix();
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void aboutScene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    //buttHome.GLtouchDown(touch);
    
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
	
	lEldridge.touchDown(touchTemp); 
	lAnna.touchDown(touchTemp);
	lCarlin.touchDown(touchTemp); 
	lLia.touchDown(touchTemp);
	lChien.touchDown(touchTemp); 
	lMerche.touchDown(touchTemp); 
	lRyan.touchDown(touchTemp); 
	lFiber.touchDown(touchTemp); 
	
}


//--------------------------------------------------------------
void aboutScene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
    
    cam.touchMoved(touch); //fw event to cam
}


//--------------------------------------------------------------
void aboutScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes

    if (nApp.isPressed()) {
        canvasH = pApp.height;        
        mgr.setCurScene(ABOUT_SCENE_APP); 
    } else if (nFAQ.isPressed()) {
        canvasH = pFAQ.height;
        mgr.setCurScene(ABOUT_SCENE_FAQ); 
    } else if (nOralHistories.isPressed()) {
        canvasH = pOralHistories.height;
        mgr.setCurScene(ABOUT_SCENE_ORALHISTORIES); 
    } else if (nCreators.isPressed()) {
        canvasH = pCreators.height;
        mgr.setCurScene(ABOUT_SCENE_CREATORS); 
    } else if (nThanks.isPressed()) {
        canvasH = pThanks.height;
        mgr.setCurScene(ABOUT_SCENE_THANKYOU); 
    }

	if (nApp.isPressed() || nOralHistories.isPressed() || nCreators.isPressed() || nThanks.isPressed() || nFAQ.isPressed()) {
		cam.lookAt( ofVec2f(canvasW/2, ofGetHeight()/2) );
		cam.setViewportConstrain( ofVec3f(0,0), ofVec3f(canvasW, canvasH));
	}
	
    if (buttHome.isPressed()) {
        essSM->setCurScene(SCENE_HOME);
    }

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

	//link URLs
	NSURL *uEldridge = [ [ NSURL alloc ] initWithString: @"http://www.eldridgestreet.org" ];
	NSURL *uAnna = [ [ NSURL alloc ] initWithString: @"http://www.annapinkas.com" ];
	NSURL *uCarlin = [ [ NSURL alloc ] initWithString: @"http://www.carlinwragg.net" ];
	NSURL *uLia = [ [ NSURL alloc ] initWithString: @"http://www.liamartinez.com" ];
	NSURL *uChien = [ [ NSURL alloc ] initWithString: @"http://www.chienyulin.com" ];
	NSURL *uMerche = [ [ NSURL alloc ] initWithString: @"http://www.half-half.es" ];
	NSURL *uRyan = [ [ NSURL alloc ] initWithString: @"http://www.ryanbillia.com" ];
	NSURL *uFiber = [ [ NSURL alloc ] initWithString: @"http://fiberinkstudio.com/" ];
	
	if (mgr.getCurScene() == ABOUT_SCENE_APP) {
		if (lEldridge.isPressed())[[UIApplication sharedApplication] openURL:uEldridge];
	}
	
	if (mgr.getCurScene() == ABOUT_SCENE_CREATORS) {
		if (lAnna.isPressed()) [[UIApplication sharedApplication] openURL:uAnna];
		if (lCarlin.isPressed()) [[UIApplication sharedApplication] openURL:uCarlin]; 
		if (lLia.isPressed()) [[UIApplication sharedApplication] openURL:uLia];
		if (lChien.isPressed()) [[UIApplication sharedApplication] openURL:uChien];
		if (lMerche.isPressed()) [[UIApplication sharedApplication] openURL:uMerche];
		if (lRyan.isPressed()) [[UIApplication sharedApplication] openURL:uRyan];
	}
	
	if (mgr.getCurScene() == ABOUT_SCENE_THANKYOU) {
		if (lFiber.isPressed()) [[UIApplication sharedApplication] openURL:uFiber];
	}
	
	lEldridge.touchUp(touchTemp); 
	lAnna.touchUp(touchTemp);
	lCarlin.touchUp(touchTemp); 
	lLia.touchUp(touchTemp);
	lChien.touchUp(touchTemp); 
	lMerche.touchUp(touchTemp); 
	lRyan.touchUp(touchTemp); 
	lFiber.touchUp(touchTemp); 
	
	cout << touch.x << " " << touch.y << endl; 
	
}

//--------------------------------------------------------------

void aboutScene::touchDoubleTap(ofTouchEventArgs &touch){
	cam.touchDoubleTap(touch); //fw event to cam
	cam.setZoom(1.0f);	//reset zoom
	cam.lookAt( ofVec2f(canvasW/2, canvasH/2) ); //reset position
    
    
    
}