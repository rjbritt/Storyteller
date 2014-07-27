//
//  STSlidingViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 7/26/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STSlidingViewController.h"

#import "STEditSceneViewController.h"
#import "STEditStoryTableViewController.h"
#import "Storyteller-Swift-Ordered.h"
#import "STStory+EaseOfUse.h"

#import "STMedia+EaseOfUse.h"
#import "STInteractiveSceneElement+EaseOfUse.h"

#import <RCDraggableButton.h>

@interface STSlidingViewController ()

@property (strong, nonatomic) STEditSceneViewController *editSceneVC;
@property (strong, nonatomic) STEditStoryTableViewController *editStoryVC;
@property (strong, nonatomic) SwiftSceneSelectionViewController *sceneSelectVC;

@end

@implementation STSlidingViewController

@synthesize currentStory;
@synthesize currentScene;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(STSlidingViewController *)initWithStory:(STStory *)newStory atStartingScene:(BOOL)startScene
{
    self = [[STSlidingViewController alloc]init];
    if(self)
    {
        //Get new Storyboard
        UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STEditStoryStoryboard" bundle:nil];
        
        //Get controllers for management under the sliding view controller
        UINavigationController *topVC = [newStoryboard instantiateViewControllerWithIdentifier:@"STEditSceneNavViewController"];
        UINavigationController *storyNavigationController = [newStoryboard instantiateViewControllerWithIdentifier:@"EditStoryNavController"];
        SwiftSceneSelectionViewController *sceneSelectVC = [newStoryboard instantiateViewControllerWithIdentifier:@"SceneElementSelectionController"];
        
        //Make sure left and right view controllers don't go under the topview controller
        storyNavigationController.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeLeft;
        sceneSelectVC.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeRight;
        
        // Configure current scene
        STInteractiveScene *scene;
        if (startScene)
        {
            scene = [newStory stInteractiveStartingScene];
        }
        else
        {
            scene = [newStory stInteractiveCurrentEditingScene];
        }
        
        //Derive the EditScene/EditStory VCs
        STEditSceneViewController *editSceneVC = (STEditSceneViewController *)topVC.visibleViewController;
        STEditStoryTableViewController *editStoryVC = (STEditStoryTableViewController *)storyNavigationController.visibleViewController;
        
        //Set Data and Delegate properties
        editStoryVC.currentStory = newStory;
        editSceneVC.currentScene = scene;
        
        editStoryVC.sceneManagementDelegate = self;
        sceneSelectVC.sceneManagementDelegate = self;
        
        
        //Set Visual Properties
        self.sceneSelectVC.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        
        //Create Sliding Controller setup
        self.topViewController = topVC;
        self.underLeftViewController = storyNavigationController;
        self.underRightViewController = sceneSelectVC;
        self.anchorLeftRevealAmount = self.anchorRightRevealAmount;
        
        UIGestureRecognizer *gestureRecognizer = self.panGesture;
        gestureRecognizer.delegate = self;
        [topVC.view addGestureRecognizer:gestureRecognizer];
        
        //Set Class Properties
        self.currentStory = newStory;
        self.currentScene = scene;
        self.editStoryVC = editStoryVC;
        self.editSceneVC = editSceneVC;
        
    }
    return self;
}

#pragma mark - SceneManagementDelegate
-(void)selectScene:(STInteractiveScene *)scene
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
    self.editSceneVC = newSceneViewController;
    self.sceneSelectVC.sceneManagementDelegate = self;

    
}
-(void)addSceneElementWithImage:(UIImage *)image ofType:(STInteractiveSceneElementType)type
{
    [self.editSceneVC showElementSelect:nil];
    switch (type)
    {
        case STInteractiveSceneElementTypeActor:
            [self.editSceneVC addActorSceneElementWithImage:image];
            break;
        case STInteractiveSceneElementTypeEnvironment:
            [self.editSceneVC addEnvironmentSceneElementWithImage:image];
            break;
        case STInteractiveSceneElementTypeObject:
            [self.editSceneVC addObjectSceneElementWithImage:image];
            break;
        default:
            break;
    }
}

-(void)addText
{
    [self.editSceneVC showElementSelect:nil];
    [self.editSceneVC addTextButton:nil];
    
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
}

@end
