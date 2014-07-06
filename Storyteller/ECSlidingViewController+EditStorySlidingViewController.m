//
//  ECSlidingViewController+EditStorySlidingViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 7/5/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "ECSlidingViewController+EditStorySlidingViewController.h"

#import "STEditSceneViewController.h"
#import "STEditStoryTableViewController.h"
#import "STStory+EaseOfUse.h"

@implementation ECSlidingViewController (EditStorySlidingViewController)

+(ECSlidingViewController *)slidingViewControllerForStory:(STStory *)newStory atStartingScene:(BOOL)startScene
{
    //Get new Storyboard
    UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STEditStoryStoryboard" bundle:nil];
    
    //Get controllers for management under the sliding view controller
    UINavigationController *topVC = [newStoryboard instantiateViewControllerWithIdentifier:@"STEditSceneNavViewController"];
    UINavigationController *storyNavigationController = [newStoryboard instantiateViewControllerWithIdentifier:@"EditStoryNavController"];
    UIViewController *sceneElementSelectionController =[newStoryboard instantiateViewControllerWithIdentifier:@"SceneElementSelectionController"];
    
    //Make sure left and right view controllers don't go under the topview controller
    storyNavigationController.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeLeft;
    sceneElementSelectionController.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeRight;
    
    //Derive the EditScene/EditStory VCs
    STEditSceneViewController *editSceneVC = (STEditSceneViewController *)topVC.visibleViewController;
    STEditStoryTableViewController *editStoryVC = (STEditStoryTableViewController *)storyNavigationController.visibleViewController;
    
    //Set Data properties
    editStoryVC.currentStory = newStory;
    if (startScene)
    {
        editSceneVC.currentScene = [newStory stInteractiveStartingScene];
    }
    else
    {
        editSceneVC.currentScene = [newStory stInteractiveCurrentEditingScene];

    }
    
    //Set Visual Properties
//    editStoryVC.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    sceneElementSelectionController.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Create Sliding Controller setup
    ECSlidingViewController *slidingViewController = [ECSlidingViewController slidingWithTopViewController:topVC];
    slidingViewController.underLeftViewController = storyNavigationController;
    slidingViewController.underRightViewController = sceneElementSelectionController;
    
    slidingViewController.anchorLeftRevealAmount = slidingViewController.anchorRightRevealAmount;
    
    return slidingViewController;
    
}

@end
