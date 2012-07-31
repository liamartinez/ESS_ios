//
//  ofxSceneManager.cpp
//  collectionsZone
//
//
//  Created by Vtron on 6/2/11.
//

#include "ofxSceneManager.h"

//------------------------------------------------------------------
//Singleton Instance/Get Instance
ofxSceneManager* ofxSceneManager::pofxSceneManager=NULL;

//------------------------------------------------------------------
ofxSceneManager* ofxSceneManager::getInstance() {
	if(pofxSceneManager==NULL) {
		pofxSceneManager=new ofxSceneManager();
	}
	
	return pofxSceneManager;
}


//------------------------------------------------------------------
ofxSceneManager::ofxSceneManager() {
	curScene = 0;
    bCurSceneChanged = true;
}



//------------------------------------------------------------------
void ofxSceneManager::setCurScene(int s) {
	if(curScene != s) {
        previousScene = curScene;
        curScene = s;
        bCurSceneChanged = true;
    }
}

//------------------------------------------------------------------
int ofxSceneManager::getCurScene() {
	return (int)curScene;
}


//------------------------------------------------------------------
void ofxSceneManager::prevScene() {
    setCurScene(previousScene);
}

//------------------------------------------------------------------
int ofxSceneManager::getPrevScene() {
    return previousScene;
}

//------------------------------------------------------------------
bool ofxSceneManager::getCurSceneChanged(bool bToggle) {
	if(bCurSceneChanged) {
        if(bToggle) bCurSceneChanged = false;
        return true;
    }
    
    return false;
}
