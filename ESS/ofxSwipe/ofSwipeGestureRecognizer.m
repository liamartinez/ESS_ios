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
		mView = view;
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

/*
-(void) setEnabled: (bool) on {
	swipeDown.enabled = on; 
	swipeUp.enabled = on; 
}
 */


-(void)a:(UISwipeGestureRecognizer *) gr{ 
	
	/*
	if (swipeOn) {
		swipeDown.enabled = YES; 
		swipeUp.enabled = YES; 
		NSLog(@"SWIPE ON");
	} else {
		swipeDown.enabled = NO; 
		swipeUp.enabled = NO; 
		NSLog(@"SWIPE OFF");
	}
	 */
	
    direction = gr.direction;
    swipe = 1;
	p = [gr locationInView: mView];
	

    if ((gr.state == UIGestureRecognizerStateChanged) ||(gr.state == UIGestureRecognizerStateEnded)) {
        
        //do something
        NSLog(@"PogrState%i",gr.state); 
        if(gr. direction == UISwipeGestureRecognizerDirectionLeft){
            NSLog(@"SWIPE UP!"); 
//            NSLog(@"Direction is: %i", gr.direction);
//			NSLog(@"point is: %d, %d", (int) p.x, (int) p.y);
            
            
        }else{
            NSLog(@"SWIPE DOWN!"); 
//            NSLog(@"Direction is: %i", gr.direction);
//            NSLog(@"point is: %d, %d", (int) p.x, (int) p.y);
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

