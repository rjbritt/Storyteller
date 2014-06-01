//
//  STInteractiveSceneElement+EaseOfUse.m
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveSceneElement+EaseOfUse.h"

@implementation STInteractiveSceneElement (EaseOfUse)

//Convienence Methods

-(CGPoint) centerPointCGPoint
{
    return CGPointFromString(self.center);
}

-(void) setCenterPoint:(CGPoint)point
{
    self.center = NSStringFromCGPoint(point);
}

-(UIImage *) getUIImageFromData
{
    return [UIImage imageWithData:self.image];
}

-(void) setImageDataFromUIImage: (UIImage *)image
{
    self.image = UIImagePNGRepresentation(image);
}




@end
