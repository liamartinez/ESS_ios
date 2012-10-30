
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#pragma once
#include "essSceneManager.h"
#include "essAssetManager.h"
#include "ofxSceneManagerScene.h"
#include "ofxiPhoneExtras.h"
#include "ofxXmlSettings.h"
#include "baseButton.h"
#include "ofxTweenzor.h"

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

    

    void resetPlayed(); 
    void setupHomeButton(); 
    void drawHomeButton(); 
        
    //so that when you touch inside the text box, it doesn't disappear. 
    void setupTextBoxHelper(); 
    
    void setupTitle(string title_); 
    void drawTitle();
    string title; 
    
    void drawLowerBar();
    
    void setupTweens(); 
    void onEnterComplete(float* arg);
    void onExitComplete(float* arg);
    
    //xml
    vector<oralHist> loadXML (string floor_);
    void updateXML(int trackNum); 
    ofxXmlSettings XML;    
    string xmlStructure;
    string message;
    void loadOHaudio();
    string floor;
    string sceneName;
    int loadXMLTime(int trackNum);
    
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
    int currentOH;
    int textTempOH; 
    bool firstEntry; 
	int touchTemp; 

    
    //textBoxHelper
    bool touched; 
    bool dragged; 
    bool touchedOutside; 
	int tempOverlayRectHeight; 
    
    //overlay

    int startTween, endTween;
    float tweenNum; 
    int overlayState, lastState; 
	void tweenEntryExit(int stateNum_) ;
	int heightMax;
	
	int timer, delay; 
	
	bool goingUp; 

    baseButton playPauseButn; 
	baseButton descriptionButn; 
	int dragNum;
	bool descDown; 
	bool reEnter;
	
	int countTemp; 
    
    
    //audio
    void audioPlay(int currentTrack);
    ofSoundPlayer audioTest;
    void audioDisplay();
    void checkAudioStatus();
    int microSec;
    int second;
    int minute;
    int tempT;
    
    
    
protected:
    void drawGrid();
    
};


