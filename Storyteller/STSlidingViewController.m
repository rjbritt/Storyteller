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

/**
 *  Designated Initializer for STSlidingViewController. This initializes the currentStory, configures the scene based upon either
 *  the starting scene or not. If not the starting scene, the story's currently editing scene is used.
 *
 *  @param newStory   The story for which to initialize the STSlidingViewController.
 *  @param startScene If the startScene is true, the story is initialized with the startingScene, otherwise, it is initialized with its current editing scene
 *
 *  @return A properly initialized STSlidingViewController with a sliding left panel that shows all the scenes within the story and a sliding right panel that
 *  allows the addition of scene elements.
 */
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
        
        UIGestureRecognizer *gestureRecognizer = self.panGesture;
        gestureRecognizer.delegate = self;
        [topVC.view addGestureRecognizer:gestureRecognizer];
        
        
        //Setup Story Navigation Controller
        
        //make sure it doesn't go under the topview controller
        storyNavigationController.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeLeft;
        STEditStoryTableViewController *editStoryVC = (STEditStoryTableViewController *)storyNavigationController.visibleViewController;
        editStoryVC.sceneManagementDelegate = self;
        editStoryVC.currentStory = newStory;
        self.editStoryVC = editStoryVC;
        
        //Prepare the edit scene VC if there are any scenes in the story.
        if (newStory.interactiveSceneList.count > 0)
        {
            SwiftSceneSelectionViewController *sceneSelectVC = [newStoryboard instantiateViewControllerWithIdentifier:@"SceneElementSelectionController"];

            //Make sure left and right view controllers don't go under the topview controller
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
            
            //Set Data and Delegate properties
            editSceneVC.currentScene = scene;
            sceneSelectVC.sceneManagementDelegate = self;
            
            //Set Visual Properties
            self.sceneSelectVC.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            //Create Sliding Controller setup
            self.underRightViewController = sceneSelectVC;
            
            //Set Class Properties
            self.currentScene = scene;
            self.editSceneVC = editSceneVC;

        }
        else
        {
            UIViewController *newVC = [newStoryboard instantiateViewControllerWithIdentifier:@"BlankScene"];
            [topVC setViewControllers:@[newVC]];
        }
        
        //Setup Default Sliding Controller Values
        self.topViewController = topVC;
        self.underLeftViewController = storyNavigationController;
        self.currentStory = newStory;
        self.anchorLeftRevealAmount = self.anchorRightRevealAmount;


    }
    return self;
}

#pragma mark - SceneManagementDelegate


-(void)selectScene:(STInteractiveScene *)scene
{
    UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STEditStoryStoryboard" bundle:nil];
    UINavigationController *newTopVC = [newStoryboard instantiateViewControllerWithIdentifier:@"STEditSceneNavViewController"];
   
    if(scene)
    {
        //Instantiate new STEditSceneViewController to erase all the scene elements from the previous scene.
        STEditSceneViewController *newSceneViewController = (STEditSceneViewController *)newTopVC.visibleViewController;
        UIGestureRecognizer *gestureRecognizer = self.panGesture;
        gestureRecognizer.delegate = self;
        [newTopVC.view addGestureRecognizer:gestureRecognizer];
        
        //Set current Editing scene to the new scene.
        newSceneViewController.currentScene = scene;
        self.editSceneVC = newSceneViewController;
        //If the scene select VC has not been initialized
        if(!self.sceneSelectVC)
        {
            self.sceneSelectVC = [newStoryboard instantiateViewControllerWithIdentifier:@"SceneElementSelectionController"];
            self.sceneSelectVC.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeRight;
            self.sceneSelectVC.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        self.sceneSelectVC.sceneManagementDelegate = self;
        self.topViewController = newTopVC;
        //Needs to be set since the blank scene has no under right view controller
        self.underRightViewController = self.sceneSelectVC;
        self.currentScene = scene;

    }
    else
    {
        UIViewController *newVC = [newStoryboard instantiateViewControllerWithIdentifier:@"BlankScene"];
        [((UINavigationController *)self.topViewController) setViewControllers:@[newVC]];
        self.underRightViewController = nil;
    }
    

    
}

-(void)addSceneElementWithImage:(UIImage *)image ofType:(NSString *)type
{
    [self.editSceneVC showElementSelect:nil];
    if([type isEqualToString:@"Actor"])
    {
        [self.editSceneVC addActorSceneElementWithImage:image];
    }
    else if([type isEqualToString:@"Environment"])
    {
        [self.editSceneVC addEnvironmentSceneElementWithImage:image];
    }
    else if([type isEqualToString:@"Object"])
    {
        [self.editSceneVC addObjectSceneElementWithImage:image];
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
