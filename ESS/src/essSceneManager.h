
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#pragma once

#include "ofxSceneManager2.h"

enum scene {
    SCENE_HOME,
    SCENE_MAP1,
    SCENE_MAP2,
    SCENE_MAP3,
    SCENE_MAP4, 
    SCENE_ABOUT,
    SW_TOTAL_SCENES //Always keep this one in here and keep it last!
};

class essSceneManager : public ofxSceneManager2 {
public:
    static essSceneManager* getInstance();
	bool isDragging; 
	bool getIsDragging(); 
	void setIsDragging (bool drag_); 
	bool isRot; 
	bool getIsRot(); 
	void setIsRot(bool rot_, int tween_);
	int  tweenNum; 
	int getOverlayLoc();
	
private:
    essSceneManager();
    ~essSceneManager();
    
    static essSceneManager* pEssSceneManager;
};


