
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
    
    void populateMap(string floor_); 
    void drawMap(); 
    
    vector<oralHist> loadXML (string floor_);
    void setXMLtoPlayed(string floor_, int trackNum); 
    void resetPlayed(); 
    void setupHomeButton(); 
    void drawHomeButton(); 
    
    //xml
    ofxXmlSettings XML;    
    string xmlStructure;
    string message;
    void loadOHaudio();

    string sceneName;
    
    int shiftRotate(); 
    
    essSceneManager* essSM;
    essAssetManager* essAssets;
    
    ofxSceneManager2 mgr;
        
    //home button
    baseButton buttHome; 
    ofRectangle rectHome; 
    
    //the map
    vector <oralHist> floorMap; 
    int buttonState; 
    int currentButton, lastButton; 
    
protected:
    void drawGrid();
    
};

#endif
