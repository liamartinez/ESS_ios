
//
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#include <iostream>

#include "essAssetManager.h"

//------------------------------------------------------------------
//Singleton Instance/Get Instance
essAssetManager* essAssetManager::pswAssetManager=NULL;

//------------------------------------------------------------------
essAssetManager* essAssetManager::getInstance() {
	if(pswAssetManager==NULL) {
		pswAssetManager=new essAssetManager();
	}
	
	return pswAssetManager;
}


//------------------------------------------------------------------
essAssetManager::essAssetManager() {

    ess_yellow.r = 254;
    ess_yellow.g = 251;
    ess_yellow.b = 223;
}


//------------------------------------------------------------------
void essAssetManager::loadFonts() {
	whitneySemiBold22.loadFont("fonts/Whitney-Semibold.otf",22);
    ostrich22.loadFont("fonts/ostrich-black.ttf", 25);
}


//------------------------------------------------------------------
bool essAssetManager::loadData() {
    return true;
}



