//
//  ofSwipeGestureRecognizer.h
//  emptyExample
//
//  Created by Chien yu Lin on 8/13/12.
//  Copyright 2012 NYU. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ofSwipeGestureRecognizer : NSObject {
    UISwipeGestureRecognizer *swipeUp;
    UISwipeGestureRecognizer *swipeDown;
   
@public
    bool swipe;
    int direction;

    
}

-(id)initWithView:(UIView*)view;  
//a:method ,gr:parameter with type:UISwipeGestureRecognizer, pplSwipe: parameter with type bool
-(void)a:(UISwipeGestureRecognizer *) gr;


@end
