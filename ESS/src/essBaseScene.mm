
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
      
    }    
    
    buttonState = 0; 
    lastButton = -1;
    currentButton = 0; 
    
    playPauseButn.setSize(floorMap[currentOH].dotRadius*4, floorMap[currentOH].dotRadius*4);
    playPauseButn.disableBG(); 
	
	
	descriptionButn.disableBG(); 
    
    setInfoShowing(FALSE); //is the info tab beside the play button showing?

    setupTweens();

	touchedOutside = true; 
    
	tweenEntryExit(0);
	doneTweening = true;     
	delay = 500; 
	lastState = -1; 
	setRotation();
	tweenNum = startTween; 	
    
    //for audio display
    audioTest.setMultiPlay(true); 
    audioTest.setSpeed(1.0f);
    microSec= 0;
    second = 0;
    sec1 = 0;
    sec2 = 0;
    minute = 0;
    min1 = 0;
    min2 = 0;
    tempT = 0;
    posY = 0;
    barY = 0;
    //For the audio bar, to see if peope scrub it
    audioDrag = 0;
    audioBarLength = 0;
    barPos = 0;

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


void essBaseScene::drawMapPoints() {

    for (int i = 0; i < floorMap.size(); i++) {            
        floorMap[i].drawDot(); 
    }
    
	//this is required by Tweenzor
	Tweenzor::update( ofGetElapsedTimeMillis() );
	
    setRotation(); 
	
    //this is always being drawn, but only if its not the first time
    if (!firstEntry && drawIt) drawLowerBar();
	
	
	ofColor c (100, 100, 100, 100); 
	buttScreen.setColor(c);
	ofEnableAlphaBlending(); 
	//debug
	//buttScreen.draw(); 
	ofDisableAlphaBlending(); 
}

void essBaseScene::setRotation() {
	//set the start/ end tweens and heightMax of rotated and not rotated version
	if (shiftRotate() == 90) {
		floorMap[currentOH].setDrawRotated(true); 
		startTween = 0;
		endTween =  floorMap[currentOH].overlayRect.height;
		buttScreen.setPos(tweenNum, 0);
		buttScreen.setSize(ofGetWidth(), ofGetHeight());
		//debugging: draw the tween!
		//ofSetColor(255, 0, 0);
		//ofLine (tweenNum, 0, tweenNum, ofGetHeight()); 
	} else {
		floorMap[currentOH].setDrawRotated(false); 
		startTween = ofGetHeight();
		endTween = ofGetHeight() - floorMap[currentOH].overlayRect.height;
		buttScreen.setPos(0, 0);
		buttScreen.setSize(ofGetWidth(), ofGetHeight() - (floorMap[currentOH].overlayHeight + floorMap[currentOH].marginHeight));
		//debugging: draw the tween!
		//ofSetColor(255, 0, 0);
		//ofLine (0, tweenNum, ofGetWidth(), tweenNum); 
	}
    
	if (shiftRotate() != oldRot) {
		tweenNum = startTween;
		oldRot = shiftRotate(); 
	}
    
    
    
    
}

