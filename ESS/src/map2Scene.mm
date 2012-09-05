
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
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
    
    OHmap2 = loadXML ("2"); //load first floor map
    
    for (int i = 0; i < OHmap2.size(); i++) {  
        OHmap2[i].setup(); 
        //OHmap2[i].audio.loadSound(OHmap2[i].path);
        cout << "setting up " + OHmap2[i].name << endl;
    }    
    
    buttonState = 0; 
    lastButton = -1;
    currentButton = 0; 
    
    
    map2Scene.loadImage("flattenFiles/Map2.png");
    guide2.loadImage("flattenFiles/Map2-guide.png");
    
    button.setSize(ofGetWidth(), ofGetHeight());
    button.setPos(0, 0);
    button.disableBG();
    
    rectHome.set(427, 290, 45, 20);
    buttHome.enableBG();
    buttHome.setLabel("HOME", &essAssets->ostrich24);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
    
    rectLoc.set(11, 13, essAssets->ostrich24.getStringWidth("MAIN SANCTUARY") + 10, essAssets->ostrich24.getStringHeight("MAIN SANCTUARY") + 10);
    
    drawGuide = false; 
    
}

//------------------------------------------------------------------
void map2Scene::deactivate() {
    
    map2Scene.clear();
    
}


//------------------------------------------------------------------
void map2Scene::draw() {

    button.draw();
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP2_SCENE_FIRST:
            
            ofEnableAlphaBlending();
            
            //the map
            ofSetColor(255, 255, 255); 
            map2Scene.draw(0,0, ofGetWidth(), ofGetHeight()); 
            
            //home button
            ofSetColor(essAssets->ess_blue); 
            ofRect(rectHome.x - 8, rectHome.y - 4, rectHome.width, rectHome.height);
            buttHome.setColor(essAssets->ess_white, essAssets->ess_grey);
            buttHome.draw(); 
            
            //title
            ofSetColor(essAssets->ess_blue);
            ofRect(rectLoc.x-5, rectLoc.y-4, rectLoc.width, rectLoc.height); 
            ofSetColor(essAssets->ess_grey);
            essAssets->ostrich24.drawString("MAIN SANCTUARY", rectLoc.x, rectLoc.y);
            
            for (int i = 0; i < OHmap2.size(); i++) {            
                OHmap2[i].drawDot(); 
            }
            
            
            //draw the points (OH)
            for (int i = 0; i < OHmap2.size(); i++) {            
                                
                glPushMatrix();
                
                if (shiftRotate() == 90) {
                    glTranslatef(OHmap2[i].loc.x+OHmap2[i].playButn.rect.height, OHmap2[i].loc.y, 0);    
                } else if (shiftRotate() == 270) {
                    glTranslatef(OHmap2[i].loc.x, OHmap2[i].loc.y+OHmap2[i].playButn.rect.width, 0);
                } else if (shiftRotate() == 180) {
                    glTranslatef(OHmap2[i].loc.x+OHmap2[i].playButn.rect.height, OHmap2[i].loc.y+OHmap2[i].playButn.rect.width, 0);
                } else {
                    glTranslatef(OHmap2[i].loc.x, OHmap2[i].loc.y, 0);                            
                }
                
                ofRotateZ(shiftRotate());
                
                if (OHmap2[i].isDrawn) OHmap2[i].drawInfo();
                
                glPopMatrix();
            }
            
            
            ofDisableAlphaBlending();
            
            //style guide when left side is touched
            ofSetColor(255, 255, 255);
            if (drawGuide) guide2.draw(0, 0, ofGetWidth(), ofGetHeight());
            
            break;
            
    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map2Scene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    buttHome.touchDown(touch);
    
    for (int i = 0; i < OHmap2.size(); i++) {
        OHmap2[i].spotButn.touchDown(touch);
    }
}


//--------------------------------------------------------------
void map2Scene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
    
    for (int i = 0; i < OHmap2.size(); i++) {
        OHmap2[i].spotButn.touchMoved(touch);
    }
}


//--------------------------------------------------------------
void map2Scene::touchUp(ofTouchEventArgs &touch){

    //when you press outside the spots, draw nothing
    for (int i = 0; i < OHmap2.size(); i++) { 
        if (button.isPressed() && !OHmap2[i].spotButn.isPressed()) {
            OHmap2[i].isDrawn = false; 
        }
    }
    
    
    for (int i = 0; i < OHmap2.size(); i++) { 
        
        if (OHmap2[i].spotButn.isPressed()) {
            cout << ofToString(buttonState) + "isButtonState" << endl; 
            cout << "current button: " + ofToString(currentButton) << endl;             currentButton = i; 
            if (currentButton != lastButton) {
                buttonState = 0; 
                
            } else {
                buttonState = 1;
            }
            
            switch (buttonState) {
                case 0:
                    for (int j = 0; j < OHmap2.size(); j++) {
                        OHmap2[j].isDrawn = false; 
                    }
                    OHmap2[i].isDrawn = true; 
                    break;
                    
                case 1:
                    OHmap2[i].isDrawn = true; 
                    if (!OHmap2[i].audio.getIsPlaying()){
                        OHmap2[i].play(); 
                        setXMLtoPlayed("2",i); 
                        cout << OHmap2[i].name + "is playing" << endl; 
                    } else {
                        OHmap2[i].pause();
                        cout << OHmap2[i].name + "is paused" << endl; 
                    }
                    break;
            }   
            
            
        }
        
        lastButton = currentButton;         
    }
    
    
    for (int i = 0; i < OHmap2.size(); i++) {
        OHmap2[i].spotButn.touchUp(touch);
    }
    
     if (buttHome.isPressed()) essSM->setCurScene(SCENE_HOME);
    
    if (touch.x > ofGetWidth() - 30) {
            drawGuide = true; 
    } else if (touch.x < 30) {
         drawGuide = false; 
    }
    
    buttHome.touchUp(touch);
    button.touchUp(touch);

}


