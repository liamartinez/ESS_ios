
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "map3Scene.h"

//------------------------------------------------------------------
void map3Scene::setup() {
    
    
}



//------------------------------------------------------------------
void map3Scene::update() {
    
    ofSoundUpdate();
    
    switch(mgr.getCurScene()) {
        case MAP3_SCENE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void map3Scene::activate() {
    mgr.setCurScene(MAP3_SCENE_FIRST);
    
    OHmap3 = loadXML ("3"); //load first floor map
    
    for (int i = 0; i < OHmap3.size(); i++) {  
        OHmap3[i].setup(); 
        //OHmap2[i].audio.loadSound(OHmap2[i].path);
        cout << "setting up " + OHmap3[i].name << endl;
    }    
    
    buttonState = 0; 
    lastButton = -1;
    currentButton = 0; 
    
    map3Scene.loadImage("flattenFiles/Map3.png");
    map3Guide.loadImage("flattenFiles/Map3-guide.png");
    
    rectHome.set(427, 290, 45, 20);
    buttHome.enableBG();
    buttHome.setLabel("HOME", &essAssets->ostrich24);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
    
    rectLoc.set(11, 13, essAssets->ostrich24.getStringWidth("LOWER SANCTUARY") + 10, essAssets->ostrich24.getStringHeight("LOWER SANCTUARY") + 10);
    
    drawGuide = false; 

    
    
}

//------------------------------------------------------------------
void map3Scene::deactivate() {
    
    map3Scene.clear();
    
}


//------------------------------------------------------------------
void map3Scene::draw() {
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case MAP3_SCENE_FIRST:
            
            ofEnableAlphaBlending();
            
            //the map
            ofSetColor(255, 255, 255); 
            map3Scene.draw(0,0, ofGetWidth(), ofGetHeight()); 
            
            //home button
            ofSetColor(essAssets->ess_blue); 
            ofRect(rectHome.x - 8, rectHome.y - 4, rectHome.width, rectHome.height);
            buttHome.setColor(essAssets->ess_white, essAssets->ess_grey);
            buttHome.draw(); 
            
            //title
            ofSetColor(essAssets->ess_blue);
            ofRect(rectLoc.x-5, rectLoc.y-4, rectLoc.width, rectLoc.height); 
            ofSetColor(essAssets->ess_grey);
            essAssets->ostrich24.drawString("LOWER SANCTUARY", rectLoc.x, rectLoc.y);
            
            for (int i = 0; i < OHmap3.size(); i++) {            
                OHmap3[i].drawDot(); 
            }
            
            
            //draw the points (OH)
            for (int i = 0; i < OHmap3.size(); i++) { 
                
                bool drawTempBox; 
                
                glPushMatrix();
                
                glTranslatef(OHmap3[i].loc.x, OHmap3[i].loc.y, 0); 
                
                ofRotateZ(shiftRotate());
                
                if (OHmap3[i].isDrawn) {
                    OHmap3[i].drawInfo();
                    drawTempBox = false; // enable if you want to see the bounds of the button
                }
                
                glPopMatrix();
                
                if (OHmap3[i].isDrawn) {
                    if (drawTempBox) OHmap3[i].drawTouchBoxSize(shiftRotate());
                }
            }
            
            //style guide when left side is touched
            ofSetColor(255, 255, 255);
            if (drawGuide) map3Guide.draw(0, 0, ofGetWidth(), ofGetHeight());
            
            ofDisableAlphaBlending();
            

            
            break;
            
    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void map3Scene::touchDown(ofTouchEventArgs &touch){

    
    touched = true; 
}


//--------------------------------------------------------------
void map3Scene::touchMoved(ofTouchEventArgs &touch){

}


//--------------------------------------------------------------
void map3Scene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == MAP3_SCENE_TOTAL-1) {
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

    if (buttHome.isPressed()) essSM->setCurScene(SCENE_HOME);
    
    buttHome.touchUp(touch);
    cout << "x:" << touch.x << " y: " << touch.y << endl; 
}