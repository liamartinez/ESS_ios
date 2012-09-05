//
//  baseButton.cpp
//  collectionsZone
//
//  Created by Vtron on 6/6/11.
//  Copyright 2011 Vargatron. All rights reserved.
//

#include "baseButton.h"

//------------------------------------------------------------------
baseButton::baseButton() {
    rect.set(0,0, 50, 50);
    
    offColor.r = 200;
    offColor.g = 200;
    offColor.b = 200;
  
    
    onColor.r = 200;
    onColor.g = 200;
    onColor.b = 200;
    onColor.a = 150;

//    onColor.r = 0;
//    onColor.g = 0;
//    onColor.b = 0;
//    onColor.a = 150;
    
    bDrawBG = true;
    
    label = "";
    
    offImage = NULL;
    onImage = NULL;
    
    bImageSet = false;
    bLabelSet = false;
    bPressed = false;
    
    bTouchStartedInside     = false;
    bAllowTouchFromOutside  = false;
}

//------------------------------------------------------------------
baseButton::~baseButton() {
}

//------------------------------------------------------------------
void baseButton::setup() {
}

//------------------------------------------------------------------
void baseButton::update() {
}


//------------------------------------------------------------------
void baseButton::draw() {
    glPushMatrix();
    glTranslatef(rect.x, rect.y, 0);
    if(bDrawBG) {
        ofEnableAlphaBlending();
        
        //Draw BG
        if(bImageSet) {
            ofSetColor(255,255,255);
            offImage->draw(0, 0, rect.width, rect.height); 
        } else {
            ofSetColor(offColor.r, offColor.g, offColor.b, offColor.a);
            ofRect(0, 0, rect.width, rect.height);
        }
        
        
        if(bPressed) {
            if(onImage != NULL) {
                ofSetColor(255,255,255);
                onImage->draw(0, 0, rect.width, rect.height);
            } else {
                ofSetColor(onColor.r, onColor.g, onColor.b, onColor.a);
                ofRect(0, 0, rect.width, rect.height);
            }
        }
        ofDisableAlphaBlending();
    }
    
    //Draw Label if Necessary
    if(bLabelSet) {
        ofSetColor(0,0,0);
        int labelX = rect.width/2 - labelFont->getStringWidth(label)/2;
        int labelY = rect.height/2 - labelFont->getStringHeight(label)/2;
        labelFont->drawString(label, labelX, labelY);
    }
    glPopMatrix();
    //edit
 
    
}


//------------------------------------------------------------------
void baseButton::draw(int x, int y) {
    setPos(x,y);
    draw();
}


//------------------------------------------------------------------
void baseButton::enableBG() {
    bDrawBG = true;
}


//------------------------------------------------------------------
void baseButton::disableBG() {
    bDrawBG = false;
}

//------------------------------------------------------------------
void baseButton::setColor(ofColor offColor) {
    this->onColor.a = 255;
    this->setColor(offColor, this->onColor);
}

//------------------------------------------------------------------
void baseButton::setColor(ofColor offColor, ofColor onColor) {
    this->offColor = offColor;
    this->onColor = onColor;
}


//------------------------------------------------------------------
void baseButton::setLabel(string label, ofxFreeType2* font, int margin) {
    //Get the metrics of the text
    this->label     = label;
    labelFont       = font;
    labelMargin     = margin;
    
    //Set the size w/margins
    int totalW = labelFont->getStringWidth(label) + labelMargin * 2;
    int totalH = labelFont->getStringHeight(label) + labelMargin * 2;
    
    rect.set(rect.x, rect.y, totalW, totalH);
    
    bLabelSet = true;
}


//------------------------------------------------------------------
string baseButton::getLabel() {
    return label;
}

//------------------------------------------------------------------
void baseButton::setImage(ofImage* offImage, ofImage* onImage) {
    this->offImage = offImage;
    this->onImage = onImage;
    
    rect.set(rect.x, rect.y, offImage->getWidth(), offImage->getHeight());
    
    bImageSet = true;
}

             
//------------------------------------------------------------------
void baseButton::setPos(int x, int y) {
    rect.set(x,y, rect.width, rect.height);
}

//------------------------------------------------------------------
void baseButton::setGLPos(int x, int y) {
    GLrect.set(x,y, rect.width, rect.height);
}


//------------------------------------------------------------------
void baseButton::setSize(int w, int h) {
    rect.set(rect.x, rect.y, w, h);
}


//------------------------------------------------------------------
void baseButton::setRect(ofRectangle rect) {
    this->rect = rect;
    cout << this->rect.x << endl;
}

//------------------------------------------------------------------
void baseButton::setGLRect(ofRectangle GLrect) {
    this->GLrect = GLrect;
}

//------------------------------------------------------------------
bool baseButton::isPressed(bool bToggle) {
    if(bPressed) {
        if(bToggle) bPressed = false;
        return true;
    }
    
    return false;
}


//--------------------------------------------------------------
void baseButton::touchDown(ofTouchEventArgs &touch){
    bPressed = rect.inside(touch.x, touch.y);
    bTouchStartedInside = bPressed;
}

//--------------------------------------------------------------
void baseButton::GLtouchDown(ofTouchEventArgs &touch){
    bPressed = GLrect.inside(touch.x, touch.y);
    bTouchStartedInside = bPressed;
}

//--------------------------------------------------------------
void baseButton::touchMoved(ofTouchEventArgs &touch){
    //Only check if the user started within
    if(bTouchStartedInside || bAllowTouchFromOutside) {
        bPressed = rect.inside(touch.x, touch.y);
    }
}
//--------------------------------------------------------------
void baseButton::GLtouchMoved(ofTouchEventArgs &touch){
    //Only check if the user started within
    if(bTouchStartedInside || bAllowTouchFromOutside) {
        bPressed = GLrect.inside(touch.x, touch.y);
    }
}

//--------------------------------------------------------------
void baseButton::touchUp(ofTouchEventArgs &touch){
    bPressed = false;
    bTouchStartedInside = false;
}

//--------------------------------------------------------------
void baseButton::GLtouchUp(ofTouchEventArgs &touch){
    bPressed = false;
    bTouchStartedInside = false;
}

//----------------------------------------------------
void baseButton::touchReset(){
    bPressed = false;
  //  bTouchStartedInside = false;
}
