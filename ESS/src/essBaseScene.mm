
//  Created by Stephen Varga on 6/8/11.
//  modified by Lia Martinez on 2/26/12.
//

#include <iostream>

#include "essBaseScene.h"

//------------------------------------------------------------------
essBaseScene::essBaseScene() {
    this->essSM = essSceneManager::getInstance(); //lia - find out what this means
    this->essAssets = essAssetManager::getInstance();
    
    sceneName = "Scene Name not Set!";


}


//------------------------------------------------------------------
void essBaseScene::setup() {

}



//------------------------------------------------------------------
void essBaseScene::update() {
    
}



//------------------------------------------------------------------
void essBaseScene::draw() {
}


//------------------------------------------------------------------

void essBaseScene::setupMap(string floor_){
     string floor = floor_; 
    
    currentOH = 0; 
    firstEntry = true; 
    
    floorMap = loadXML(floor);
    
    for (int i = 0; i < floorMap.size(); i++) {  
        floorMap[i].setup(); 
        floorMap[i].setupOverlay();
        //OHmap2[i].audio.loadSound(OHmap2[i].path);
        cout << "setting up " + floorMap[i].name << endl;
    }    
    
    buttonState = 0; 
    lastButton = -1;
    currentButton = 0; 
    
    setInfoShowing(FALSE); //is the info tab beside the play button showing?
    
    activateOverlay = true; 
    deactivateOverlay = false; 
    setupTweens();
}

void essBaseScene::drawMapPoints() {
    for (int i = 0; i < floorMap.size(); i++) {            
        floorMap[i].drawDot(); 
    }
        
    //draw the points (OH)
    for (int i = 0; i < floorMap.size(); i++) { 
        
        //bool drawTempBox; 
        
        glPushMatrix();
        
        glTranslatef(floorMap[i].loc.x, floorMap[i].loc.y, 0); 
        
        glPopMatrix();
    }
    
    //this is always being drawn
    
    if (!firstEntry) drawLowerBar();

}

void essBaseScene::drawLowerBar() {
    
    Tweenzor::update( ofGetElapsedTimeMillis() );

    /*
    if (activateOverlay) {
        Tweenzor::add(&tweenNum, ofGetHeight(), floorMap[currentOH].overlayRect.y, 0.f, 1.f, EASE_IN_OUT_CUBIC);
        Tweenzor::getTween( &tweenNum )->setRepeat( 1, false );
        activateOverlay = false; 
    } 
    
    if (deactivateOverlay) {
        Tweenzor::add(&tweenNum, floorMap[currentOH].overlayRect.y, ofGetHeight(),  0.f, 1.f, EASE_IN_OUT_CUBIC);
        Tweenzor::getTween( &tweenNum )->setRepeat( 1, false );
        deactivateOverlay = false; 
    }
     */

    
    floorMap[currentOH].drawOverlay(tweenNum);
    

    
    
    
    /*
    for (int i = 0; i < floorMap.size(); i++) { 
        if (floorMap[i].getFloorIsActive()) {
            floorMap[i].drawOverlay();
            currentDot = i; 
        } 
        
        if (exitNow) {
            //floorMap[currentDot].exitOverlay();
            exitNow = false; 
            lastDot = currentDot; 
        }
    }
     */
}

void essBaseScene::setInfoShowing(bool infoShow_){
    isInfoShowing = infoShow_; 
}

//------------------------------------------------------------------
vector<oralHist> essBaseScene::loadXML (string floor_) {
    
    floor = floor_; 
    oralHist tempOH; 
    vector<oralHist> tempList; 
    
    printf("ofxiPhoneGetDocumentsDirectory is %s\n",  
           ofxiPhoneGetDocumentsDirectory().c_str());
    
    //load the XMLs
    if( XML.loadFile(ofxiPhoneGetDocumentsDirectory() + "xml/" + floor + ".xml") ){
        message = floor + ".xml loaded from documents folder!";
    }else if( XML.loadFile("xml/" + floor + ".xml") ){
        message = floor + ".xml loaded from data folder!";
    }else{
        message = "unable to load " + floor + ".xml check data/ folder";
    }

    cout << message << endl; 
    
    XML.pushTag("ESS");
	int numOH = XML.getNumTags("OH");

	if(numOH > 0){
        for(int i = 0; i < numOH; i++){
            tempOH.name = XML.getValue("OH:NAME", "name",i);
            tempOH.path = XML.getValue("OH:PATH", "default.caf",i);
            tempOH.keyword = XML.getValue("OH:KEYWORD", "default",i);  
            tempOH.loc.x = XML.getValue("OH:XPOS", 10,i);   
            tempOH.loc.y = XML.getValue("OH:YPOS", 10,i);   
            tempOH.isPlayedString = XML.getValue("OH:ISPLAYED", "FALSE" ,i);  
            tempOH.description = XML.getValue("OH:DESCRIPTION", "", i);
        
            if (tempOH.isPlayedString == "FALSE") {
                tempOH.isPlayed = false; 
            } else {
                tempOH.isPlayed = true; 
            }
            
            tempList.push_back(tempOH);
        }
    }
    XML.popTag();
    return tempList;
}


