//
//  ofTapGestureRecognizer.h
//  emptyExample
//
//  Created by Chien yu Lin on 8/13/12.
//  Copyright 2012 NYU. All rights reserved.
//
#import <Foundation/Foundation.h>  


@interface ofTapGestureRecognizer : NSObject {  
    UITapGestureRecognizer *tapGestureRecognizer;  
}  

-(id)initWithView:(UIView*)view;  
-(void)handleTap:(UITapGestureRecognizer *) gr;  

@end 