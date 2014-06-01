//
//  STInteractiveSceneElement+EaseOfUse.h
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveSceneElement.h"

@interface STInteractiveSceneElement (EaseOfUse)

-(CGPoint) centerPointCGPoint;
-(void) setCenterPoint:(CGPoint)point;
-(UIImage *) getUIImageFromData;
-(void) setImageDataFromUIImage: (UIImage *)image;

@end
