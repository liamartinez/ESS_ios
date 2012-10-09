
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "map4Scene.h"

//------------------------------------------------------------------
void map4Scene::setup() {
    
    
}



//------------------------------------------------------------------
void map4Scene::update() {
    switch(mgr.getCurScene()) {
        case MAP4_SCENE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void map4Scene::activate() {
    mgr.setCurScene(MAP4_SCENE_FIRST);
    
    OHmap4 = loadXML ("4"); //load first floor map
    
    for (int i = 0; i < OHmap4.size(); i++) {  
        OHmap4[i].setup(); 
        cout << "setting up " + OHmap4[i].name << endl;
    }    
    
    buttonState = 0; 
    lastButton = -1;
    currentButton = 0; 

    
    map4Scene.loadImage("flattenFiles/Map4.png");
    map4Guide.loadImage("flattenFiles/Map4-guide.png");
    
    rectHome.set(427, 290, 45, 20);
    buttHome.enableBG();
    buttHome.setLabel("HOME", &essAssets->ostrich24);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
    
    rectLoc.set(11, 13, essAssets->ostrich24.getStringWidth("ELDRIDGE ST.") + 10, essAssets->ostrich24.getStringHeight("ELDRIDGE ST.") + 10);

    

    
    
}

//------------------------------------------------------------------
void map4Scene::deactivate() {

    map4Scene.clear();
    
}


//------------------------------------------------------------------
void map4Scene::draw() {
    
    drawGrid();
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP4_SCENE_FIRST:
            
            ofEnableAlphaBlending();
                        
            //the map
            ofSetColor(255, 255, 255); 
            map4Scene.draw(0,0, ofGetWidth(), ofGetHeight()); 
            
            //home button
            ofSetColor(essAssets->ess_blue); 
            ofRect(rectHome.x - 8, rectHome.y - 4, rectHome.width, rectHome.height);
            buttHome.setColor(essAssets->ess_white, essAssets->ess_grey);
            buttHome.draw(); 
            
            //title
            ofSetColor(essAssets->ess_blue);
            ofRect(rectLoc.x-5, rectLoc.y-4, rectLoc.width, rectLoc.height); 
            ofSetColor(essAssets->ess_grey);
            essAssets->ostrich24.drawString("ELDRIDGE ST.", rectLoc.x, rectLoc.y);
            
            for (int i = 0; i < OHmap4.size(); i++) {            
                OHmap4[i].drawDot(); 
            }
            
            
            //draw the points (OH)
            for (int i = 0; i < OHmap4.size(); i++) { 
                
                bool drawTempBox; 
                
                glPushMatrix();
                
                glTranslatef(OHmap4[i].loc.x, OHmap4[i].loc.y, 0); 
                
                ofRotateZ(shiftRotate());
                
                if (OHmap4[i].isDrawn) {
                    OHmap4[i].drawInfo();
                    drawTempBox = false; // enable if you want to see the bounds of the button
                }
                
                glPopMatrix();
                
                if (OHmap4[i].isDrawn) {
                    if (drawTempBox) OHmap4[i].drawTouchBoxSize(shiftRotate());
                }
            }
            
            //style guide when left side is touched
            ofSetColor(255, 255, 255);
            if (drawGuide) map4Guide.draw(0, 0, ofGetWidth(), ofGetHeight());
            
            ofDisableAlphaBlending();

            
            break;
            
    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map4Scene::touchDown(ofTouchEventArgs &touch){

    buttHome.touchDown(touch);
}


//--------------------------------------------------------------
void map4Scene::touchMoved(ofTouchEventArgs &touch){

}


//--------------------------------------------------------------
void map4Scene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == MAP4_SCENE_TOTAL-1) {
            essSM->setCurScene(SCENE_ABOUT);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
     */
    
    if (touch.x > ofGetWidth() - 30) {
        drawGuide = true; 
    } else if (touch.x < 30) {
        drawGuide = false; 
    }
    
    cout << "x:" << touch.x << " y: " << touch.y << endl; 
    
    if (buttHome.isPressed()) essSM->setCurScene(SCENE_HOME);
    
    buttHome.touchUp(touch);

}