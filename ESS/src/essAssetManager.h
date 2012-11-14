
//
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#ifndef ESS_swAssetManager_h
#define ESS_swAssetManager_h

#pragma once
#include "ofMain.h"

#include "ofxFreeType2.h"


#define MNH_GRID_CELL_SIZE 128 //lia - do we need this? 


class essAssetManager {
public:
    static essAssetManager* getInstance();
    
    bool loadData();
    void loadFonts();
    void loadImages();
        
    //Fonts
    ofxFreeType2 whitneySemiBold22;
    ofxFreeType2 ostrich19, ostrich23, ostrich24; 
    ofxFreeType2 ostrich30; 
    
    //Colors
    ofColor ess_yellow; 
    ofColor ess_grey;
    ofColor ess_white; 
    ofColor ess_blue;
    ofColor ess_brown;

    //buttons
    ofImage playButton, pauseButton; 
	ofImage handle; 
	ofImage arrows, arrowup, arrowdown; 
    
private:
    essAssetManager();
    ~essAssetManager();
    
    static essAssetManager* pswAssetManager;
};


#endif
