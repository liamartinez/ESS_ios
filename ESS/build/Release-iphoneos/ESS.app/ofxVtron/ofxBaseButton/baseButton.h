//
//  baseButton.h
//  collectionsZone
//
//  Created by Vtron on 6/6/11.
//  Copyright 2011 Vargatron. All rights reserved.
//

#pragma once
#include "ofMain.h"
#include "ofxFreeType2.h"

class baseButton {
	public:
        baseButton();
        ~baseButton();
    
		void setup();
		void update();
		void draw();
        void draw(int x, int y);
    
        void setPos(int x, int y);
        void setSize(int w, int h);
        void setRect(ofRectangle rect);
    
        void setColor(ofColor offColor);
        void setColor(ofColor offColor, ofColor onColor);
    
        //lia
        void enableBG();
        void disableBG();
        void setGLPos(int x, int y);
        void setGLRect(ofRectangle rect);
        ofRectangle GLrect; 
        void GLtouchDown(ofTouchEventArgs &touch);
        void GLtouchMoved(ofTouchEventArgs &touch);
        void GLtouchUp(ofTouchEventArgs &touch);

        void setLabel(string label,ofxFreeType2* font, int margin = 10);
        string getLabel();
    //edit by chien
        void touchReset();
        void setImage(ofImage* offImage, ofImage* onImage);
    //        void setImage(ofImage* offImage, ofImage* onImage = NULL);
        
        bool isPressed(bool toggle=false);
    
        //Allow pressing when starting outside of button? (slide over to press)
        bool bAllowTouchFromOutside;
    
        ofRectangle rect;
    
        void touchDown(ofTouchEventArgs &touch);
        void touchMoved(ofTouchEventArgs &touch);
        void touchUp(ofTouchEventArgs &touch);
    
//    protected:
        bool bImageSet, bPressed;
    private: 
        bool bTouchStartedInside;
    
        //Draw BG?
        bool bDrawBG;
        
        //Label Mode
        bool bLabelSet;
        string label;
        int labelMargin, labelFontSize;
        ofxFreeType2* labelFont;
    
        //Colors
        ofColor offColor, onColor;
    
        //Image Mode
        ofImage* offImage;
        ofImage* onImage;
    
    
    
};