
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
	
	ess_yellow.set(254, 251, 223); 
	ess_grey.set(137,137,137); 
	ess_white.set(255, 255, 255);
	ess_blue.set(164, 190, 206);
	ess_brown.set(115, 100, 88);

}


//------------------------------------------------------------------
void essAssetManager::loadFonts() {
	whitneySemiBold22.loadFont("fonts/Whitney-Semibold.otf",22);
	ostrich19.loadFont("fonts/ostrich-black.ttf", 19);
    ostrich20.loadFont("fonts/ostrich-black.ttf", 20);
    ostrich24.loadFont("fonts/ostrich-black.ttf", 24);
    ostrich23.loadFont("fonts/ostrich-black.ttf", 23);
    ostrich30.loadFont("fonts/ostrich-black.ttf", 30);
}


//------------------------------------------------------------------
bool essAssetManager::loadData() {
    playButton.loadImage("flattenFiles/button_play.png");
    pauseButton.loadImage("flattenFiles/button_pause.png");
	handle.loadImage("flattenFiles/handle.png");
	arrows.loadImage("flattenFiles/arrows.png");
	arrowup.loadImage("flattenFiles/arrowup.png");
	arrowdown.loadImage("flattenFiles/arrowdown.png");
	
	soundtrack.loadSound("audio/soundtrack.caf");
	
    return true;
}



