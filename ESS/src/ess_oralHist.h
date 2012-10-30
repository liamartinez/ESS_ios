//
//  ess_oralHist.h
//  ESS
//
//  Created by Lia Martinez on 8/13/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef ESS_ess_oralHist_h
#define ESS_ess_oralHist_h

#include "essAssetManager.h"
#include "baseButton.h"
#include "ofxTweenzor.h"

class oralHist {

    
public:
    
    essAssetManager* essAssets;
    oralHist(); 
    ~oralHist(); 
    
    void setup(); 
    
    void play(); 
    void pause(); 
    
    void setFloorToActive(bool setFloor); 
    bool getFloorIsActive(); 
    
    void drawDot();
    void drawInfo(); 
    void drawPlay(int playLocX, int playLocY); 
    bool centerPlayOnDot;
    ofRectangle touchBox; 


    void drawOverlay(int tweenedLoc); 
    void setupOverlay(); 
 
    ofSoundPlayer audio; 
    string name; 
    string keyword; 
    string path; 
    bool isActive; 
    string description; 
    
    //Audio parameters
    bool playing;
    int time;
    unsigned int Tlength;
    
    bool isPlayed; 
    string isPlayedString;
        
    ofPoint origin; 
    int dotRadius; 
    ofVec2f loc; 
    ofVec2f locInfo; 
    bool isPlaying; 
    ofVec2f offset; 
    bool justLoaded;
    int alpha;
    float theta;
    
    ofRectangle getBoxSize(); 
    ofRectangle getTouchBox(int shiftRotate_); 
    void drawTouchBoxSize(int shiftRotate_); 
    
    baseButton playButn;
    baseButton spotButn; 
    
    int textWidth, textHeight; 
    int boxWidth, boxHeight; 
    void roundedRect(float x, float y, float w, float h, float r); 
    void quadraticBezierVertex(float cpx, float cpy, float x, float y, float prevX, float prevY);
    
    //overLay
    ofRectangle overlayRect; 
    int overlayX, overlayY, overlayWidth, overlayHeight; 
    int marginHeight, marginWidth;
    int marginButton; 
    float tweenNum; 
	int totalHeight; 
    
    int descriptionHeight; 
	
	//overLayRot
	ofRectangle overlayRectRot; 
    int overlayXRot, overlayYRot, overlayWidthRot, overlayHeightRot; 
    int marginHeightRot, marginWidthRot;
    int marginButtonRot; 
	int totalHeightRot; 
    
    int descriptionHeightRot; 

    void setDrawRotated(bool drawRot_);
	bool getDrawRotated();
	bool drawRot; 
};


#endif
