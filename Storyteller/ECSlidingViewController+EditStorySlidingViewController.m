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
#import "STSelectSceneElementViewController.h"
#import "Storyteller-Swift.h"

#import "STMedia+EaseOfUse.h"
#import "STInteractiveSceneElement+EaseOfUse.h"

#import <RCDraggableButton.h>
@implementation ECSlidingViewController (EditStorySlidingViewController)

-(ECSlidingViewController *)initSlidingViewControllerForStory:(STStory *)newStory atStartingScene:(BOOL)startScene
{
    self = [super init];
    if(self)
    {
        //Get new Storyboard
        UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STEditStoryStoryboard" bundle:nil];
        
        //Get controllers for management under the sliding view controller
        UINavigationController *topVC = [newStoryboard instantiateViewControllerWithIdentifier:@"STEditSceneNavViewController"];
        UINavigationController *storyNavigationController = [newStoryboard instantiateViewControllerWithIdentifier:@"EditStoryNavController"];
        //STSelectSceneElementViewController *sceneElementSelectionController =[newStoryboard instantiateViewControllerWithIdentifier:@"SceneElementSelectionController"];
        SwiftSceneSelectionViewController *sceneElementSelectionController = [newStoryboard instantiateViewControllerWithIdentifier:@"SceneElementSelectionController"];
        
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
        sceneElementSelectionController.editSceneDelegate = editSceneVC;
        
        
        //Set Visual Properties
        //editStoryVC.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        sceneElementSelectionController.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        //Create Sliding Controller setup
        self = [ECSlidingViewController slidingWithTopViewController:topVC];
        self.underLeftViewController = storyNavigationController;
        self.underRightViewController = sceneElementSelectionController;
        
        self.anchorLeftRevealAmount = self.anchorRightRevealAmount;

        UIGestureRecognizer *gestureRecognizer = self.panGesture;
        gestureRecognizer.delegate = self;
        [topVC.view addGestureRecognizer:gestureRecognizer];
    
    }
    return self;
}



-(void)changeEditSceneViewControllerToScene:(STInteractiveScene *)scene
{
    //Instantiate new STEditSceneViewController to erase all the scene elements from the previous scene.
    UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STEditStoryStoryboard" bundle:nil];
    UINavigationController *newTopVC = [newStoryboard instantiateViewControllerWithIdentifier:@"STEditSceneNavViewController"];
    STEditSceneViewController *newSceneViewController = (STEditSceneViewController *)newTopVC.visibleViewController;
    
    UIGestureRecognizer *gestureRecognizer = self.panGesture;
    gestureRecognizer.delegate = self;
    [newTopVC.view addGestureRecognizer:gestureRecognizer];
    
    //Set current Editing scene to the new scene.
    newSceneViewController.currentScene = scene;
    
    self.topViewController = newTopVC;
    
    //I don't like doing it this way, but since we delete all the objects on screen by creating a new VC, we have to manually
    //reset the edit scene delegate so that appropriate view updates when the delegate is called..
    ((STSelectSceneElementViewController *)self.underRightViewController).editSceneDelegate = newSceneViewController;
    
}

#pragma mark - Gesture Recognizer Delegate

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //Derive the current EditSceneVC
    UINavigationController *topVC = (UINavigationController *) self.topViewController;
    STEditSceneViewController *editSceneVC = (STEditSceneViewController *)topVC.visibleViewController;
    
    //Check if there are any currently dragging buttons in the view. If so, don't allow the gesture recognizer to begin.
    NSArray *subviews = editSceneVC.view.subviews;
    for (UIView *view in subviews)
    {
        if ([view isKindOfClass:[RCDraggableButton class]])
        {
            RCDraggableButton *button = (RCDraggableButton *)view;
            if(button.isDragging)
            {
                return NO;
            }
        }
    }
    
    return YES;
} @end
