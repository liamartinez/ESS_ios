//
//  ofSwipeGestureRecognizer.h
//  emptyExample
//
//  Created by Chien yu Lin on 8/13/12.
//  Copyright 2012 NYU. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>


@interface ofSwipeGestureRecognizer : NSObject {

   
@public
	
	UISwipeGestureRecognizer *swipeUp;
    UISwipeGestureRecognizer *swipeDown;
	
    bool swipe;
    int direction;
	CGPoint p;
	UIView *mView;
    bool inThresh; 
	bool swipeOn; 
	
	
}

-(id)initWithView:(UIView*)view;  
//a:method ,gr:parameter with type:UISwipeGestureRecognizer, pplSwipe: parameter with type bool
-(void)a:(UISwipeGestureRecognizer *) gr;



@end
