
//
//  STEnvironment.h
//  Storyteller
//
//  Created by Ryan Britt on 10/4/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STStory;

@interface STEnvironment : NSManagedObject

@property (nonatomic, retain) STStory *belongingStory;

@end
