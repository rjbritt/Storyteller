//
//  STAppDelegate.h
//  Storyteller
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"
#import "STStory.h"

@interface STAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CoreDataHelper *coreDataHelper;
@property (strong, nonatomic) STStory *currentStory;

@end
