
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

	
	essSM-> setIsDragging(false);
    
    currentOH = 0; 
    firstEntry = true; 
    
    floorMap = loadXML(floor);
    
    for (int i = 0; i < floorMap.size(); i++) {  
        floorMap[i].setup(); 
        floorMap[i].setupOverlay();
        //OHmap2[i].audio.loadSound(OHmap2[i].path);
//        floorMap[i].audio.loadSound(floorMap[i].path);
//        cout<<"load Sound"<<i<<floorMap[i].path <<":"<<floorMap[i].audio.getPositionMS()<<endl;
//        cout << "setting up " + floorMap[i].name << endl;
        
    }    
    
    buttonState = 0; 
    lastButton = -1;
    currentButton = 0; 
    
    playPauseButn.setSize(floorMap[currentOH].dotRadius*4, floorMap[currentOH].dotRadius*4);
    playPauseButn.disableBG(); 
	
	descriptionButn.setSize(300, 100);
	descriptionButn.disableBG(); 
    
    setInfoShowing(FALSE); //is the info tab beside the play button showing?

    setupTweens();
    
    touchedOutside = true; 

	tweenEntryExit(0);
	
	delay = 500; 
	
	lastState = -1; 
    
    //for audio display
    audioTest.setMultiPlay(true); 
    audioTest.setSpeed(1.0f);
    microSec= 0;
    second = 0;
    minute = 0;
    tempT = 0;

    
    
    
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
    ofSetColor(essAssets->ess_white);
    essAssets->ostrich24.drawString(title, rectLoc.x, rectLoc.y);
    
}

//------------------------------------------------------------------

void essBaseScene::setupTextBoxHelper() {
	tempOverlayRectHeight = 50; 
    buttScreen.setSize(ofGetWidth(), ofGetHeight() - tempOverlayRectHeight); //temporary number for size of overlay
    buttScreen.setPos(0, 0);
    buttScreen.disableBG();
}

void essBaseScene::drawMapPoints() {

    for (int i = 0; i < floorMap.size(); i++) {            
        floorMap[i].drawDot(); 
    }
    
	//this is required by Tweenzor
	Tweenzor::update( ofGetElapsedTimeMillis() );
	
    //this is always being drawn
    if (!firstEntry) drawLowerBar();
	
	
	
}

void essBaseScene::drawLowerBar() {
	
	if (shiftRotate() == 90) {
		floorMap[currentOH].setDrawRotated(true); 
		startTween = 0;
		endTween =  floorMap[currentOH].overlayRect.height;

		ofSetColor(0, 0, 255);
		ofCircle(tweenNum, 10, 10);
		
	} else {
		floorMap[currentOH].setDrawRotated(false); 
		startTween = ofGetHeight();
		endTween = ofGetHeight() - floorMap[currentOH].overlayRect.height;
		
		ofSetColor(0, 0, 255);
		ofCircle(10, tweenNum, 10);
	}
	
	if (overlayState == 2) {
		//set the size of the buttonScreen to tweenNum, so that when you touch buttonScreen (outside the overlay) the overlay will exit. 
		tempOverlayRectHeight = tweenNum;
		buttScreen.setSize(ofGetWidth(), tempOverlayRectHeight);
		
		essSM->setIsDragging(true); 
	}
	
    //use textTempOH instead of CurrentOH so that the change only happens after the tween. See onExitComplete
	if (overlayState == 3) {

		//enable dragging
		tweenNum = dragNum;
		
		//limit the amount of drag to the maximum height of the overlay, based on length of text
		if (dragNum < heightMax) {
			tweenNum = heightMax;
		} else {
			tweenNum = dragNum;
		}
		 		
		//set the size of the buttonScreen to tweenNum, so that when you touch buttonScreen (outside the overlay) the overlay will exit. 
		tempOverlayRectHeight = tweenNum;
		buttScreen.setSize(ofGetWidth(), tempOverlayRectHeight);
		
		essSM->setIsDragging(true); 
	}
	
	if (overlayState == 0) {
		//timer, in case someone's finger slips
		if ((ofGetElapsedTimeMillis() - timer) > delay) { 
			essSM->setIsDragging(false);
		} else {
			essSM->setIsDragging(true);
		}
	}
	

	//draw the overlay
    floorMap[textTempOH].drawOverlay(tweenNum);
	
	//draw the play button
	playPauseButn.enableBG();
    playPauseButn.draw(floorMap[currentOH].overlayRect.x + floorMap[currentOH].marginWidth/2, tweenNum);
	
	//draw the button to drag out the description
	descriptionButn.enableBG(); 
	descriptionButn.draw(); 
	if (!floorMap[currentOH].getDrawRotated()) {
		descriptionButn.setPos((floorMap[currentOH].overlayRect.x + floorMap[currentOH].overlayRect.width)/2 - 150, tweenNum - 40); 
	} else {
		descriptionButn.setPos( tweenNum - 40,(floorMap[currentOH].overlayRect.y + floorMap[currentOH].overlayRect.width)/2 - 150); 
	}
		
	//draw the handle graphic 
	ofEnableAlphaBlending();
	if (!floorMap[currentOH].getDrawRotated()) {
		essAssets->handle.draw((floorMap[currentOH].overlayRect.x + floorMap[currentOH].overlayRect.width)/2 - 20, tweenNum);
	} else {
		ofPushMatrix(); 
		ofTranslate(tweenNum, (floorMap[currentOH].overlayRect.y + floorMap[currentOH].overlayRect.width)/2 - 20); 
		ofRotateZ(90);
		essAssets->handle.draw(0,0);
		ofPopMatrix(); 
	}

	ofDisableAlphaBlending();
	
	/*
	 
	 variables that will be affected by rotate:
	 overlayRect
	 
	 */
	
	
}

