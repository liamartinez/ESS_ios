
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

#include "ess_oralHist.h"


class essSceneManager; //why is there a class declared here? 

class essBaseScene : public ofxSceneManagerScene {
public:
    essBaseScene();
    virtual void setup();
    virtual void update();
    virtual void draw();
    
    vector<oralHist> loadXML (string floor_);
    
    //xml
    ofxXmlSettings XML;    
    string xmlStructure;
    string message;
    
    string sceneName;
    
    essSceneManager* essSM;
    essAssetManager* essAssets;
    
    ofxSceneManager2 mgr;
protected:
    void drawGrid();
    
};

#endif
