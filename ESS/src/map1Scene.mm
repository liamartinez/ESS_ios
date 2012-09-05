
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
    
    map1Scene.loadImage("flattenFiles/Map1.jpg");

    
    button.setPos(0, 0);
    button.setSize(ofGetWidth(), ofGetHeight());
    button.disableBG();
    rectHome.set(ofGetWidth()-50, ofGetHeight()-30, 70, 30);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
    
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
                        
            ofSetColor(255, 255, 255); 
            map1Scene.draw(0,0, ofGetWidth(), ofGetHeight());
            button.draw(); //this is invisible and only for releasing the highlighted dot

            buttHome.draw(); 
            
                for (int i = 0; i < OHmap1.size(); i++) {            
                    OHmap1[i].drawDot(); 
    
                    glPushMatrix();

                        if (shiftRotate() == 90) {
                            glTranslatef(OHmap1[i].loc.x+OHmap1[i].playButn.rect.height, OHmap1[i].loc.y, 0);    
                        } else if (shiftRotate() == 270) {
                            glTranslatef(OHmap1[i].loc.x, OHmap1[i].loc.y+OHmap1[i].playButn.rect.width, 0);
                        } else if (shiftRotate() == 180) {
                            glTranslatef(OHmap1[i].loc.x+OHmap1[i].playButn.rect.height, OHmap1[i].loc.y+OHmap1[i].playButn.rect.width, 0);
                        } else {
                                glTranslatef(OHmap1[i].loc.x, OHmap1[i].loc.y, 0);                            
                        }
                   
                    ofRotateZ(shiftRotate());
                    
                    if (OHmap1[i].isDrawn) OHmap1[i].drawInfo();
                    
                    glPopMatrix();
                }

            
            ofDisableAlphaBlending();
            
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
            cout << ofToString(buttonState) + "isButtonState" << endl; 
            cout << "current button: " + ofToString(currentButton) << endl;             currentButton = i; 
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
    

    

    buttHome.touchUp(touch);
    button.touchUp(touch);
}