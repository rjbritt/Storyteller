//
//  STSelectSceneElementViewController.h
//  Storyteller
//
//  Example element selector. Use only for testing that different types of the same scene element can be used.
//
//  Created by Ryan Britt on 6/16/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIView+DragDrop.h>

#import "STInteractiveSceneElement+EaseOfUse.h"
@class STEditSceneViewController;

@interface STSelectSceneElementViewController : UIViewController
@property STInteractiveSceneElementType sceneElementType;
@property (strong, nonatomic)STEditSceneViewController *editSceneDelegate;
@end
