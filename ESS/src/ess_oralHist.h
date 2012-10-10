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
    
    void drawDot();
    void drawInfo(); 
    void drawPlay(); 
    bool centerPlayOnDot; 

    void drawOverlay(); 
    void setupOverlay(); 
    
    ofSoundPlayer audio; 
    string name; 
    string keyword; 
    string path; 
    bool isDrawn; 
    string description; 
    
    bool isPlayed; 
    string isPlayedString;
    
    
    ofPoint origin; 
    int dotRadius; 
    ofVec2f loc; 
    ofVec2f locInfo; 
    bool isPlaying; 
    ofVec2f offset; 
    
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
    float tweenNum; 
    
};


#endif
