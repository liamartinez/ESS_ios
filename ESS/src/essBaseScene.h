
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_swBaseScene_h
#define SingWhale01_swBaseScene_h

#pragma once
#include "essSceneManager.h"
#include "essAssetManager.h"
#include "ofxSceneManagerScene.h"
#include "ofxiPhoneExtras.h"
#include "ofxXmlSettings.h"
#include "baseButton.h"

#include "ess_oralHist.h"


class essSceneManager; 

class essBaseScene : public ofxSceneManagerScene {
public:
    essBaseScene();
    virtual void setup();
    virtual void update();
    virtual void draw();
    
    void baseTouchDown(ofTouchEventArgs &touch);
    void baseTouchMoved(ofTouchEventArgs &touch);
    void baseTouchUp(ofTouchEventArgs &touch);
    void baseTouchDoubleTap(ofTouchEventArgs &touch);
    
    void setupMap(string floor_); 
    void drawMapPoints(); 
    void setInfoShowing (bool infoShow_); 

    
    vector<oralHist> loadXML (string floor_);
    void setXMLtoPlayed(int trackNum); 
    void resetPlayed(); 
    void setupHomeButton(); 
    void drawHomeButton(); 
        
    //so that when you touch inside the text box, it doesn't disappear. 
    void setupTextBoxHelper(); 
    
    void setupTitle(string title_); 
    void drawTitle();
    string title; 
    
    void drawLowerBar();
    
    //xml
    ofxXmlSettings XML;    
    string xmlStructure;
    string message;
    void loadOHaudio();
    string floor;

    string sceneName;
    
    //gets accelererometer data to determine rotation
    int shiftRotate(); 
    
    essSceneManager* essSM;
    essAssetManager* essAssets;
    
    ofxSceneManager2 mgr;
        
    //home button
    baseButton buttHome; 
    ofRectangle rectHome; 
    
    //screen button
    baseButton buttScreen;
    
    //title
    ofRectangle rectLoc; 
    
    //touch bounds for the buttons
    ofRectangle tempRect; 

    //the map
    vector <oralHist> floorMap; 
    int buttonState; 
    int currentButton, lastButton; 
    bool isInfoShowing; 
    int currentFloor, lastFloor; 
    
    //textBoxHelper
    bool touched; 
    bool dragged; 
    bool exitNow; 
    int currentDot, lastDot; 
    
    //overlay
    bool activateOverlay;
    bool deactivateOverlay; 
    
    
protected:
    void drawGrid();
    
};

#endif