void essBaseScene::drawLowerBar() {
    
	switch (overlayState) {
            
		case 0:
			//timer, in case someone's finger slips
			if ((ofGetElapsedTimeMillis() - timer) > delay) { 
				essSM->setIsDragging(false);
			} else {
				essSM->setIsDragging(true);
			}
			break;
            
		case 1:
            
			if (!floorMap[currentOH].getDrawRotated()) { 
				buttScreen.setPos(0, 0);
				buttScreen.setSize(ofGetWidth(), ofGetHeight() - (floorMap[currentOH].overlayHeight + floorMap[currentOH].marginHeight));
			} else {
				buttScreen.setPos(tweenNum, 0);
				buttScreen.setSize(ofGetWidth(), ofGetHeight());
			}
            
			break;
            
		case 2:
            
			//this is for live rotating -> not necessary anymore since we don't live rotate. 
			if (shiftRotate() != oldRot) {
				if (shiftRotate()==0) {
					heightMax = heightMax0;
				} else if (shiftRotate() == 90){
					heightMax = heightMax90;
				}
				tweenNum = heightMax;
				oldRot = shiftRotate(); 
			}	
            
			//set the size of the buttonScreen to tweenNum, so that when you touch buttonScreen (outside the overlay) the overlay will exit. 
            
			tempOverlayRectHeight = tweenNum;
            
			if (!floorMap[currentOH].getDrawRotated()) { 
				buttScreen.setPos(0, 0);
				buttScreen.setSize(ofGetWidth(), tempOverlayRectHeight);
			} else {
				buttScreen.setPos(tweenNum, 0);
				buttScreen.setSize(ofGetWidth(),ofGetHeight());
			}
            
			essSM->setIsDragging(true); 
			break;
            
		case 3:
            
			essSM->setIsDragging(true); 
            
			//get the heightMaxes depending on rotation
			heightMax0 = floorMap[currentOH].maxHeight0;
			heightMax90 = floorMap[currentOH].maxHeight90;
            
            
			if (shiftRotate()==0) {
				heightMax = heightMax0;
			} else if (shiftRotate() == 90){
				heightMax = heightMax90;
			}
            
            
			if (!dragging) { //When dragging stops, snap to heightmax and endtween
				if (abs(heightMax - tweenNum) <  (heightMax/2))  {
//					cout << "go up" << endl;
                    
					float easing = 0.3;
                    
					float targetX = heightMax;
					float dx = targetX - tweenNum;
					if(abs(dx) > 1) {
						tweenNum += dx * easing;
					}
				} 
				if (abs(endTween - tweenNum) < (heightMax/2))  {
//					cout << "go down" << endl; 
                    
					float easing = 0.5;
                    
					float targetX = endTween;
					float dx = targetX - tweenNum;
					if(abs(dx) > 1) {
						tweenNum += dx * easing;
						tweenEntryExit(1);
					}
				} 
                
			} else { //While you are dragging, limit the dragging within heightMax and endtween
                
//				cout << "dragging" << endl; 
				if ((shiftRotate()==0 && dragNum < heightMax) || (shiftRotate()==90 && dragNum > heightMax)) {
					float easing = 0.2;
                    
					float targetX = heightMax;
					float dx = targetX - tweenNum;
					if(abs(dx) > 1) {
						tweenNum += dx * easing;
					}
                    
				} else if (( shiftRotate()==0 && dragNum > startTween) || ( shiftRotate()==90 && dragNum < startTween) ) {
                    
					float easing = 0.2;
                    
					float targetX = endTween;
					float dx = targetX - tweenNum;
					if(abs(dx) > 1) {
						tweenNum += dx * easing;
						tweenEntryExit(1);
					}
				} else {
					tweenNum = dragNum + dragOff;
				}
                
			}
            
            
            //set the size of the buttonScreen to tweenNum, so that when you touch buttonScreen (outside the overlay) the overlay will exit. 
            tempOverlayRectHeight = tweenNum;
            
            
            if (!floorMap[currentOH].getDrawRotated()) { 
                buttScreen.setPos(0, 0);
                buttScreen.setSize(ofGetWidth(), tempOverlayRectHeight);
            } else {
                buttScreen.setPos(tweenNum, 0);
                buttScreen.setSize(ofGetWidth(), ofGetHeight());
            }
			lastState = 3; 
			break;
            
	}
    
	//draw the overlay
    floorMap[textTempOH].drawOverlay(tweenNum);
    
	//draw the play button
	if (!floorMap[currentOH].getDrawRotated()) {
		playPauseButn.draw(floorMap[currentOH].overlayRect.x, tweenNum);
	} else {
		playPauseButn.draw(tweenNum - 40, floorMap[currentOH].overlayRect.y);
	}
    
	//draw the button to drag out the description
	descriptionButn.disableBG(); //enabling this will draw the button box area 
	descriptionButn.draw(); 
	if (!floorMap[currentOH].getDrawRotated()) {
		descriptionButn.setSize(200, 100);
		descriptionButn.setPos((floorMap[currentOH].overlayRect.x + floorMap[currentOH].overlayRect.width)/2 - 150, tweenNum - 40); 
	} else {

		descriptionButn.setSize(70, 85);
		descriptionButn.setPos( tweenNum - 40,(floorMap[currentOH].overlayRect.y + floorMap[currentOH].overlayRect.width)/2 - 50); 
	}
    
	//draw the handle graphic 
	ofEnableAlphaBlending();
	if (!floorMap[currentOH].getDrawRotated()) {
		essAssets->handle.draw((floorMap[currentOH].overlayRect.x + floorMap[currentOH].overlayRect.width)/2 - 20, tweenNum);
	} else {
		ofPushMatrix(); 
		ofTranslate(tweenNum, 140); 
		ofRotateZ(90);
		essAssets->handle.draw(0,0);
		ofPopMatrix(); 
	}
	ofDisableAlphaBlending();
    
    
    
}

