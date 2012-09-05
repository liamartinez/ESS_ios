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
    void dontDraw(); 
    
    ofSoundPlayer audio; 
    string name; 
    string keyword; 
    string path; 
    bool isDrawn; 
    
    bool isPlayed; 
    string isPlayedString;
    
    ofPoint origin; 
    int dotRadius; 
    ofVec2f loc; 
    ofVec2f locInfo; 
    bool isPlaying; 
    ofVec2f offset; 
    
    baseButton playButn;
    baseButton spotButn; 
    
    int textWidth, textHeight; 
    int boxWidth, boxHeight; 
    void roundedRect(float x, float y, float w, float h, float r); 
    void quadraticBezierVertex(float cpx, float cpy, float x, float y, float prevX, float prevY);
};


#endif