//------------------------------------------------------------------
void essBaseScene::setXMLtoPlayed( int trackNum) {
    
    XML.pushTag("ESS");
    XML.pushTag("OH", trackNum);
    XML.setValue("ISPLAYED", "TRUE");
    XML.popTag();
    XML.popTag();
        
    if (XML.saveFile(ofxiPhoneGetDocumentsDirectory() + "xml/" + floor + ".xml" )) {
        message = floor + ".xml saved to app documents folder";
    } else {
        message = "XML not saved.";
    }
	
    cout << message << endl; 
}

//------------------------------------------------------------------
void essBaseScene::resetPlayed() {
    
    cout << "called reset" << endl; 
    
    ofxXmlSettings XMLTemp; 
    
    for (int floorNum = 1; floorNum <=4; floorNum++) {
        
        cout << "im in the loop" << floorNum << endl; 
        
        //load the XMLs
        if( XMLTemp.loadFile(ofxiPhoneGetDocumentsDirectory() + "xml/"  + ofToString(floorNum) + ".xml") ){
            message = ofToString(floorNum) + ".xml loaded from documents folder!";
        //}else if( XMLTemp.loadFile("xml/" + ofToString(floorNum) + ".xml") ){
        //    message = ofToString(floorNum) + ".xml loaded from data folder!";
        }else{
            message = "unable to load" + ofToString(floorNum) + ".xml check data/ folder";
        }
        
        cout << message << endl; 
        
        XMLTemp.pushTag("ESS");
        int tempNumOH = XMLTemp.getNumTags("OH");
        
        for(int i = 0; i < tempNumOH; i++){
            cout << "im in a tag " << i << endl; 
            XMLTemp.pushTag("OH", i);
            XMLTemp.setValue("ISPLAYED", "FALSE");
            XMLTemp.popTag();
        }
        
        XML.popTag();
        
        XMLTemp.saveFile( ofxiPhoneGetDocumentsDirectory()+ "xml/"  + ofToString(floorNum) + ".xml" );
        message = floorNum + ".xml saved to app documents folder";
         cout << message << endl;     
        }
    
   
}


//------------------------------------------------------------------

int essBaseScene::shiftRotate() {
    float angle = 180 - RAD_TO_DEG * atan2( ofxAccelerometer.getForce().y, ofxAccelerometer.getForce().x );
    
    float returnAngle; 
    
    if (angle > 230 && angle < 330) {
        returnAngle = 90; 
    } else if (angle > 330 && angle < 360) {
        returnAngle = 180; 
    } else if (angle > 0 && angle < 30) {
        returnAngle = 180; 
    } else if (angle > 30 && angle < 130) {
        returnAngle = 270; 
    } else {
        returnAngle = 0; 
    }
    
    
    return returnAngle;
}

//------------------------------------------------------------------

void essBaseScene::setupHomeButton() {
    rectHome.set(427, 290, 45, 20);
    //buttHome.enableBG();
    buttHome.setColor(essAssets->ess_white, essAssets->ess_grey);
    buttHome.setLabel("HOME", &essAssets->ostrich24);
    buttHome.setRect(rectHome);
    buttHome.disableBG();
}

void essBaseScene::drawHomeButton() {
    ofSetColor(essAssets->ess_blue); 
    ofRect(rectHome.x - 8, rectHome.y - 4, rectHome.width, rectHome.height);
    
    buttHome.draw(); 
}

//------------------------------------------------------------------

void essBaseScene::setupTitle(string title_){
    title = title_;
    rectLoc.set(11, 13, essAssets->ostrich24.getStringWidth(title) + 10, essAssets->ostrich24.getStringHeight(title) + 10);
    
}

void essBaseScene::drawTitle(){
    ofSetColor(essAssets->ess_blue);
    ofRect(rectLoc.x-5, rectLoc.y-4, rectLoc.width, rectLoc.height); 
    ofSetColor(essAssets->ess_grey);
    essAssets->ostrich24.drawString(title, rectLoc.x, rectLoc.y);
    
}

//------------------------------------------------------------------

