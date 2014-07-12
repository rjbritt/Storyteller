//
//  STInteractiveSceneElement+EaseOfUse.h
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveSceneElement.h"

@class STStory;
@class STInteractiveScene;

typedef NS_ENUM(NSInteger, STInteractiveSceneElementType)
{
    STInteractiveSceneElementTypeActor = 1000,
    STInteractiveSceneElementTypeEnvironment,
    STInteractiveSceneElementTypeObject,
};


@interface STInteractiveSceneElement (EaseOfUse)

-(CGPoint) centerPointCGPoint;
-(void) setCenterPoint:(CGPoint)point;
-(UIImage *) getUIImageFromData;
-(void) setImageDataFromUIImage: (UIImage *)image;

+(STInteractiveSceneElement *)initializeSceneElementType:(STInteractiveSceneElementType)elementType
                                                           withName:(NSString *)name
                                                          withImage:(UIImage *)image
                                                      withinContext:(NSManagedObjectContext *)context
                                                         centeredAt:(CGPoint)center;

+(STInteractiveSceneElement *)findSceneElementOfType:(STInteractiveSceneElementType)elementType
                                            withName:(NSString *)name
                                             inStory:(STStory *)story
                                             inScene:(STInteractiveScene *)scene
                                           inContext:(NSManagedObjectContext *)context;


@end
