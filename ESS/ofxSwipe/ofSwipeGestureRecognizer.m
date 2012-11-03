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
    swipe = 0;
    if((self = [super init])){  
        swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(a:)];  
        //Set the swipe direction as RIGHT (Because we place the phone horizontally, the RIGHT is the down in our directions)
        [swipeUp setDirection:(UISwipeGestureRecognizerDirectionLeft) ];
        [view addGestureRecognizer:swipeUp];  
        
        swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(a:)];  
        //Set the swipe direction as LEFT (Because we place the phone horizontally, the RIGHT is the up in our directions)
        [swipeDown setDirection:(UISwipeGestureRecognizerDirectionRight) ];
        [view addGestureRecognizer:swipeDown];
 
    }  
    return self;  
}  

-(void)a:(UISwipeGestureRecognizer *) gr{ 
    direction = gr.direction;
    swipe = 1;
	
	
    if ((gr.state == UIGestureRecognizerStateChanged) ||(gr.state == UIGestureRecognizerStateEnded)) {
        
        //do something
        NSLog(@"PogrState%i",gr.state); 
        if(gr. direction == UISwipeGestureRecognizerDirectionLeft){
            NSLog(@"SWIPE UP!"); 
            NSLog(@"Direction is: %i", gr.direction);
            
            
        }else{
            NSLog(@"SWIPE DOWN!"); 
            NSLog(@"Direction is: %i", gr.direction);
            
        }
    }
	 
        
}  

-(void)dealloc{
    swipe = 0;
    [swipeUp release];  
    [swipeDown release];  
    [super dealloc];  
}  

@end

