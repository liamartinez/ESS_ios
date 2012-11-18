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
    playing = false;
    time = 0.0;
    
    dotRadius = 10; // radius of the dot to be drawn
    origin.set(-dotRadius- (dotRadius/2), -dotRadius - (dotRadius/2)); //where to draw info, where the location is relative to 0 
    
    textWidth = essAssets->ostrich23.getStringWidth(name);
    textHeight = essAssets->ostrich23.getStringHeight(name);
    
    boxWidth = textWidth + 50; 
    boxHeight = textHeight + 20; 
    
    offset.x = - (textWidth/3);  
    
    locInfo.set(offset + loc);
	
    audio.setVolume(0.75f);
    audio.setMultiPlay(false);
	//    cout<<"in side of OH"<<path<<endl;
	//    audio.loadSound(path);
	
    spotButn.setSize(dotRadius*4, dotRadius*4); //the size of the button is bigger than the circle drawn, to make it easier to press. 
    spotButn.disableBG(); 
    yellowDot.loadImage("flattenFiles/yellowDot.png");
    yellowDot.setImageType(OF_IMAGE_COLOR_ALPHA);
    greyDot.loadImage("flattenFiles/greyDot.png");
    greyDot.setImageType(OF_IMAGE_COLOR_ALPHA);

    
	
    
    isActive = false; 
    centerPlayOnDot = true; 
    justLoaded = true; 
    alpha = 0;
    drawRot = false; 

	
}

void oralHist::setFloorToActive(bool setFloor) {
    isActive = setFloor; 
}

bool oralHist::getFloorIsActive() {
    return isActive; 
}


void oralHist::setDrawRotated(bool drawRot_) {
    drawRot = drawRot_; 
}

bool oralHist::getDrawRotated() {
	return drawRot; 
}
void oralHist::drawDot() {
	
    //the dots don't need to draw at "origin" because they don't need to be transformed/ rotated.
    ofEnableSmoothing();
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
        theta += 0.1;
    } else {
        if (alpha < 255) alpha+=10; 
    }
    ofSetColor(255,255,255,alpha);
    if (!isPlayed) {
        yellowDot.draw(loc.x-dotRadius/2, loc.y-dotRadius/2, dotRadius*2.2,dotRadius*2.2 );//The new image files has a blue outline, so the circle are smaller than dotRadius*2
    } else {
        greyDot.draw(loc.x-dotRadius/2, loc.y-dotRadius/2,dotRadius*2.2,dotRadius*2.2);
    }
    
    //this draws the circle
//    ofSetCircleResolution(100);
//    ofFill();
//    ofCircle(loc.x, loc.y, dotRadius);
//    ofNoFill();
//    ofSetColor(essAssets->ess_blue);
//    ofCircle(loc.x, loc.y, dotRadius);
//    ofFill();
    
    ofDisableAlphaBlending();
    ofDisableSmoothing();
    
    //this draws the button
    spotButn.draw(loc.x - (dotRadius*2), loc.y - (dotRadius*2));  
    
    touchBox.set(loc.x - dotRadius*2, loc.y - dotRadius*2, dotRadius*4, dotRadius*4);
    //lia: set spotbutn to touchbox
    
    
}


void oralHist::drawPlay(int playLocX, int playLocY) {
	
    ofEnableAlphaBlending();
    ofEnableSmoothing();
    ofSetColor(255);
	
    if (playing) {
        essAssets->pauseButton.draw(playLocX - 5,playLocY - 8 , textHeight + 18, textHeight + 20);
    } else {
        essAssets->playButton.draw(playLocX - 5,playLocY - 8, textHeight + 18, textHeight + 20);
    }
    //    if (audio.getIsPlaying()) {
    //        essAssets->pauseButton.draw(playLocX - 5,playLocY - 8 , textHeight + 18, textHeight + 20);
    //    } else {
    //        essAssets->playButton.draw(playLocX - 5,playLocY - 8, textHeight + 18, textHeight + 20);
    //    }
    
	ofDisableAlphaBlending();
    ofDisableSmoothing();
}







