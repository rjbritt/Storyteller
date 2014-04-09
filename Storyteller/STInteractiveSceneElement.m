//
//  STInteractiveSceneElement.m
//  Storyteller
//
//  Created by Ryan Britt on 4/8/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveSceneElement.h"


@implementation STInteractiveSceneElement

@dynamic image;
@dynamic center;
@dynamic tag;
@dynamic name;

//Convienence Methods

-(CGPoint) getCenterPoint
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
