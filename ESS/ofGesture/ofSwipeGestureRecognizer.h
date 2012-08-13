//
//  ofSwipeGestureRecognizer.h
//  emptyExample
//
//  Created by Chien yu Lin on 8/13/12.
//  Copyright 2012 NYU. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ofSwipeGestureRecognizer : NSObject {
    UISwipeGestureRecognizer *swipeGestureRecognizer;
    
}

-(id)initWithView:(UIView*)view;  
-(void)a:(UISwipeGestureRecognizer *) gr;

@end
