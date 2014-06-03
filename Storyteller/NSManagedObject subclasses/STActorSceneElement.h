//
//  STActorSceneElement.h
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STInteractiveSceneElement.h"

@class STActorMind, STInteractiveScene;

@interface STActorSceneElement : STInteractiveSceneElement

@property (nonatomic, retain) STInteractiveScene *belongingScene;
@property (nonatomic, retain) STActorMind *mind;

@end