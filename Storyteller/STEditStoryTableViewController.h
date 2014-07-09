//
//  STEditStoryTableViewController.h
//  Storyteller
//
//  Created by Ryan Britt on 5/26/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STStory;

@interface STEditStoryTableViewController : UITableViewController
@property (strong, nonatomic) STStory *currentStory; //Necessary In order to properly initialize this VC
@end