void essBaseScene::setupTextBoxHelper() {
    buttScreen.setSize(ofGetWidth(), ofGetHeight() - 50); //temporary number for size of overlay
    buttScreen.setPos(0, 0);
    buttScreen.disableBG();
}



//------------------------------------------------------------------

void essBaseScene::baseTouchDown(ofTouchEventArgs &touch) {
    
    //home
    buttHome.touchDown(touch);
    
    //map
    for (int i = 0; i < floorMap.size(); i++) {
        floorMap[i].spotButn.touchDown(touch);
        floorMap[i].playButn.touchDown(touch);
    }
    
    //textBoxHelper
    buttScreen.touchDown(touch);
    touched = true; 
}

void essBaseScene::baseTouchMoved(ofTouchEventArgs &touch) {
    
    //map
    for (int i = 0; i < floorMap.size(); i++) {
        floorMap[i].spotButn.touchMoved(touch);
        floorMap[i].playButn.touchMoved(touch);
    }
    
    //textBoxHelper
    buttScreen.touchMoved(touch);
    if (touched) dragged = true;  
}

void essBaseScene::baseTouchUp(ofTouchEventArgs &touch) {
    
    //home
    if (buttHome.isPressed()) essSM->setCurScene(SCENE_HOME);
    buttHome.touchUp(touch);
    
    //map
    for (int i = 0; i < floorMap.size(); i++) { 
        
        //spot button
        if (floorMap[i].spotButn.isPressed()) {
            //floorMap[i].resetOverlay(); 
            cout << "hi!!!" <<endl;
            activateOverlay = true; 
            deactivateOverlay = false; 
            firstEntry = false; 
            currentOH = i; 
        }
        
        //set everything else to inactive, except the current OH
        floorMap[i].setFloorToActive(false); 
        floorMap[currentOH].setFloorToActive(true); 
        
        //play button
        if (floorMap[i].playButn.isPressed()) {
            floorMap[i].setFloorToActive(true); 
            
            cout << "pressed play" << endl; 
            
            if (!floorMap[i].audio.getIsPlaying()){
                floorMap[i].play(); 
                setXMLtoPlayed(i); 
                cout << floorMap[i].name + "is playing" << endl; 
            } else {
                floorMap[i].pause();
                cout << floorMap[i].name + "is paused" << endl; 
            }
        }
    }


    for (int i = 0; i < floorMap.size(); i++) {
        floorMap[i].spotButn.touchUp(touch);
        floorMap[i].playButn.touchUp(touch);
    }
    
    //textBoxHelper
    if (buttScreen.isPressed() && !dragged) {
        for (int j = 0; j < floorMap.size(); j++) {
            if (!tempRect.inside(touch.x, touch.y)) {
                //floorMap[currentDot].exitOverlay(); //add: if this is finished, then draw everything false. 
                floorMap[j].setFloorToActive(false); 
            } 
        }
        activateOverlay = false;
        deactivateOverlay = true; 
    }
    
    buttScreen.touchUp(touch);
    touched = false; 
    dragged = false; 
    
    
}

void essBaseScene::baseTouchDoubleTap(ofTouchEventArgs &touch) {

}

void essBaseScene::setupTweens() {
    //initialize Tweenzor
    Tweenzor::init();

    tweenNum = ofGetHeight();
    
    Tweenzor::add(&tweenNum, ofGetHeight(), ofGetHeight() - floorMap[currentOH].overlayRect.height, 0.f, 1.f, EASE_IN_OUT_CUBIC);
    Tweenzor::getTween( &tweenNum )->setRepeat( 1, false );

}



//------------------------------------------------------------------
void essBaseScene::drawGrid() {  //dont need this, but keep for now just in case. 
    int gridWidth = ofGetWidth() + MNH_GRID_CELL_SIZE; // 
    int gridHeight = ofGetHeight() + MNH_GRID_CELL_SIZE;
    
    glPushMatrix();
    glTranslatef(-MNH_GRID_CELL_SIZE/2, -MNH_GRID_CELL_SIZE/2, 0);
    
    //Draw Vertical Lines
    for(int i=1; i<ceil(gridHeight/MNH_GRID_CELL_SIZE); i++) {
        ofSetColor(235, 235, 235);
        ofLine(0, MNH_GRID_CELL_SIZE * i, gridWidth, MNH_GRID_CELL_SIZE * i);
    }
    
    //Draw Horizontal Lines
    for(int i=1; i<ceil(gridWidth/MNH_GRID_CELL_SIZE); i++) {
        ofSetColor(235, 235, 235);
        ofLine(MNH_GRID_CELL_SIZE * i, 0, MNH_GRID_CELL_SIZE * i, gridHeight);
    }
    
    glPopMatrix();
}

