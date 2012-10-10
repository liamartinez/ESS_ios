
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

void essBaseScene::populateMap(string floor_){
     string floor = floor_; 
    
    floorMap = loadXML(floor);
    
    for (int i = 0; i < floorMap.size(); i++) {  
        floorMap[i].setup(); 
        //OHmap2[i].audio.loadSound(OHmap2[i].path);
        cout << "setting up " + floorMap[i].name << endl;
    }    
    
    buttonState = 0; 
    lastButton = -1;
    currentButton = 0; 
}

void essBaseScene::drawMapPoints() {
    for (int i = 0; i < floorMap.size(); i++) {            
        floorMap[i].drawDot(); 
    }
        
    //draw the points (OH)
    for (int i = 0; i < floorMap.size(); i++) { 
        
        bool drawTempBox; 
        
        glPushMatrix();
        
        glTranslatef(floorMap[i].loc.x, floorMap[i].loc.y, 0); 
        
        ofRotateZ(shiftRotate());
        
        if (floorMap[i].isDrawn) {
            floorMap[i].drawInfo();
            drawTempBox = false; // enable if you want to see the bounds of the button
        }
        
        glPopMatrix();
        
        if (floorMap[i].isDrawn) {
            if (drawTempBox) floorMap[i].drawTouchBoxSize(shiftRotate());
        }
    }
}

//------------------------------------------------------------------
vector<oralHist> essBaseScene::loadXML (string floor_) {
    
    string floor = floor_; 
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
        message = "unable to load" + floor + ".xml check data/ folder";
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
void essBaseScene::setXMLtoPlayed(string floor_, int trackNum) {
    
    string floor = floor_; 
    
    XML.pushTag("ESS");
    XML.pushTag("OH", trackNum);
    XML.setValue("ISPLAYED", "TRUE");
    XML.popTag();
    XML.popTag();
    
    
    XML.saveFile( ofxiPhoneGetDocumentsDirectory() + "xml/" + floor + ".xml" );
	message = floor + "mySettings.xml saved to app documents folder";
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
    buttScreen.setSize(ofGetWidth(), ofGetHeight());
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
    }
    
    //textBoxHelper
    buttScreen.touchDown(touch);
    touched = true; 
}

void essBaseScene::baseTouchMoved(ofTouchEventArgs &touch) {
    
    //map
    for (int i = 0; i < floorMap.size(); i++) {
        floorMap[i].spotButn.touchMoved(touch);
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
        
        if (floorMap[i].spotButn.isPressed()) {
            
            currentButton = i; 
            if (currentButton != lastButton) {
                buttonState = 0; 
                
            } else {
                buttonState = 1;
            }
            
            switch (buttonState) {
                case 0:
                    for (int j = 0; j < floorMap.size(); j++) {
                        floorMap[j].isDrawn = false; 
                    }
                    floorMap[i].isDrawn = true; 
                    tempRect = floorMap[i].getTouchBox(shiftRotate()); 
                    cout << "temprect declared "  << endl; 
                    break;
                    
                case 1:
                    floorMap[i].isDrawn = true; 
                    if (!floorMap[i].audio.getIsPlaying()){
                        floorMap[i].play(); 
                        setXMLtoPlayed("2",i); 
                        cout << floorMap[i].name + "is playing -- SAVED" << endl; 
                    } else {
                        floorMap[i].pause();
                        cout << floorMap[i].name + "is paused" << endl; 
                    }
                    break;
            }   
        }
        
        lastButton = currentButton;         
    }
    
    for (int i = 0; i < floorMap.size(); i++) {
        floorMap[i].spotButn.touchUp(touch);
    }
    
    //textBoxHelper
    if (buttScreen.isPressed() && !dragged) {
        for (int j = 0; j < floorMap.size(); j++) {
            if (tempRect.inside(touch.x, touch.y)) {
                
            } else {
                floorMap[j].isDrawn = false; 
                
            }    
        }
    }
    
    buttScreen.touchUp(touch);
    touched = false; 
    dragged = false; 
    
    
}

void essBaseScene::baseTouchDoubleTap(ofTouchEventArgs &touch) {

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



