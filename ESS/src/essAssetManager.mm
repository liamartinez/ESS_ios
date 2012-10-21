
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
    
    ess_grey.r = 137; 
    ess_grey.g = 137; 
    ess_grey.b = 137; 
    
    ess_white.r = 255;
    ess_white.g = 255;
    ess_white.b = 255;
    
    ess_blue.r = 164; 
    ess_blue.g = 190; 
    ess_blue.b = 206; 
}


//------------------------------------------------------------------
void essAssetManager::loadFonts() {
	whitneySemiBold22.loadFont("fonts/Whitney-Semibold.otf",22);
	ostrich19.loadFont("fonts/ostrich-black.ttf", 19);
    ostrich24.loadFont("fonts/ostrich-black.ttf", 24);
    ostrich23.loadFont("fonts/ostrich-black.ttf", 23);
    ostrich30.loadFont("fonts/ostrich-black.ttf", 30);
}


//------------------------------------------------------------------
bool essAssetManager::loadData() {
    playButton.loadImage("flattenFiles/button_play.png");
    pauseButton.loadImage("flattenFiles/button_pause.png");
    return true;
}