//--------------------------FOR THE OVERLAY ----------------------------------------

void oralHist::setupOverlay() {
    
    marginHeight = 20; 
    marginWidth = 20; 
    
    marginButton = 40; 
	
	playbarHeight = 40; 
    
    overlayWidth = ofGetWidth();
    overlayHeight = essAssets->ostrich19.getStringHeight(name, ofGetWidth()) + marginHeight + playbarHeight;
    overlayX = 0;
    overlayY = 0;
    
    descriptionHeight = essAssets->ostrich19.getStringHeight(description, ofGetWidth()) + marginHeight; 

    overlayRect.set(overlayX, overlayY , overlayWidth, overlayHeight);
    //rotated values (can't translate otherwise we will lose the button functionality).
}

void oralHist::drawOverlay(int tweenedLoc) {
    
	int rotVal; 
	
	//setup for vertical drawing
	if (!drawRot) {
		overlayWidth = ofGetWidth();
		overlayRect.set(overlayX, tweenedLoc , overlayWidth, overlayHeight); //assign tweenedLoc to Y value
		overlayHeight = essAssets->ostrich19.getStringHeight(name, overlayWidth) + marginHeight + playbarHeight;	
		rotVal = 0; 	
		
		//setup for horizontal drawing	
	} else {
		overlayWidth = ofGetHeight(); //reversed width for height	 
		overlayRect.set(tweenedLoc, overlayY, overlayWidth, overlayHeight); //assign tweenedLoc to X value		
		overlayHeight = essAssets->ostrich19.getStringHeight(name, overlayWidth) + marginHeight + playbarHeight;	
		rotVal = 90; 
	}

	
	totalHeight = overlayHeight + descriptionHeight + (marginHeight*2);
	maxHeight0 = ofGetHeight() - totalHeight; 
	maxHeight90 = totalHeight; 

    ofEnableAlphaBlending();
    
	//draw overlay Rectangle
    ofSetColor(100, 150);
    if (!drawRot) {
		ofRect(overlayRect.x, overlayRect.y, overlayWidth, totalHeight);
	} else {
		ofRect(overlayRect.x, overlayRect.y, -totalHeight, overlayWidth);
	}
    
	ofPushMatrix();
    if (!drawRot) {
        ofTranslate(0, overlayRect.y);
    } else {
        ofTranslate(overlayRect.x, 0);
    }
    ofRotateZ(rotVal);
    //draw pause/ play button
    drawPlay(0 + marginWidth/2, 0 + marginHeight/2);
    
    //draw title
    ofSetColor(essAssets->ess_yellow);
    essAssets->ostrich19.drawTextArea(name, 0 + marginWidth/2 + marginButton, 0 + marginHeight/2, overlayWidth, overlayHeight);
    
    //draw description
    ofSetColor(essAssets->ess_white);
    essAssets->ostrich19.drawTextArea(description, 0 + marginWidth/2 + marginButton, 0 + marginHeight/2 + overlayRect.height, overlayWidth - marginWidth - marginButton, descriptionHeight);
    
	ofPopMatrix();	
	ofDisableAlphaBlending();
    
}


//-----------------------FOR THE OLD INTERFACE ---------------------------------------


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

void oralHist::drawTouchBoxSize(int shiftRotate_) {
    
    int rotateVal = shiftRotate_;
    
    ofRectangle tempBox;
    tempBox = getTouchBox(rotateVal);
    
    ofSetColor(100, 100);
    ofEnableAlphaBlending();
    
    ofRect(tempBox);
    
    ofDisableAlphaBlending();
	
}

void oralHist::drawInfo() {
	
    ofSetColor(essAssets->ess_grey);
	
    roundedRect(origin.x, origin.y, boxWidth, boxHeight, 10); 
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
