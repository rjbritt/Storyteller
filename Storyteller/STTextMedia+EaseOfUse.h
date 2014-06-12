//
//  STTextMedia+EaseOfUse.h
//  Storyteller
//
//  Created by Ryan Britt on 6/11/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STTextMedia.h"

@class STInteractiveScene;
@class STStory;

@interface STTextMedia (EaseOfUse)

+(CGRect) genericRectForTextFieldAtCenter:(CGPoint)center;
+(STTextMedia *)initWithText:(NSString *)text
                withFontSize:(int)fontSize
                   inContext:(NSManagedObjectContext *)context
                    atCenter:(CGPoint)center;
+(STTextMedia *)findTextMediaWithText:(NSString *)text
                              inScene:(STInteractiveScene *)scene
                             andStory:(STStory *)story
                            inContext:(NSManagedObjectContext *)context;

-(CGPoint)centerPointCGPoint;
-(void)setCenterPoint:(CGPoint)point;



@end
