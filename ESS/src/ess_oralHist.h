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
    
    void play(); 
    void stop();
    void pause(); 
    
    void drawDot();
    void drawInfo(); 
    void dontDraw(); 
    
    
    ofSoundPlayer story; 
    string name; 
    string keyword; 
    string path; 
    
    ofVec2f loc; 
    ofVec2f locInfo; 
    bool isPlaying; 
    ofVec2f offset; 
    
};


#endif
