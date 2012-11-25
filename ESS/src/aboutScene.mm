
//  Created by Lia Martinez on 2/27/12.
//  Copyright (c) 2012 Storywalks at Eldridge St.. All rights reserved.
//

#include <iostream>
#include "aboutScene.h"

//------------------------------------------------------------------
void aboutScene::setup() {
    
    
}



//------------------------------------------------------------------
void aboutScene::update() {
	
	Tweenzor::update( ofGetElapsedTimeMillis() );
	
    switch(mgr.getCurScene()) {
        case ABOUT_SCENE_APP:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void aboutScene::activate() {
    mgr.setCurScene(ABOUT_SCENE_APP);
	essSM->setIsDragging(true); 
	
	aboutScreen.loadImage("flattenFiles/AboutHorizontal.png");
    
    pApp.loadImage ("flattenFiles/about/AboutTextAPP.png"); 
    pOralHistories.loadImage ("flattenFiles/about/AboutTextORALHISTORIES.png"); 
    pCreators.loadImage ("flattenFiles/about/AboutTextCREATORS.png"); 
    pThanks.loadImage ("flattenFiles/about/AboutTextTHANKYOU.png"); 
    pFAQ.loadImage("flattenFiles/about/AboutTextFAQ.png"); 

	
    rectHome.set(ofGetWidth()-70, ofGetHeight() -30, 70, 30);
    
	
    buttHome.setLabel("HOME", &essAssets->ostrich24);
    buttHome.setRect(rectHome); 
	buttHome.setColor(essAssets->ess_white, essAssets->ess_grey);
    buttHome.disableBG();
	
	
    
    ofBackground(essAssets->ess_blue);
    
	leftMargin = 5; 
    dotMargin = 20; 
    navY = 40; 
    
	appL = essAssets->ostrich19.getStringWidth("APP"); 
    faqL = essAssets->ostrich19.getStringWidth("FAQ"); 
    OHL = essAssets->ostrich19.getStringWidth("CONGREGANTS");
    creatL = essAssets->ostrich19.getStringWidth("CREATORS");
    
    nApp.setLabel("APP", &essAssets->ostrich19); 
    nApp.setPos (leftMargin, navY); 
    nApp.disableBG();
	
    nFAQ.setLabel("FAQ", &essAssets->ostrich19); 
    nFAQ.setPos (appL + leftMargin + dotMargin, navY); 
    nFAQ.disableBG();
    
    nOralHistories.setLabel("CONGGREGANTS", &essAssets->ostrich19); 
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
	string tCarlin = "WWW.CARLINMWRAGG.NET";
	string tLia = "WWW.LIAMARTINEZ.COM";
	string tChien = "WWW.CHIENYULIN.COM";
	string tMerche = "HTTP://HALF-HALF.ES"; 
	string tRyan = "WWW.RYANBILLIA.COM";
	string tFiber = "FIBER INK STUDIO"; 
	string tJoey1 = "JOEY"; 
	string tJoey2 = "WEISENBERG"; 
    
	//link buttons
	lEldridge.setLabel(tEld, &essAssets->ostrich20);
	lEldridge.setColor(essAssets->ess_white, essAssets->ess_grey);
	lEldridge.setPos(57, 171);
	lEldridge.disableBG();
	
	//creators page
	int linkPosX = 14;
	int linkPosY = 98; 
	int linkOffY = 48; 
	
	lCarlin.setLabel(tCarlin, &essAssets->ostrich20);
	lCarlin.setColor(essAssets->ess_white, essAssets->ess_grey);
	lCarlin.setPos(linkPosX, linkPosY);
	lCarlin.disableBG();
	
	lAnna.setLabel(tAnna, &essAssets->ostrich20);
	lAnna.setColor(essAssets->ess_white, essAssets->ess_grey);
	lAnna.setPos(linkPosX, linkPosY + linkOffY);
	lAnna.disableBG();
		
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
	lFiber.setPos(159, 147);
	lFiber.disableBG();
	
	lJoey1.setLabel(tJoey1, &essAssets->ostrich20);
	lJoey1.setColor(essAssets->ess_white, essAssets->ess_grey);
	lJoey1.setPos(395, 99);
	lJoey1.disableBG();
	
	lJoey2.setLabel(tJoey2, &essAssets->ostrich20);
	lJoey2.setColor(essAssets->ess_white, essAssets->ess_grey);
	lJoey2.setPos(12, 123);
	lJoey2.disableBG();
	
	//tweening
	Tweenzor::init();
	tweenie = 0; 

}

//------------------------------------------------------------------
void aboutScene::deactivate() {
    aboutScreen.clear();
}


//------------------------------------------------------------------
void aboutScene::draw() {

	//ofEnableAlphaBlending();

	
	ofPushMatrix();
	ofTranslate(0, tweenie);
    nApp.draw(); 
    nFAQ.draw(); 
    nOralHistories.draw();
    nCreators.draw(); 
    nThanks.draw(); 
	
    textY = navY + 35; 
	
	ofSetColor(essAssets->ess_grey);
	ofCircle(leftMargin + appL + (dotMargin), navY + 18, 5);
	ofCircle(leftMargin + appL + faqL + (dotMargin*2), navY + 18, 5);
	ofCircle(leftMargin + appL + faqL + OHL + (dotMargin*3), navY + 18, 5);
	ofCircle(leftMargin + appL + faqL + OHL + creatL + (dotMargin*4), navY + 18, 5);
	
	ofSetColor(255);
    
    switch(mgr.getCurScene()) {
        case ABOUT_SCENE_APP:
			
            nApp.setColor (essAssets->ess_yellow); 
            pApp.draw(0,textY,ofGetWidth(), pApp.height); 
			maxBottom = pApp.height;
			lEldridge.draw();          
            break;
            
        case ABOUT_SCENE_FAQ:
			
            nFAQ.setColor (essAssets->ess_yellow); 
            pFAQ.draw(0,textY,ofGetWidth(), pFAQ.height);   
			maxBottom = pFAQ.height;
            break;
            
        case ABOUT_SCENE_ORALHISTORIES:
            
            nOralHistories.setColor (essAssets->ess_yellow); 
            pOralHistories.draw(0,textY,ofGetWidth(), pOralHistories.height); 
            maxBottom = pOralHistories.height;
            break;
            
        case ABOUT_SCENE_CREATORS:
            
            nCreators.setColor (essAssets->ess_yellow); 
            pCreators.draw(0,textY,ofGetWidth(), pCreators.height); 
			maxBottom = pCreators.height;
			lAnna.draw();
			lCarlin.draw();
			lChien.draw();
			lLia.draw();
			lMerche.draw();
			lRyan.draw();
            break;
            
        case ABOUT_SCENE_THANKYOU:
            
            nThanks.setColor (essAssets->ess_yellow); 
            pThanks.draw(0,textY,ofGetWidth(), pThanks.height); 
			maxBottom = pThanks.height;
			lFiber.draw();
			lJoey1.draw();
			lJoey2.draw();
			
            break;
    }

	essAssets->ostrich24.drawString("ABOUT", 15, 15);
	ofPopMatrix();
	


    ofPushMatrix();
    ofSetColor(essAssets->ess_blue);
	ofRect(rectHome.x, rectHome.y,80, 57);
    buttHome.draw(); 
    ofPopMatrix();

}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void aboutScene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);

    buttHome.touchDown(touch);
	
	ofTouchEventArgs tweenedTouch; 
	tweenedTouch.x = touch.x; 
	tweenedTouch.y = touch.y - tweenie; 
	
    nApp.touchDown(tweenedTouch); 
    nOralHistories.touchDown(tweenedTouch); 
    nCreators.touchDown(tweenedTouch); 
    nThanks.touchDown(tweenedTouch); 
    nFAQ.touchDown(tweenedTouch); 
	
	lEldridge.touchDown(tweenedTouch); 
	lAnna.touchDown(tweenedTouch);
	lCarlin.touchDown(tweenedTouch); 
	lLia.touchDown(tweenedTouch);
	lChien.touchDown(tweenedTouch); 
	lMerche.touchDown(tweenedTouch); 
	lRyan.touchDown(tweenedTouch); 
	lFiber.touchDown(tweenedTouch); 
	lJoey1.touchDown(tweenedTouch); 
	lJoey2.touchDown(tweenedTouch); 
	
	downY = touch.y; 
	offset = downY - tweenie;
	dragTimer = ofGetElapsedTimeMillis(); 
	cout << "downY: " << downY << endl; 

	
}


