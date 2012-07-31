//
//  mnhController.h
//  collectionsZone
//
//  Created by Vtron on 6/2/11.
//

#ifndef _ofxSceneManager
#define _ofxSceneManager

#include "ofMain.h"
#include "ofxSceneManagerScene.h"

class ofxSceneManager {
	public:
		static ofxSceneManager* getInstance();
    
        virtual void setCurScene(int scene);
        virtual int getCurScene();
    
        virtual void prevScene();
        virtual int getPrevScene();
    
        virtual bool getCurSceneChanged(bool bToggle=true);
	private:
        int curScene, previousScene;
        
		ofxSceneManager();
		//~ofxSceneManager();
         
        bool bCurSceneChanged;
    
		static ofxSceneManager* pofxSceneManager;
};

#endif