//------------------------OVERLAY & TWEENING------------------------------------------


void essBaseScene::setupTweens() {
    
    //initialize Tweenzor the first time you use it
    Tweenzor::init();
    
    //set the values for start and end
	/*
    startTween = ofGetHeight();
    endTween = ofGetHeight() - floorMap[currentOH].overlayRect.height;
	 */
	
	if (shiftRotate() == 90) {
		//floorMap[currentOH].setDrawRotated(true); 
		startTween = 0;
		endTween =  floorMap[currentOH].overlayRect.height;
	} else {
		floorMap[currentOH].setDrawRotated(false); 
		startTween = ofGetHeight();
		endTween = ofGetHeight() - floorMap[currentOH].overlayRect.height;
	}
    
    tweenNum = startTween;
	goingUp = true; 
}



void essBaseScene::onExitComplete(float* arg) {
	
	textTempOH = currentOH;
	reEnter = false; 
	lastState = 0; 
	tweenEntryExit(1);

    //this is where we make the overlay display the actual currentOH, only when the exit of the previous OH is finished. 

}



void essBaseScene::tweenEntryExit(int stateNum_) {
	
	cout << "last state: " << lastState << endl; 
	overlayState = stateNum_; 
	
	switch (overlayState) {
        case 0:
			cout << "CASE 0: SHOW NOTHING" << endl; 
			
			timer = ofGetElapsedTimeMillis();
			
			if (!firstEntry) {
				Tweenzor::add(&tweenNum, tweenNum, startTween, 0.f, 1.f, EASE_IN_OUT_SINE);
				if (reEnter) Tweenzor::addCompleteListener( Tweenzor::getTween(&tweenNum), this, &essBaseScene::onExitComplete);
			}
			
			for (int i = 0; i < floorMap.size(); i++) {
				floorMap[i].setFloorToActive(false);
			}
			
			lastState = 0; 

            break;
			
        case 1:
			cout << "CASE 1: NAME AND PLAYBAR" << endl; 
			
			essSM->setIsDragging(true);

			Tweenzor::add(&tweenNum, tweenNum, endTween, 0.f, 1.f, EASE_IN_OUT_SINE);

			
			if (lastState == 1) {
				reEnter = true; 
				tweenEntryExit(0); //send the tween to exit and then come back here
			} 
			
			else if (lastState ==2 && (textTempOH != currentOH)) {
				reEnter = true; 
				tweenEntryExit(0); //send the tween to exit and then come back here
			}
			
			else  {
				textTempOH = currentOH; //if not just go up
			}
			 
			buttScreen.setSize(ofGetWidth(), ofGetHeight() - (floorMap[currentOH].overlayHeight + floorMap[currentOH].marginHeight));
			
			for (int i = 0; i < floorMap.size(); i++) {
				floorMap[i].setFloorToActive(false);
			}
			
			floorMap[currentOH].setFloorToActive(true);

			lastState = 1; 
            break; 
            
        case 2:
			//description showing has to be in a draw loop. see "drawLowerBar()"
//			cout << "CASE 2: DESCRIPTION" << endl; 
			
			if (!descDown) {
			heightMax = ofGetHeight() - (floorMap[textTempOH].descriptionHeight + floorMap[textTempOH].overlayHeight + (floorMap[textTempOH].marginHeight));
			
			if (goingUp) {
				Tweenzor::add(&tweenNum, tweenNum, heightMax, 0.f, 1.f, EASE_IN_OUT_SINE);
			} else {
				tweenEntryExit(1);
			}
			
			goingUp = !goingUp; 
//				cout << "going up is now " << goingUp; 
			}
			
			lastState = 2; 
			break;	
			
			
		case 3:
//			cout << "CASE 2: DESCRIPTION DRAG" << endl; 
			//description showing has to be in a draw loop because it involves dragging which needs to be looping. see "drawLowerBar()"
			
			lastState = 3; 
        default:
            break;
    }
	
}
//-------------------------AUDIO & ITS DISPLAY---------------------------------------------------//
void essBaseScene::audioPlay(int currentTrack){
    int tempTime = 0;
    //Stop all the audios
    audioTest.stop();
    //Check who is playing first. Save the time
    for (int i = 0; i< floorMap.size(); i++) {
        if (floorMap[i].playing) {
            //Save the time
            floorMap[i].time = audioTest.getPositionMS();
            //cout<<"Position grab is "<<audioTest.getPositionMS()<<endl;
            //cout<<"Was playing "<<i<<endl;
        }
        floorMap[i].playing = false;
        updateXML(i);
        //cout<<"Current Time of"<<i<<" is "<<floorMap[i].time<<endl;
    }
   
    for (int i = 0; i < floorMap.size(); i++) {
        if(i == currentTrack){
            cout<<" "<<i<< "  Spot Button be pressed"<<endl;//":"<<floorMap[i].path<<"tempTime"<<tempTime<<endl;
            floorMap[i].playing = true;
            floorMap[i].isPlayed = true;
            updateXML(i);
            audioTest.loadSound(floorMap[i].path);          
            tempTime = loadXMLTime(i);
            //cout<<"time of player is "<<tempTime<<endl;         
        }else{
            floorMap[i].playing = false;
            //cout<<i<< "Spot Button didn't be pressed"<<endl;
        }
    }
    audioTest.play();
    audioTest.setPositionMS(tempTime);
    //cout<<"---------------------------"<<endl;
    
}
void essBaseScene::audioDisplay(){

   
    if (audioTest.getIsPlaying()){
//        tempT = audioTest.Tlength;
        
    }
            
//            cout<< tempT;
    
            ofEnableAlphaBlending();
            ofSetColor(essAssets->ess_yellow);
            //the bar is 100 pixel long, marginHeight = 20, the tweenNum is the overlay height
            ofLine(308, tweenNum+ 10 , 408, tweenNum+ 10 ); 
            char tempString[255];
            sprintf(tempString,"%d",tempT);
            essAssets->ostrich19.drawTextArea(tempString, 308, tweenNum+ 10,100, 100);
            ofDisableAlphaBlending();

    
    //draw display time

}
//
//void essBaseScene::audioSave(){
//    for (int i = 0; i< floorMap.size(); i++) {
//        setXMLtoPlayed(i);
//    }
//}
//

