
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "map1Scene.h"

//------------------------------------------------------------------
void map1Scene::setup() {

    x = 100;
    y = 100;
    w = 100;
    h = 100;
    color = 255;
    
    
}

//------------------------------------------------------------------
void map1Scene::update() {
    switch(mgr.getCurScene()) {
        case MAP1_SCENE_FIRST:
            //Do stuff
            break;            
    }
     ofSoundUpdate();
}

//------------------------------------------------------------------
void map1Scene::activate() {
    mgr.setCurScene(MAP1_SCENE_FIRST);
    
    map1Scene.loadImage("flattenFiles/Map1.png");
    map1Guide.loadImage("flattenFiles/Map1-guide.png");

    
    button.setPos(0, 0);
    button.setSize(ofGetWidth(), ofGetHeight());
    button.disableBG();
    rectHome.set(ofGetWidth()-50, ofGetHeight()-30, 70, 30);
    buttHome.setLabel("HOME", &essAssets->ostrich24);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
    
    rectLoc.set(11, 13, essAssets->ostrich24.getStringWidth("BALCONY") + 10, essAssets->ostrich24.getStringHeight("BALCONY") + 10);
    
    OHmap1 = loadXML ("1"); //load first floor map

    for (int i = 0; i < OHmap1.size(); i++) {  
        OHmap1[i].setup(); 
        //OHmap1[i].audio.loadSound(OHmap1[i].path);
        cout << "setting up " + OHmap1[i].name << endl;
    }    
    
    buttonState = 0; 
    lastButton = -1;
    currentButton = 0; 
}

//------------------------------------------------------------------
void map1Scene::deactivate() {
    
    map1Scene.clear();

}


//------------------------------------------------------------------
void map1Scene::draw() {

    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP1_SCENE_FIRST:
            
            ofEnableAlphaBlending();
            
            //the map
            ofSetColor(255, 255, 255); 
            map1Scene.draw(0,0, ofGetWidth(), ofGetHeight()); 
            
            //home button
            ofSetColor(essAssets->ess_blue); 
            ofRect(rectHome.x - 8, rectHome.y - 4, rectHome.width, rectHome.height);
            buttHome.setColor(essAssets->ess_white, essAssets->ess_grey);
            buttHome.draw(); 
            
            //title
            ofSetColor(essAssets->ess_blue);
            ofRect(rectLoc.x-5, rectLoc.y-4, rectLoc.width, rectLoc.height); 
            ofSetColor(essAssets->ess_grey);
            essAssets->ostrich24.drawString("BALCONY", rectLoc.x, rectLoc.y);
            
            for (int i = 0; i < OHmap1.size(); i++) {            
                OHmap1[i].drawDot(); 
            }
            
            
            //draw the points (OH)
            for (int i = 0; i < OHmap1.size(); i++) { 
                
                bool drawTempBox; 
                
                glPushMatrix();
                
                glTranslatef(OHmap1[i].loc.x, OHmap1[i].loc.y, 0); 
                
                ofRotateZ(shiftRotate());
                
                if (OHmap1[i].isDrawn) {
                    OHmap1[i].drawInfo();
                    drawTempBox = false; // enable if you want to see the bounds of the button
                }
                
                glPopMatrix();
                
                if (OHmap1[i].isDrawn) {
                    if (drawTempBox) OHmap1[i].drawTouchBoxSize(shiftRotate());
                }
            }
            
            
            ofDisableAlphaBlending();
            
            //style guide when left side is touched
            ofSetColor(255, 255, 255);
            if (drawGuide) map1Guide.draw(0, 0, ofGetWidth(), ofGetHeight());
            
            break;
    }

}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map1Scene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);

    ofTouchEventArgs touchTemp;
    touchTemp.x = touch.x + 50; 
    touchTemp.y = touch.y; 
    
     for (int i = 0; i < OHmap1.size(); i++) {
        OHmap1[i].spotButn.touchDown(touch);
        //OHmap1[i].playButn.GLtouchDown(touch); 
         }
    
    buttHome.touchDown(touch);
}


//--------------------------------------------------------------
void map1Scene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);

    
    for (int i = 0; i < OHmap1.size(); i++) {
        OHmap1[i].spotButn.touchMoved(touch);
        //OHmap1[i].playButn.GLtouchMoved(touch);
    }


}


//--------------------------------------------------------------
void map1Scene::touchUp(ofTouchEventArgs &touch){

    /*
    for (int i = 0; i < OHmap1.size(); i++) { 
        
        if (OHmap1[i].spotButn.isPressed()) {
            for (int j = 0; j < OHmap1.size(); j++) {
                OHmap1[j].isDrawn = false; 
            }
            OHmap1[i].isDrawn = true; 
            OHmap1[i].canPlay = true;
        }
        

        if (OHmap1[i].playButn.isPressed() && !OHmap1[i].canPlay) {
           
            if (!OHmap1[i].audio.getIsPlaying()){
                OHmap1[i].play(); 
                cout << OHmap1[i].name + "is playing" << endl; 
            } else {
                OHmap1[i].pause();
                cout << OHmap1[i].name + "is paused" << endl; 
            }
        } 
    }
     */
    
    //when you press outside the spots, draw nothing
    for (int i = 0; i < OHmap1.size(); i++) { 
    if (button.isPressed() && !OHmap1[i].spotButn.isPressed()) {
            OHmap1[i].isDrawn = false; 
    }
    }
 
    for (int i = 0; i < OHmap1.size(); i++) { 

        
        if (OHmap1[i].spotButn.isPressed()) {
          currentButton = i; 
            if (currentButton != lastButton) {
                buttonState = 0; 
                
            } else {
                buttonState = 1;
            }
            
        switch (buttonState) {
            case 0:
                OHmap1[i].isDrawn = true; 
                break;
                
            case 1:
                OHmap1[i].isDrawn = true; 
                if (!OHmap1[i].audio.getIsPlaying()){
                    OHmap1[i].play(); 
                    setXMLtoPlayed("1",i); 
                    cout << OHmap1[i].name + "is playing" << endl; 
                } else {
                    OHmap1[i].pause();
                    cout << OHmap1[i].name + "is paused" << endl; 
                }
                break;
        } 
        } 
        lastButton = currentButton;  

    }

    
    for (int i = 0; i < OHmap1.size(); i++) {
        OHmap1[i].spotButn.touchUp(touch);
        //OHmap1[i].playButn.GLtouchUp(touch);
    }
    
    if (buttHome.isPressed()) {
        essSM->setCurScene(SCENE_HOME);
        for (int i = 0; i < OHmap1.size(); i++) { 
            OHmap1[i].pause();
        }
    }
    
    //for the guides    
    if (touch.x > ofGetWidth() - 30) {
        drawGuide = true; 
    } else if (touch.x < 30) {
        drawGuide = false; 
    }
    
    
    
    buttHome.touchUp(touch);
    button.touchUp(touch);
}