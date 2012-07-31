//
//  mnhController.h
//  collectionsZone
//
//  Created by Vtron on 6/2/11.
//

#ifndef _ofxSceneManager2
#define _ofxSceneManager2

#include "ofMain.h"
#include "ofxSceneManagerScene.h"

class ofxSceneManager2 {
	public:
        ofxSceneManager2();
        ~ofxSceneManager2();
    
        virtual void setCurScene(int scene);
        virtual int getCurScene();
    
        virtual void prevScene();
        virtual int getPrevScene();
    
        virtual bool getCurSceneChanged(bool bToggle=true);
	private:
        int curScene, previousScene;
        
        bool bCurSceneChanged;
    
		
};

#endif
