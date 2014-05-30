//
//  STEditStoryTableViewController.h
//  Storyteller
//
//  Created by Ryan Britt on 5/26/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STEditSceneViewController.h"

@interface STEditStoryTableViewController : UITableViewController
@property (strong, nonatomic) STStory *currentStory;
@property (strong, nonatomic) STEditSceneViewController *editSceneDelegate;
@end
