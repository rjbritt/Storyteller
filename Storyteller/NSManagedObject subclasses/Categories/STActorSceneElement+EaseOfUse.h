//
//  STActorSceneElement+EaseOfUse.h
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STActorSceneElement.h"
@class STStory;
@class STInteractiveScene;

@interface STActorSceneElement (EaseOfUse)

+(STActorSceneElement *)initActorWithName: (NSString *) name withImage:(UIImage *)image withinContext:(NSManagedObjectContext *)context centeredAt:(CGPoint) center;
+(STActorSceneElement *)findActorSceneElementWithName:(NSString *)name
                                              inStory:(STStory *)story
                                              inScene:(STInteractiveScene *)scene
                                            inContext:(NSManagedObjectContext *)context;
@end
