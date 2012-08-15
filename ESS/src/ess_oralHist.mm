//
//  ess_oralHist.cpp
//  ESS
//
//  Created by Lia Martinez on 8/15/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "ess_oralHist.h"

oralHist::oralHist() {
    this->essAssets = essAssetManager::getInstance();
    offset.x = 10;
    offset.y = 10;     
}

void oralHist::drawDot() {
    ofSetColor(essAssets->ess_yellow);
    ofCircle(loc.x, loc.y, 10);
}

void oralHist::drawInfo() {
    
    /*
     int width = essAssets->ostrich22.getStringWidth(name);
     int height = essAssets->ostrich22.getStringHeight(name);
     */
    ofSetColor(essAssets->ess_yellow);
    essAssets->ostrich22.drawString(name, loc.x, loc.y );
}