//--------------------------------------------------------------
void aboutScene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);

	tweenGo = true; 
	
	//if the finger hasn't moved 10 pixels AND over a second of time has ellapsed
	if (abs(downY - touch.y) > 10 && ofGetElapsedTimeMillis() - dragTimer > 1000) {
		cout << "RESET" << endl; 
		downY = touch.y; 
		cout << "downY: " << downY << endl; 
		offset = downY - tweenie;
		dragTimer = ofGetElapsedTimeMillis(); 
	}

	tweenie = touch.y - offset;
	
	ofTouchEventArgs tweenedTouch; 
	tweenedTouch.x = touch.x; 
	tweenedTouch.y = touch.y - tweenie; 
	ofRect(tweenedTouch.x, tweenedTouch.y, 30, 30);
	

}


//--------------------------------------------------------------
void aboutScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
	cout << "touch up" << endl; 
	
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
    
	startY = touch.y;
	if (tweenGo) {
	if (startY > downY) {
		cout << "startY: " << startY << " downY: " << downY << " GO DOWN" << endl; 
		endY = tweenie + (startY - downY)*1.5; 
		if (endY > 0) endY = 0; 
	} else if(startY < downY) {
		cout << "startY: " << startY << " downY: " << downY << " GO UP" << endl; 
		endY = tweenie - (downY - startY)*1.5; 
		if (endY < -maxBottom+ofGetHeight() - 100) endY = -maxBottom+ofGetHeight() - 100;  
	}
		Tweenzor::add(&tweenie, tweenie , endY, 0.f, 0.5f, EASE_OUT_SINE);
	}
	
	
	ofTouchEventArgs tweenedTouch; 
	tweenedTouch.x = touch.x; 
	tweenedTouch.y = touch.y - tweenie; 
	
	ofRect(tweenedTouch.x, tweenedTouch.y, 30, 30);

    nApp.touchUp(tweenedTouch); 
    nOralHistories.touchUp(tweenedTouch); 
    nCreators.touchUp(tweenedTouch); 
    nThanks.touchUp(tweenedTouch); 
    nFAQ.touchUp(tweenedTouch);
    
    nApp.setColor (essAssets->ess_white); 
    nOralHistories.setColor(essAssets->ess_white); 
    nCreators.setColor (essAssets->ess_white); 
    nThanks.setColor(essAssets->ess_white); 
    nFAQ.setColor(essAssets->ess_white); 
	
	//link URLs
	NSURL *uEldridge = [ [ NSURL alloc ] initWithString: @"http://www.eldridgestreet.org" ];
	NSURL *uAnna = [ [ NSURL alloc ] initWithString: @"http://www.annapinkas.com" ];
	NSURL *uCarlin = [ [ NSURL alloc ] initWithString: @"http://www.carlinmwragg.net" ];
	NSURL *uLia = [ [ NSURL alloc ] initWithString: @"http://www.liamartinez.com" ];
	NSURL *uChien = [ [ NSURL alloc ] initWithString: @"http://www.chienyulin.com" ];
	NSURL *uMerche = [ [ NSURL alloc ] initWithString: @"http://www.half-half.es" ];
	NSURL *uRyan = [ [ NSURL alloc ] initWithString: @"http://www.ryanbillia.com" ];
	NSURL *uFiber = [ [ NSURL alloc ] initWithString: @"http://fiberinkstudio.com" ];
	NSURL *uJoey = [ [ NSURL alloc ] initWithString: @"http://joeyweisenberg.com" ];
	
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
		if (lJoey1.isPressed() || lJoey2.isPressed()) [[UIApplication sharedApplication] openURL:uJoey];
	}
	
	lEldridge.touchUp(tweenedTouch); 
	lAnna.touchUp(tweenedTouch);
	lCarlin.touchUp(tweenedTouch); 
	lLia.touchUp(tweenedTouch);
	lChien.touchUp(tweenedTouch); 
	lMerche.touchUp(tweenedTouch); 
	lRyan.touchUp(tweenedTouch); 
	lFiber.touchUp(tweenedTouch); 
	lJoey1.touchUp(tweenedTouch); 
	lJoey2.touchUp(tweenedTouch); 	
}

//--------------------------------------------------------------


void aboutScene::touchDoubleTap(ofTouchEventArgs &touch){
	baseTouchDoubleTap(touch);
    
}

//--------------------------------------------------------------
void aboutScene::exit() {
	Tweenzor::destroy();
}