//------------------------------------------------------------------
//------------------------  EVENTS     -----------------------------
//------------------------------------------------------------------

void essBaseScene::baseTouchDown(ofTouchEventArgs &touch) {
//    cout<< "touch press"<<endl;
    //home
	 if (touch.y < tweenNum) {
		buttHome.touchDown(touch);
    
	}
    //map
    for (int i = 0; i < floorMap.size(); i++) {
        floorMap[i].spotButn.touchDown(touch);
        floorMap[i].playButn.touchDown(touch);
    }
    
    //textBoxHelper
    buttScreen.touchDown(touch);
    playPauseButn.touchDown(touch);
	descriptionButn.touchDown(touch);
    touched = true; 
	
	if (descriptionButn.isPressed()) descDown = true;
	
}

void essBaseScene::baseTouchMoved(ofTouchEventArgs &touch) {
	if (descDown) {
		overlayState = 3; 
		dragNum = touch.y; 		
	}
    //map
    for (int i = 0; i < floorMap.size(); i++) {
        floorMap[i].spotButn.touchMoved(touch);
        floorMap[i].playButn.touchMoved(touch);
    }
    //textBoxHelper
    buttScreen.touchMoved(touch);
    playPauseButn.touchMoved(touch);
	descriptionButn.touchMoved(touch);
    if (touched) dragged = true;  
}

