//
//  STPlayStoryViewController.h
//  Storyteller
//
//  Created by Ryan Britt on 6/9/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class STStory;
@interface STPlayStoryPageViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) STStory *story;
@property(strong, nonatomic)STPlayStoryPageViewController *currentPage;
@property(strong, nonatomic)NSArray *allScenes;
@end
