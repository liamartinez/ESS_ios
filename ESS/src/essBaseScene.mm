
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
vector<oralHist> essBaseScene::loadXML (string floor_) {
    
    string floor = floor_; 
    oralHist tempOH; 
    vector<oralHist> tempList; 
    
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
            tempList.push_back(tempOH);
        }
    }
    XML.popTag();
    return tempList;
}


//------------------------------------------------------------------
void essBaseScene::drawGrid() {  //dont need this, but keep for now just in case. 
    int gridWidth = ofGetWidth() + MNH_GRID_CELL_SIZE; // lia - where is it getting these values?
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



