//
//  STInteractiveScene+EaseOfUse.h
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveScene.h"

@interface STInteractiveScene (EaseOfUse)

+(STInteractiveScene *)initWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;
+(STInteractiveScene *)findSceneWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;
-(NSString *)nextActorName;
-(NSString *)nextEnviroName;
-(NSString *)nextObjectName;

typedef NS_ENUM(NSInteger, STInteractiveSceneElementType)
{
    STInteractiveSceneElementTypeActor = 1000,
    STInteractiveSceneElementTypeEnvironment,
    STInteractiveSceneElementTypeObject
    
};


@end
