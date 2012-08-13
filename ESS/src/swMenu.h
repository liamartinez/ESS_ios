
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#ifndef SingWhale01_swMenu_h
#define SingWhale01_swMenu_h

#pragma once
#include "ofMain.h"
#include "baseButton.h"
#include "swAssetManager.h"
#include "swSceneManager.h"
//#include "Tweenzor.h"

enum buttonTypes { //fill this with the different words he can say. 
    MENU_ONE,
    MENU_TWO,
    MENU_THREE,
    MENU_TOTAL
};


#define MENU_BTN_W 125                          // width of each button in BTM_MENU
#define MENU_BTN_H 60                           // height

class swMenu : public baseButton {
public:
    void setup();
    void update();
    void draw();
    
    int drawSeparatorLine(int x);                   
    
    void show();
    void hide();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    
    string labels[MENU_TOTAL];
    baseButton buttons[MENU_TOTAL];
    
    swAssetManager* swAssets;
    swSceneManager* swSM;
    
    bool touchMenuRes; 
    
    
private:
    bool bShowing;
    int showingY;
    
    ofImage bgImage;
};

#endif
