
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