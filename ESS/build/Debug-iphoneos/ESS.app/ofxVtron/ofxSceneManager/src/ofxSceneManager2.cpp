//
//  ofxSceneManager2.cpp
//  collectionsZone
//
//
//  Created by Vtron on 6/2/11.
//

#include "ofxSceneManager2.h"

//------------------------------------------------------------------
ofxSceneManager2::ofxSceneManager2() {
	curScene = 0;
    bCurSceneChanged = true;
}

//------------------------------------------------------------------
ofxSceneManager2::~ofxSceneManager2() {
}

//------------------------------------------------------------------
void ofxSceneManager2::setCurScene(int s) {
	if(curScene != s) {
        previousScene = curScene;
        curScene = s;
        bCurSceneChanged = true;
    }
}

//------------------------------------------------------------------
int ofxSceneManager2::getCurScene() {
	return (int)curScene;
}


//------------------------------------------------------------------
void ofxSceneManager2::prevScene() {
    setCurScene(previousScene);
}

//------------------------------------------------------------------
int ofxSceneManager2::getPrevScene() {
    return previousScene;
}

//------------------------------------------------------------------
bool ofxSceneManager2::getCurSceneChanged(bool bToggle) {
	if(bCurSceneChanged) {
        if(bToggle) bCurSceneChanged = false;
        return true;
    }
    
    return false;
}
