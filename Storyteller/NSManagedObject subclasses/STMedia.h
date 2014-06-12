//
//  STMedia.h
//  Storyteller
//
//  Created by Ryan Britt on 6/11/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STInteractiveScene, STStory;

@interface STMedia : NSManagedObject

@property (nonatomic, retain) STStory *belongingStoryOnly;
@property (nonatomic, retain) STInteractiveScene *belongingSceneOnly;

@end
