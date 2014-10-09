//
//  STCharacterSceneElement.h
//  Storyteller
//
//  Created by Ryan Britt on 10/4/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STInteractiveSceneElement.h"

@class STInteractiveScene;

@interface STCharacterSceneElement : STInteractiveSceneElement

@property (nonatomic, retain) STInteractiveScene *belongingScene;

@end
