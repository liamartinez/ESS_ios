
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#include <iostream>

#include "essSceneManager.h"


//------------------------------------------------------------------
//Singleton Instance/Get Instance
essSceneManager* essSceneManager::pEssSceneManager=NULL;

//------------------------------------------------------------------
essSceneManager* essSceneManager::getInstance() {
	if(pEssSceneManager==NULL) {
		pEssSceneManager=new essSceneManager();
	}
	return pEssSceneManager;
}

essSceneManager::essSceneManager() {
}

bool essSceneManager::getIsDragging() {
	return isDragging; 
}

void essSceneManager::setIsDragging(bool drag_) {
	isDragging = drag_; 
}

bool essSceneManager::getIsRot() {
	return isRot; 
}

int essSceneManager::getOverlayLoc() {
	return tweenNum; 
}

void essSceneManager::setIsRot(bool rot_, int tween_) {
	isRot = rot_;
	tweenNum = tween_;
	
}