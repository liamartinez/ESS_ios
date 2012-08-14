
//
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#ifndef ESS_swAssetManager_h
#define ESS_swAssetManager_h

#pragma once
#include "ofMain.h"
#include "ofxiPhoneExtras.h"
#include "ofxFreeType2.h"

#include "ofxXmlSettings.h"

#define MNH_GRID_CELL_SIZE 128 //lia - do we need this? 


class swAssetManager {
public:
    static swAssetManager* getInstance();
    
    bool loadData();
    void loadFonts();
    void loadXML(string floor_); 
    void loadImages();
        
    //Fonts
    ofxFreeType2 whitneySemiBold22;
    
    //xml
    ofxXmlSettings XML;    
    string xmlStructure;
    string message;
    
    
    
    
private:
    swAssetManager();
    ~swAssetManager();
    
    static swAssetManager* pswAssetManager;
};


#endif
