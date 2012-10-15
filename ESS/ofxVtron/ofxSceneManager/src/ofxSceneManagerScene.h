//
//  ofxSceneManagerScene.h
//  collectionsZone
//
//
//  Created by Vtron on 6/2/11.
//

#ifndef _ofxSceneManagerScene
#define _ofxSceneManagerScene

#include "ofMain.h"
#include "ofxSceneManager2.h"

class ofxSceneManager;

class ofxSceneManagerScene {
	public:
        ofxSceneManagerScene();
        virtual ~ofxSceneManagerScene(){};
    
        virtual void setup(){};
        virtual void update(){};
        virtual void draw(){};
    
        virtual void activate(){};
        virtual void deactivate(){};
    
        //edit by chien
        virtual bool notice(){};
        virtual bool getnotice(bool A){};
    
    
        virtual void touchDown(ofTouchEventArgs &touch){};
        virtual void touchMoved(ofTouchEventArgs &touch){};
        virtual void touchUp(ofTouchEventArgs &touch){};
        virtual void touchDoubleTap(ofTouchEventArgs &touch){};
        
        ofxSceneManager* ofxSM;
};
#endif