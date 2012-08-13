//
//  ofTapGestureRecognizer.m
//  emptyExample
//
//  Created by Chien yu Lin on 8/13/12.
//  Copyright 2012 NYU. All rights reserved.
//

#import "ofTapGestureRecognizer.h"


@implementation ofTapGestureRecognizer

-(id)initWithView:(UIView*)view{  
    if((self = [super init])){  
        tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];  
        [view addGestureRecognizer:tapGestureRecognizer];  
    }  
    return self;  
}  

-(void)handleTap:(UITapGestureRecognizer *) gr{  
    if([gr state] == UIGestureRecognizerStateRecognized){  
        NSLog(@"tap!");  
    }  
}  

-(void)dealloc{  
    [tapGestureRecognizer release];  
    [super dealloc];  
}  
@end
