
//
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#include <iostream>

#include "swAssetManager.h"

//------------------------------------------------------------------
//Singleton Instance/Get Instance
swAssetManager* swAssetManager::pswAssetManager=NULL;

//------------------------------------------------------------------
swAssetManager* swAssetManager::getInstance() {
	if(pswAssetManager==NULL) {
		pswAssetManager=new swAssetManager();
	}
	
	return pswAssetManager;
}


//------------------------------------------------------------------
swAssetManager::swAssetManager() {
}


//------------------------------------------------------------------
void swAssetManager::loadFonts() {
	whitneySemiBold22.loadFont("fonts/Whitney-Semibold.otf",22);
}


//------------------------------------------------------------------
bool swAssetManager::loadData() {
    return true;
}


//------------------------------------------------------------------
void swAssetManager::loadXML (string floor_) {

    string floor = floor_; 

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
    
    cout << "number of OHs" + numOH << endl; 

	if(numOH > 0){
                for(int i = 0; i < numOH; i++){
                string name = XML.getValue("OH:NAME", "name",i);
                cout << name << endl; 
                string path = XML.getValue("OH:PATH", "default.caf",i);
                cout << path << endl; 
                string keyword = XML.getValue("OH:KEYWORD", "default",i);
                cout << keyword << endl; 
            }
        }
    XML.popTag();
		    
}
