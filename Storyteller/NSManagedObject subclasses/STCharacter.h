//
//  STCharacter.h
//  Storyteller
//
//  Created by Ryan Britt on 10/4/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STActor, STStory;

@interface STCharacter : NSManagedObject

@property (nonatomic, retain) STStory *belongingStory;
@property (nonatomic, retain) STActor *actor;

@end
