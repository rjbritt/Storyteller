//
//  STEditStoryTableViewController.h
//  Storyteller
//
//  Created by Ryan Britt on 5/26/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneManagementDelegate.h"

@class STStory;

@interface STEditStoryTableViewController : UITableViewController
/**
 *  Current Story that is used for showing this VC. It is necessary to set this 
 *  property before initializing this VC in order to properly load this VC.
 */
@property (strong, nonatomic) STStory *currentStory;

/**
 *  VC that implements the SceneManagementDelegate. This is primarily used to
 *  handle the scene selection within this VC.
 */
@property (strong, nonatomic) UIViewController<SceneManagementDelegate> *sceneManagementDelegate;
@end
