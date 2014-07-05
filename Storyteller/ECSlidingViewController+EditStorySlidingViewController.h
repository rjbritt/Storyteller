//
//  ECSlidingViewController+EditStorySlidingViewController.h
//  Storyteller
//
//  Created by Ryan Britt on 7/5/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "ECSlidingViewController.h"

@class STStory;
@interface ECSlidingViewController (EditStorySlidingViewController)

+(ECSlidingViewController *)slidingViewControllerForStory:(STStory *)newStory;
@end