//------------------------OVERLAY & TWEENING------------------------------------------

void essBaseScene::setupTweens() {
    
    //initialize Tweenzor the first time you use it
    Tweenzor::init();
    
	if (shiftRotate() == 90) {
		floorMap[currentOH].setDrawRotated(true); 
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
    
	//this is where we make the overlay display the actual currentOH, only when the exit of the previous OH is finished.
	textTempOH = currentOH;  		    
    
	drawIt = false; 
	doneTweening = true; //when doneTweening is set to true, new rotation are generated
	setRotation(); 
	tweenNum = startTween;
	lastState = 0; 
    
//	cout << "exit complete: rotation is now: "  << floorMap[currentOH].getDrawRotated() << endl; 
    
	if (reEnter) {
//		cout << "exit complete, reenter: " << endl; 
        
		reEnter = false; 
		tweenEntryExit(1);
	}
}

void essBaseScene::onEnterComplete(float* arg) {
	doneTweening = false; 
}

void essBaseScene::tweenEntryExit(int stateNum_) {
    
	overlayState = stateNum_; 
    
	switch (overlayState) {
        case 0:
            
//			cout << "CASE 0: SHOW NOTHING" << endl; 
			timer = ofGetElapsedTimeMillis();
            
			if (!firstEntry) {
				Tweenzor::add(&tweenNum, tweenNum, startTween, 0.f, 1.f, EASE_IN_OUT_SINE);
				Tweenzor::addCompleteListener( Tweenzor::getTween(&tweenNum), this, &essBaseScene::onExitComplete);
			}
            
			for (int i = 0; i < floorMap.size(); i++) {
				floorMap[i].setFloorToActive(false);
			}
            
			lastState = 0; 
            
            break;
            
        case 1:
            
//			cout << "CASE 1: NAME AND PLAYBAR" << endl; 
            
			essSM->setIsDragging(true);
			drawIt = true; 
            
			Tweenzor::add(&tweenNum, tweenNum, endTween, 0.f, 1.f, EASE_IN_OUT_SINE);
			Tweenzor::addCompleteListener( Tweenzor::getTween(&tweenNum), this, &essBaseScene::onEnterComplete);
            
			if (lastState == 1) {
				reEnter = true; 
				tweenEntryExit(0); //send the tween to exit and then come back here
			} 	else if (lastState ==3 && (textTempOH != currentOH)) {
				reEnter = true; 
				tweenEntryExit(0); //send the tween to exit and then come back here
			}
            
			else  {
				textTempOH = currentOH; //if not just go up
			}
            
			for (int i = 0; i < floorMap.size(); i++) {
				floorMap[i].setFloorToActive(false);
			}
            
			floorMap[currentOH].setFloorToActive(true);
            
			lastState = 1; 
            break; 
            
        case 2:
            
//			cout << "CASE 2: DESCRIPTION BUTTON. DISABLED." << endl; 
            
			//get the heightMaxes
			heightMax0 = floorMap[textTempOH].maxHeight0;
			heightMax90 = floorMap[textTempOH].maxHeight90;
            
			if (!descDown) {
				if (shiftRotate()==0) {
					heightMax = heightMax0;
				} else if (shiftRotate() == 90){
					heightMax = heightMax90;
				}
                
                if (goingUp) {
                    doneTweening = false; 
                    Tweenzor::add(&tweenNum, tweenNum, heightMax, 0.f, 1.f, EASE_IN_OUT_SINE);
                    Tweenzor::addCompleteListener( Tweenzor::getTween(&tweenNum), this, &essBaseScene::onEnterComplete);
                } else {
                    tweenEntryExit(1);
                }
                
                goingUp = !goingUp; 
                
			}
            
			lastState = 2; 
			break;	
            
            
		case 3:
//			cout << "CASE 3: DESCRIPTION DRAG" << endl; 			
			goingUp = true; 
			drawIt = true; 
			lastState = 3; 
            break;
    }
    
}
//-------------------------AUDIO & ITS DISPLAY---------------------------------------------------//
void essBaseScene::audioPlay(int currentTrack){
    double tempTime = 0;
    //Stop all the audios
    audioTest.stop();
    //Check who is playing first. Save the time
    for (int i = 0; i< floorMap.size(); i++) {
        if (floorMap[i].playing) {
            //Save the time
            floorMap[i].time = audioTest.getPosition();
//            cout<<"Position grab is "<<audioTest.getPosition()<<endl;
            //cout<<"Was playing "<<i<<endl;
        }
        floorMap[i].playing = false;
        updateXML(i);
//        cout<<"Current Time of"<<i<<" is "<<floorMap[i].time<<endl;
    }
   
    for (int i = 0; i < floorMap.size(); i++) {
        if(i == currentTrack){
            cout<<" "<<i<< "  Spot Button be pressed"<<endl;//":"<<floorMap[i].path<<"tempTime"<<tempTime<<endl;
            floorMap[i].playing = true;
            floorMap[i].isPlayed = true;
            audioTest.loadSound(floorMap[i].path);
            updateXML(i);
            tempTime = loadXMLTime(i);
//            cout<<"time of player is "<<loadXMLTime(i)<<endl;         
        }else{
            floorMap[i].playing = false;
            //cout<<i<< "Spot Button didn't be pressed"<<endl;
        }
    }
    audioTest.play();
    audioTest.setPosition(tempTime);
//    cout<<"---------------------------"<<endl;
}

string essBaseScene::checkPlayTime(int currentTrack){

    //For Time display
    tempT = audioTest.getPosition()* floorMap[currentTrack].Tlength;
    minute = tempT/60;
    min1 = minute/10;
    min2 = minute%10;
    second = tempT%60;
    sec1 = second/10;
    sec2 = second%10;
    //cout<<"Time is "<<tempT<<"minute:"<<min1<<min2<<":"<<second<<endl;
    char timeString[255];
    sprintf(timeString,"%d%d:%d%d",min1,min2,sec1,sec2);

    return timeString;

}

void essBaseScene::checkAudioStatus(){
    for (int i = 0; i< floorMap.size(); i++) {
        if (floorMap[i].playing) {
            
            //For Bar's Position
            if(shiftRotate() == 0){
                audioBarLength = 120;
            }else{
                audioBarLength = 90;
            }
            //barPos: The position of the small Rec, where it is playing now
            barPos = audioTest.getPosition()*audioBarLength;
            
            //Check if it plays to the end and reset
            if(audioTest.getPosition()==1.0){
                floorMap[i].playing = false;
                floorMap[i].time = 0.0;
                updateXML(i);
                cout<<"It's Done"<<endl;
            }
        }
        
    }
    
	ofEnableAlphaBlending();
	ofSetColor(essAssets->ess_yellow);
	
	if (drawIt) { //band-aid boolean to prevent drawings when in weird rotations
		//if we are in horizontal position
		if (shiftRotate() == 0) {
		//the bar is 120 pixel long, marginHeight = 20, the tweenNum is the overlay height
			ofLine(308, tweenNum+ 10 , 308+audioBarLength, tweenNum+ 10 ); 
			essAssets->ostrich19.drawTextArea(checkPlayTime(currentOH), 308+audioBarLength+10, tweenNum+10, 100, 100);
            
            //Dragable rect
            if(!audioDrag){
                ofRect(308+barPos, tweenNum+5, 2, 10);
                audioBar.setPos(308+barPos, tweenNum+5);
            }else{
                
                ofRect(barY, tweenNum+5, 2, 10);
                audioBar.setPos(barY, tweenNum+5);
                
            }
            
		} else  {
			//if we are in vertical
			ofPushMatrix(); 
				ofTranslate(tweenNum - 8, floorMap[currentOH].overlayRect.width - 140);
				ofRotateZ(90);
				ofLine(0 ,10, audioBarLength,10 );
                essAssets->ostrich19.drawTextArea(checkPlayTime(currentOH),100, 5,100, 100);
                ofPopMatrix();
            //Dragable rect
                if(!audioDrag){
                    //Does it needs tween in Y direction?
                    ofRect(tweenNum-22, 180+barPos, 10, 2);
                    audioBar.setPos(tweenNum-25, 180+barPos);
                }else{
                
                    ofRect(tweenNum-22, barY, 10,2);
                    audioBar.setPos(tweenNum-25,barY);
                }          
//			ofPopMatrix();
		}
	}
    ofDisableAlphaBlending();
}
//

//------------------------------------------------------------------
//------------------------  EVENTS     -----------------------------
//------------------------------------------------------------------

void essBaseScene::baseTouchDown(ofTouchEventArgs &touch) {
   
   
    //home
    if((shiftRotate() != 90 && touch.y < tweenNum) || (shiftRotate() == 90 && touch.x > tweenNum)){
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
    
	if (descriptionButn.isPressed()) {
		if (shiftRotate() == 0) {
			dragNum = touch.y; 	
		} else {
			dragNum = touch.x; 
		}
		dragOff = tweenNum - dragNum;  //offset for difference between dragnum and tweennum
		dragging = true; //this is for case 3, so that it snaps only when you're not dragging. 
		tweenEntryExit(3);
	}
	

    //audio
    if (audioBar.isPressed()) {
        audioTest.setPaused(1);
        audioTest.setPosition(0.0);
        audioDrag= 1;
        cout<<"start to drag"<<endl;
        if(shiftRotate() == 0){
            barY = touch.x;
        }else{
            barY =touch.y;        
        }    
    }
    audioBar.touchDown(touch);
    
	
}

void essBaseScene::baseTouchMoved(ofTouchEventArgs &touch) {

	
	dragging = true; //this is for case 3, so that it snaps only when you're not dragging. 

	//set the axis of dragnum depending on rotation
	if (shiftRotate() == 0) {
		dragNum = touch.y; 	
	} else {
		dragNum = touch.x; 
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
    
    //audio
    if (audioDrag ) {
        if (shiftRotate()==0&& touch.x >308 && touch.x <428) {
            barY = touch.x;

        }else if(shiftRotate()==90&& touch.y >180 &&touch.y <270){
            cout<<"touchY"<<touch.y<<endl;
            barY = touch.y;
        }
        
    }
    audioBar.touchMoved(touch);
    
    if (touched) dragged = true;  
}

void essBaseScene::baseTouchUp(ofTouchEventArgs &touch) {
	
	descDown = false; //this is for case 2, which is not used anymore.
	dragging = false; //this is for case 3, so that it snaps only when you're not dragging. 
    
    //Home Button
    if((shiftRotate() != 90 && touch.y < tweenNum) || (shiftRotate() == 90 && touch.x > tweenNum)){
		if (buttHome.isPressed()) essSM->setCurScene(SCENE_HOME);
        buttHome.touchUp(touch);
	}
    
//	cout << "shiftrotate when touched is: " << shiftRotate() << endl; 
    //Audio Spot Buttons
    for (int i = 0; i < floorMap.size(); i++) {
        if((shiftRotate() == 0 && floorMap[i].spotButn.isPressed() && touch.y < tweenNum) || (shiftRotate() == 90 && floorMap[i].spotButn.isPressed()&& touch.x > tweenNum)){
            
			cout << "pressed a button" << endl; 
            currentOH = i;
            //Stop the origin audio. Play the new one
            audioPlay(i);
            tweenEntryExit(1);
            
			firstEntry = false;     //functions that rely on currentOH not being empty can work now.       
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
            floorMap[currentOH].time = audioTest.getPosition();
            updateXML(currentOH);
        }else{
            audioTest.loadSound(floorMap[currentOH].path);
            audioTest.play();
            audioTest.setPosition(loadXMLTime(currentOH));
            floorMap[currentOH].playing= 1;
            updateXML(currentOH);
        }
        
    }
    playPauseButn.touchUp(touch);
    
	/* //for case 2
     if (overlayState != 3) {
     if (descriptionButn.isPressed()) {
     //tweenEntryExit(2);
     }
     } else {
     if (descriptionButn.isPressed()) {
     //tweenEntryExit(2);
     goingUp = true; 
     }
     }
	 */
    
	if (descriptionButn.isPressed()) tweenEntryExit(3); 
    
	descriptionButn.touchUp(touch);
    
    //Audio Bar

    if(audioDrag){
        
        double tempPos = 0.0;
        if (shiftRotate()==0 ) {
            tempPos = double(barY-308)/double(120);
        }else{
            tempPos = double(barY-180)/double(90);
        }
        audioTest.setPaused(0);
        audioTest.setPosition(tempPos);
        audioDrag = false;
        cout<<"Drag Done i"<<currentOH<<endl;
    }
    audioBar.touchUp(touch);
    
	
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
//            tempOH.isPlayedString = XML.getValue("OH:ISPLAYED", "FALSE" ,i);
            tempOH.isPlayed = XML.getValue("OH:ISPLAYED", 0 ,i);
//            cout<<"isPlayed is"<<tempOH.isPlayed <<endl;
            tempOH.playing = XML.getValue("OH:PLAYING", 0 ,i);
            tempOH.time = XML.getValue("OH:TIME",0.0,i);
            tempOH.Tlength= XML.getValue("OH:LENGTH",100,i);
//            cout<<"This is the length"<<tempOH.Tlength<<endl;
            tempOH.description = XML.getValue("OH:DESCRIPTION", "", i);
//			
//            if (tempOH.isPlayedString == "FALSE") {
//                tempOH.isPlayed = false; 
//            } else {
//                tempOH.isPlayed = true; 
//            }
            
            tempList.push_back(tempOH);
        }
    }
    XML.popTag();
    return tempList;
}
//------------------------------------------------------------------
double essBaseScene::loadXMLTime( int trackNum) {
    double tempTime1 = 0;
    
    XML.pushTag("ESS");
    XML.pushTag("OH", trackNum);
    //get time
    tempTime1 = XML.getValue("TIME",0.0);
//    cout<<"Load the time from XML file"<<tempTime1<<endl;
    
    XML.popTag();
    XML.popTag();
    return tempTime1;
	

}



//------------------------------------------------------------------
void essBaseScene::updateXML( int trackNum) {
    
    XML.pushTag("ESS");
    XML.pushTag("OH", trackNum);
    //Save Isplayed, playing, time
    XML.setValue("ISPLAYED", floorMap[trackNum].isPlayed);
    
    XML.setValue("PLAYING", floorMap[trackNum].playing);
    
    if (floorMap[trackNum].time < 0.0) {
        XML.setValue("TIME",0.0);
    }else{
        XML.setValue("TIME",floorMap[trackNum].time);
    }
    cout<<"Save the time to XML file"<<floorMap[trackNum].time<<endl;

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
            XMLTemp.setValue("ISPLAYED", 0);
            XMLTemp.setValue("PLAYING", 0);
            XMLTemp.setValue("TIME",0.0);
            XMLTemp.popTag();
        }
        
        XML.popTag();
        
        XMLTemp.saveFile( ofxiPhoneGetDocumentsDirectory()+ ofToString(floorNum) + ".xml" );
        message = floorNum + ".xml saved to app documents folder";
		cout << message << endl;     
	}
    
	
}
//-------------------------ROTATION--------------------------------------


