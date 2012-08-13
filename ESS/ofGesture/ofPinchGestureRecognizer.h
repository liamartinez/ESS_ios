//
//  ofPinchGestureRecognizer.h
//  emptyExample
//
//  Created by Chien yu Lin on 8/13/12.
//  Copyright 2012 NYU. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ofPinchGestureRecognizer : NSObject {  
    UIPinchGestureRecognizer *pinchGestureRecognizer;  
}  

-(id)initWithView:(UIView*)view;  
-(void)p:(UIPinchGestureRecognizer *) pr;  

@end 
