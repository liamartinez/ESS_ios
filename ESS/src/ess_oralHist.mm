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
}

void oralHist::setup() {
    
    dotRadius = 10;
    origin.set(-dotRadius- (dotRadius/2), -dotRadius - (dotRadius/2));
    
    textWidth = essAssets->ostrich23.getStringWidth(name);
    textHeight = essAssets->ostrich23.getStringHeight(name);
    
    boxWidth = textWidth + 50; 
    boxHeight = textHeight + 20; 
    
    offset.x = - (textWidth/3);  
    
    locInfo.set(offset + loc);

    audio.setVolume(0.75f);
    audio.setMultiPlay(true);
    
    //playButn.setLabel("pl",&essAssets->ostrich23);
    playButn.setGLPos(loc.x, loc.y);
    //playButn.setImage(&essAssets->playButton, &essAssets->playButton);
    //spotButn.setLabel("x",&essAssets->ostrich23);
     
    spotButn.setSize(dotRadius*2, dotRadius*2);
    spotButn.disableBG(); 
    
    isDrawn = false; 
}

void oralHist::drawDot() {

    //these don't need to draw at "origin" because they don't need to be transformed/ rotated.
    if (!isPlayed) {
        ofSetColor(essAssets->ess_yellow);
    } else {
        ofSetColor(essAssets->ess_grey);
    }
    spotButn.draw(loc.x - (dotRadius), loc.y - (dotRadius));  
    ofCircle(loc.x, loc.y, dotRadius);

}

void oralHist::drawInfo() {
    
    //checks to make sure the info box is within bounds. will have to look at this again when we auto-rotate
    /*
    if (locInfo.y > (ofGetWidth() - (textWidth + textHeight))) locInfo.y = ofGetWidth()- (textWidth + textHeight/2);
    if (locInfo.x > (ofGetHeight() - textHeight*2)) locInfo.x = ofGetWidth() - textHeight*2;
     */

    //everything here will draw at "origin" because they will be transformed/rotated.

    ofSetColor(essAssets->ess_grey);

    roundedRect(origin.x, origin.y, boxWidth, boxHeight, 10);
    //playButn.draw(0,0);  
    ofEnableAlphaBlending();
    
    ofSetColor(255);
    if (audio.getIsPlaying()) {
        essAssets->pauseButton.draw(origin.x + 5,origin.y + 5, textHeight + 8, textHeight + 8);
    } else {
        essAssets->playButton.draw(origin.x + 5,origin.y + 5, textHeight + 8, textHeight + 8);
    }
    
    ofSetColor(essAssets->ess_yellow);
    essAssets->ostrich23.drawString(name, origin.x + 40, origin.y + boxHeight/4);
    ofDisableAlphaBlending();
    
}

void oralHist::play() {  

    audio.loadSound(path);
    audio.play(); 
    isPlayed = true; 

}

void oralHist::pause() {
    audio.stop();
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