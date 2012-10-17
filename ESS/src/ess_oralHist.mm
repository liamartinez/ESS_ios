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
    
    dotRadius = 8; // radius of the dot to be drawn
    origin.set(-dotRadius- (dotRadius/2), -dotRadius - (dotRadius/2)); //where to draw info, where the location is relative to 0 
    
    textWidth = essAssets->ostrich23.getStringWidth(name);
    textHeight = essAssets->ostrich23.getStringHeight(name);
    
    boxWidth = textWidth + 50; 
    boxHeight = textHeight + 20; 
    
    offset.x = - (textWidth/3);  
    
    locInfo.set(offset + loc);

    audio.setVolume(0.75f);
    audio.setMultiPlay(true);
     
    spotButn.setSize(dotRadius*4, dotRadius*4); //the size of the button is bigger than the circle drawn, to make it easier to press. 
    spotButn.disableBG(); 
    

    
    isActive = false; 
    centerPlayOnDot = true; 
    justLoaded = true; 
    alpha = 0;
}

void oralHist::setFloorToActive(bool setFloor) {
    isActive = setFloor; 
}

bool oralHist::getFloorIsActive() {
    return isActive; 
}

void oralHist::drawDot() {

    //the dots don't need to draw at "origin" because they don't need to be transformed/ rotated.
    ofEnableAlphaBlending();

    //dissolve on entry
    if (justLoaded) {
        //dissolve in 
        if (alpha < 255) alpha+=10; 
        if (alpha == 255) justLoaded = false; 
    } 
    
    //pulse when active
    if (isActive) {
        alpha = 160 + sin(theta) * 100;
        theta += 0.06;
    } else {
        if (alpha < 255) alpha+=10; 
    }
    
    if (!isPlayed) {
        ofSetColor(essAssets->ess_yellow, alpha);
    } else {
        ofSetColor(essAssets->ess_grey, alpha);
    }
    
    //this draws the circle
    ofCircle(loc.x, loc.y, dotRadius);
    
    ofDisableAlphaBlending();
    
    //this draws the button
    spotButn.draw(loc.x - (dotRadius*2), loc.y - (dotRadius*2));  
    
    touchBox.set(loc.x - dotRadius*2, loc.y - dotRadius*2, dotRadius*4, dotRadius*4);
    //lia: set spotbutn to touchbox
    
    
}



void oralHist::drawPlay(int playLocX, int playLocY) {
    
    /*
    playButn.setSize(dotRadius*4, dotRadius*4);
    playButn.disableBG(); 
    
    playButn.draw(playLocX,playLocY);
     */
    
    ofEnableAlphaBlending();
    ofSetColor(255);
        
    if (audio.getIsPlaying()) {
        essAssets->pauseButton.draw(playLocX,playLocY , textHeight + 8, textHeight + 8);
    } else {
        essAssets->playButton.draw(playLocX,playLocY, textHeight + 8, textHeight + 8);
    }
     ofDisableAlphaBlending();
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
    
    ofSetColor(essAssets->ess_yellow);
    essAssets->ostrich23.drawString(name, origin.x + 40, origin.y + boxHeight/4);
    ofDisableAlphaBlending();
    
}

ofRectangle oralHist::getBoxSize() {
    ofRectangle tempBox; 
    tempBox.set(loc.x +origin.x,loc.y + origin.y, boxWidth, boxHeight);
    return tempBox; 
}

ofRectangle oralHist::getTouchBox(int shiftRotate_) {
    
    // a bigger box so its easier to press a small button
    
    int rotateVal = shiftRotate_;
    int widthAdd = 30; 
    int heightAdd = 30; 
    
    ofRectangle tempBox; 

    switch (rotateVal) {

    case 90: //portrait
        tempBox.set(getBoxSize().x  - heightAdd/2, getBoxSize().y - widthAdd/2, getBoxSize().height + heightAdd, getBoxSize().width + widthAdd);
        break; 

    case 270: //portrait upside down
        tempBox.set(getBoxSize().x - heightAdd/2, getBoxSize().y  - getBoxSize().width + widthAdd/2, getBoxSize().height + heightAdd, getBoxSize().width + widthAdd);
        break; 
            
    case 180: // landscape left
        tempBox.set(getBoxSize().x - getBoxSize().width + widthAdd/2, getBoxSize().y - heightAdd/2, getBoxSize().width + widthAdd, getBoxSize().height + heightAdd);
        break; 

    default: //landscape right 
        tempBox.set(getBoxSize().x - widthAdd/2, getBoxSize().y - heightAdd/2, getBoxSize().width + widthAdd, getBoxSize().height + heightAdd);
        break;     
            
    }
        
    return tempBox; 
}

void oralHist::drawTouchBoxSize(int shiftRotate_) {
    
    int rotateVal = shiftRotate_;
    
    ofRectangle tempBox;
    tempBox = getTouchBox(rotateVal);
    
    ofSetColor(100, 100);
    ofEnableAlphaBlending();
    
    ofRect(tempBox);
    
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

//------------------------------------------------------------------

void oralHist::setupOverlay() {
    
    marginHeight = 20; 
    marginWidth = 20; 
    
    marginButton = 40; 
    
    overlayWidth = ofGetWidth();
    overlayHeight = essAssets->ostrich24.getStringHeight(name, ofGetWidth()) + marginHeight;
    overlayX = 0;
    overlayY = 0;
    
    
    overlayRect.set(overlayX, overlayY , overlayWidth, overlayHeight);
    

     
}

void oralHist::drawOverlay(int tweenedLoc) {
    
    overlayRect.y = tweenedLoc;

    ofSetColor(0, 0, 0, 150);
    ofEnableAlphaBlending();
    
    ofRect(overlayRect.x, overlayRect.y, overlayWidth, overlayHeight);
    
    drawPlay(overlayRect.x + marginWidth/2, overlayRect.y + marginHeight/2);
    
    ofSetColor(200);
    essAssets->ostrich24.drawTextArea(name, overlayRect.x + marginWidth/2 + marginButton, overlayRect.y + marginHeight/2, overlayWidth, overlayHeight);
    
    ofDisableAlphaBlending();
     
    
}