void essBaseScene::baseTouchUp(ofTouchEventArgs &touch) {
	
	descDown = false; 
	

    //Home Button
	if (touch.y < tweenNum) {
		if (buttHome.isPressed()) essSM->setCurScene(SCENE_HOME);
        buttHome.touchUp(touch);
	}
    
    //Audio Spot Buttons
    for (int i = 0; i < floorMap.size(); i++) {
        if(floorMap[i].spotButn.isPressed()&& touch.y < tweenNum){
             currentOH = i;
             //Stop the origin audio. Play the new one
             audioPlay(i);
             tweenEntryExit(1);
             firstEntry = false;            
        }        
    }
    for (int i = 0; i < floorMap.size(); i++) {
        floorMap[i].spotButn.touchUp(touch);

    }
	
	//textBoxHelper //use this for touching outside the overlay.
    if (buttScreen.isPressed() &&!firstEntry) {
		
        int count = 0; 
        for (int i = 0; i < floorMap.size(); i++) {
            if (floorMap[i].touchBox.inside(touch.x, touch.y)) {
                count ++; 
            }
            if (count > 0) {
                touchedOutside = false;
            } else {
                touchedOutside = true; 
            }
        }
        
        if (touchedOutside) {
			tweenEntryExit(0); 
        }		
    }
    buttScreen.touchUp(touch);
    
    //Play and Pause Button
    if (playPauseButn.isPressed()) {
        if(floorMap[currentOH].playing){
            audioTest.stop();
            floorMap[currentOH].playing= 0;
            floorMap[currentOH].time = audioTest.getPositionMS();
            updateXML(currentOH);
        }else{
            audioTest.loadSound(floorMap[currentOH].path);
            audioTest.play();
            audioTest.setPositionMS(loadXMLTime(currentOH));
            floorMap[currentOH].playing= 1;
            updateXML(currentOH);
        }
    
    }
    playPauseButn.touchUp(touch);
    





	if (overlayState != 3) {
		if (descriptionButn.isPressed()) {
			tweenEntryExit(2);
		}
	}
		 
	playPauseButn.touchUp(touch);
	descriptionButn.touchUp(touch);
    buttScreen.touchUp(touch);

    touched = false; 
    

}

void essBaseScene::baseTouchDoubleTap(ofTouchEventArgs &touch) {

}

//----------------------------  XML --------------------------------------


vector<oralHist> essBaseScene::loadXML (string floor_) {
    
    floor = floor_; 
    oralHist tempOH; 
    vector<oralHist> tempList; 
    
    printf("ofxiPhoneGetDocumentsDirectory is %s\n",  
           ofxiPhoneGetDocumentsDirectory().c_str());
    
    //load the XMLs
    if( XML.loadFile(ofxiPhoneGetDocumentsDirectory() + floor + ".xml") ){
        message = floor + ".xml loaded from documents folder!";
    }else if( XML.loadFile("xml/" + floor + ".xml") ){
	  message = floor + ".xml loaded from data folder!";
	   }
	else{
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
            tempOH.playing = XML.getValue("OH:PLAYING", 0 ,i);
            tempOH.time = XML.getValue("OH:TIME",1000000000,i);
//            tempOH.Tlength= XML.getValue("OH:LENGTH",100,i);
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
int essBaseScene::loadXMLTime( int trackNum) {
    int tempTime = 0;
    
    XML.pushTag("ESS");
    XML.pushTag("OH", trackNum);
    //get time
    tempTime = XML.getValue("TIME",0);
//    cout<<"Load the time from XML file"<<tempTime<<endl;
    
    XML.popTag();
    XML.popTag();
    return tempTime;
	

}



//------------------------------------------------------------------
void essBaseScene::updateXML( int trackNum) {
    
    XML.pushTag("ESS");
    XML.pushTag("OH", trackNum);
    //Save Isplayed, playing, time
    XML.setValue("ISPLAYED", floorMap[trackNum].isPlayed);
    
    XML.setValue("PLAYING", floorMap[trackNum].playing);
    
    if (floorMap[trackNum].time < 0) {
        XML.setValue("TIME",0);
    }else{
        XML.setValue("TIME",floorMap[trackNum].time);
    }
    
//    XML.setValue("LENGTH",int(floorMap[trackNum].Tlength));
    
    XML.popTag();
    XML.popTag();
	
    if (XML.saveFile(ofxiPhoneGetDocumentsDirectory() + floor + ".xml" )) {
        message = floor + ".xml saved to app documents folder";
    } else {
        message = "XML not saved.";
    }
	
//    cout << message << endl; 
}

//------------------------------------------------------------------
void essBaseScene::resetPlayed() {
    
    cout << "called reset" << endl; 
    
    ofxXmlSettings XMLTemp; 
    
    for (int floorNum = 1; floorNum <=4; floorNum++) {
        
        cout << "im in the loop" << floorNum << endl; 
        
        //load the XMLs
        if( XMLTemp.loadFile(ofxiPhoneGetDocumentsDirectory() + ofToString(floorNum) + ".xml") ){
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
            XMLTemp.setValue("PLAYING", 0);
            XMLTemp.setValue("TIME",0);
            XMLTemp.popTag();
        }
        
        XML.popTag();
        
        XMLTemp.saveFile( ofxiPhoneGetDocumentsDirectory()+ ofToString(floorNum) + ".xml" );
        message = floorNum + ".xml saved to app documents folder";
		cout << message << endl;     
	}
    
	
}


//-------------------------FROM OLD INTERFACE--------------------------------------

//------------------------------------------------------------------
void essBaseScene::setInfoShowing(bool infoShow_){
    isInfoShowing = infoShow_; 
}

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

