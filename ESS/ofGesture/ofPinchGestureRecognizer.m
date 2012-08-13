//
//  ofPinchGestureRecognizer.m
//  emptyExample
//
//  Created by Chien yu Lin on 8/13/12.
//  Copyright 2012 NYU. All rights reserved.
//

#import "ofPinchGestureRecognizer.h"


@implementation ofPinchGestureRecognizer


-(id)initWithView:(UIView*)view{  
    if((self = [super init])){  
        pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(p:)];  
        [view addGestureRecognizer:pinchGestureRecognizer];  
    }  
    return self;  
    
}  

-(void)p:(UIPinchGestureRecognizer *) pr{  

    NSLog(@"Pinch scale: %f", pinchGestureRecognizer.scale);
    
}  

-(void)dealloc{  
    [pinchGestureRecognizer release];  
    [super dealloc];  
}  

@end
