//
//  ofSwipeGestureRecognizer.m
//  emptyExample
//
//  Created by Chien yu Lin on 8/13/12.
//  Copyright 2012 NYU. All rights reserved.
//

#import "ofSwipeGestureRecognizer.h"


@implementation ofSwipeGestureRecognizer

-(id)initWithView:(UIView*)view{  
    if((self = [super init])){  
        swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(a:)];  
        //Set the swipe direction as RIGHT(It is also could be left/Up/Down)
        [swipeGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [view addGestureRecognizer:swipeGestureRecognizer];  
    }  
    return self;  
}  

-(void)a:(UISwipeGestureRecognizer *) gr{  
    NSLog(@" let's Swipe");
     
      
}  

-(void)dealloc{  
    [swipeGestureRecognizer release];  
    [super dealloc];  
}  
@end

