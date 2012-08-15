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

}

oralHist::~oralHist() {
    //audio.unloadSound();
}

void oralHist::setup() {
    
    textWidth = essAssets->ostrich22.getStringWidth(name) + 50;
    textHeight = essAssets->ostrich22.getStringHeight(name) + 20;
    
    offset.x = - (textWidth/3);
    //offset.y = - (textHeight/2);     
    
    locInfo.set(offset + loc);

    audio.setVolume(0.75f);
    audio.setMultiPlay(true);
    
    playButn.setLabel("pl",&essAssets->ostrich22);
    spotButn.setLabel("x",&essAssets->ostrich22);
    
    isDrawn = false; 
}

void oralHist::drawDot() {
    ofSetColor(essAssets->ess_yellow);
    spotButn.draw(loc.x, loc.y); 
}

void oralHist::drawInfo() {
    
    //checks to make sure the info box is within bounds. will have to look at this again when we auto-rotate
    if (locInfo.y > (ofGetWidth() - (textWidth + textHeight))) locInfo.y = ofGetWidth()- (textWidth + textHeight/2);
    if (locInfo.x > (ofGetHeight() - textHeight*2)) locInfo.x = ofGetWidth() - textHeight*2;

    ofSetColor(essAssets->ess_grey);
    roundedRect(locInfo.x, locInfo.y, textWidth, textHeight, 10);
    
    playButn.draw(locInfo.x, locInfo.y);
    
    ofSetColor(essAssets->ess_yellow);
    essAssets->ostrich22.drawString(name, locInfo.x + 40, locInfo.y + textHeight/4);
}

void oralHist::play() {  
    audio.loadSound(path);
    if (audio.isLoaded()) cout << "loaded from " + path << endl; 
    audio.play(); 
    playButn.setLabel("ST",&essAssets->ostrich22);
}

void oralHist::pause() {
    audio.stop();
    audio.unloadSound();
    playButn.setLabel("pl",&essAssets->ostrich22);
}

void oralHist::roundedRect(float x, float y, float w, float h, float r) {  
    ofBeginShape();  
    ofVertex(x+r, y);  
    ofVertex(x+w-r, y);  
    quadraticBezierVertex(x+w, y, x+w, y+r, x+w-r, y);  
    ofVertex(x+w, y+h-r);  
    quadraticBezierVertex(x+w, y+h, x+w-r, y+h, x+w, y+h-r);  
    ofVertex(x+r, y+h);  
    quadraticBezierVertex(x, y+h, x, y+h-r, x+r, y+h);  
    ofVertex(x, y+r);  
    quadraticBezierVertex(x, y, x+r, y, x, y+r);  
    ofEndShape();  
}  

void oralHist::quadraticBezierVertex(float cpx, float cpy, float x, float y, float prevX, float prevY) {  
    float cp1x = prevX + 2.0/3.0*(cpx - prevX);  
    float cp1y = prevY + 2.0/3.0*(cpy - prevY);  
    float cp2x = cp1x + (x - prevX)/3.0;  
    float cp2y = cp1y + (y - prevY)/3.0;  
    
    // finally call cubic Bezier curve function  
    ofBezierVertex(cp1x, cp1y, cp2x, cp2y, x, y);  
};  