int essBaseScene::shiftRotate() {
    float angle = 180 - RAD_TO_DEG * atan2( ofxAccelerometer.getForce().y, ofxAccelerometer.getForce().x );
    
    int returnAngle; 
    
    if (angle > 230 && angle < 330) {
        curAngle = 90; 
    } else if (angle > 330 && angle < 360) {
        //returnAngle = 180; 
		curAngle = 0; 
    } else if (angle > 0 && angle < 30) {
        //returnAngle = 180; 
		curAngle = 0; 
    } else if (angle > 30 && angle < 130) {
        //returnAngle = 270;
		curAngle = 0; 
    } else {
        curAngle = 0; 
    }
    
    
    
	//wait for a tween to finish before returning a new angle
    if (doneTweening) {
		returnAngle = curAngle;
		oldAngle = returnAngle; 
        
	} else {
		returnAngle = oldAngle; 
	}
    
	return returnAngle;
 
    
}

//-------------------------FROM OLD INTERFACE--------------------------------------

//------------------------------------------------------------------
void essBaseScene::setInfoShowing(bool infoShow_){
    isInfoShowing = infoShow_; 
}

//int essBaseScene::shiftRotate() {
//    float angle = 180 - RAD_TO_DEG * atan2( ofxAccelerometer.getForce().y, ofxAccelerometer.getForce().x );
//
//	
//    int returnAngle; 
//    
//    if (angle > 230 && angle < 330) {
//        returnAngle = 90; 
//    } else if (angle > 330 && angle < 360) {
//        returnAngle = 180; 
//    } else if (angle > 0 && angle < 30) {
//        returnAngle = 180; 
//    } else if (angle > 30 && angle < 130) {
//        returnAngle = 270; 
//    } else {
//        returnAngle = 0; 
//    }
//    
//    
//    return returnAngle;
//}


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

