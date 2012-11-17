
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
    double loadXMLTime(int trackNum);
    
    //gets accelererometer data to determine rotation
    int shiftRotate();
	int shiftRotate2();
    int oldAngle, curAngle;
    
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
	int heightMax90, heightMax0; 
	bool drawIt; 
    
	int timer, delay; 
    
	bool goingUp; 
	bool dragging; 
    
	int dragOff; 
    baseButton playPauseButn; 
	baseButton descriptionButn; 
	int dragNum;
	int lastTweenNum; 
	bool descDown; 
	bool reEnter;
	bool goSnap; 
    
	int countTemp; 
    
	//rotation
	int oldRot; 
	bool doneTweening; 
    void setRotation();
    
    
    //audio
    void audioPlay(int currentTrack);
    void checkAudioStatus();
	void setupAudio(); 
    string checkPlayTime(int currentTrack);
    void audioDisplay();

    ofSoundPlayer audioTest;
    baseButton audioBar;
    int audioBarSize;
    int barPos;
  
    int microSec;
    int second;
    int sec1;
    int sec2;
    int minute;
    int min1;
    int min2;
    int tempT;
    
    int posY;
    int barY;
    bool audioDrag;
	
	bool audioGo; 
	
	int beginLineX, endLineX, lineY, lineLen;
    //
    bool spotTouch;
    
    double TempL;
    
	
	//IF THE OVERLAY IS DISPLAYED
	bool overlayShow;
	
	
protected:
    void drawGrid();
    
};


