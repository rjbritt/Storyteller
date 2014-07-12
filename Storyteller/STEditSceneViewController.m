//
//  STEditSceneViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STAppDelegate.h"

#import "STEditSceneViewController.h"
#import "STEditStoryTableViewController.h"
#import "STPresentSKSceneViewController.h"
#import "STPlayStoryPageViewController.h"
#import "STEditSceneViewController.h"

#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"
#import "STMedia+EaseOfUse.h"
#import "STTextMedia+EaseOfUse.h"

#import <ECSlidingViewController.h>
#import <UIViewController+ECSlidingViewController.h>

#import "UIKitEditScene.h"


@interface STEditSceneViewController()

@property (strong, nonatomic) STAppDelegate *appDelegate;
@property (strong, nonatomic) STTextMedia *editingTextMedia;
@property (strong, nonatomic) UIKitEditScene *uiKitScene;

@end


@implementation STEditSceneViewController


#pragma mark - Button Action Methods


/**
 *  Initiates an example of what the scene will look like when it is
 *  presented as an element of a story. Sets the new rootViewController.
 *
 *  @param sender The Object that sent the action.
 */
- (IBAction)testSceneButton:(id)sender
{
    UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STEditStoryStoryboard" bundle:nil];
    STPresentSKSceneViewController *temp = [newStoryboard instantiateViewControllerWithIdentifier:@"STPresentSKSceneViewController"];
    temp.scene = self.currentScene;
    [self.navigationController pushViewController:temp animated:YES];
}

/**
 *  This method is to progress through the story. It will initially only support playing a story as a book format.
 */
-(IBAction)readStory:(id)sender
{
    STPlayStoryPageViewController *playStoryVC = [[STPlayStoryPageViewController alloc]init];
    playStoryVC.story = self.currentScene.belongingStory;
    self.view.window.rootViewController = playStoryVC;
    
}


- (IBAction)showAllScenes:(id)sender
{
    if (self.slidingViewController)
    {
        //Allows switching between anchored and not
        if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionCentered) {
            [self.slidingViewController anchorTopViewToRightAnimated:YES];
        } else {
            [self.slidingViewController resetTopViewAnimated:YES];
        }
    }
}

- (IBAction)showElementSelect:(id)sender
{
    //Allows switching between anchored and not
    if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionCentered) {
        [self.slidingViewController anchorTopViewToLeftAnimated:YES];
    } else {
        [self.slidingViewController resetTopViewAnimated:YES];
    }
}

/**
 * Creates a new STActorSceneElement and initiates the creation
 * of a draggable button to represent this scene element.
 *
 * @param sender The object that sent this action
 */
- (void)addActorButton:(id)sender
{
    CGFloat top = self.topLayoutGuide.length;
    CGPoint desiredCenter = CGPointMake(50, top + 50);
    UIImage *image = [UIImage imageNamed:@"Actor"];
    
    
    //Create ActorSceneElement
    STInteractiveSceneElement *tempActor = [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeActor
                                                                                        withName:self.currentScene.nextActorName
                                                                                       withImage:image
                                                                                   withinContext:self.context
                                                                                      centeredAt:desiredCenter];
    
                                      
    [self.currentScene addActorSceneElementListObject:(STActorSceneElement *)tempActor];
    
    //Create Button to represent Actor
    [self.uiKitScene createNewDraggableSceneElementWithSceneElement:tempActor andTag:STInteractiveSceneElementTypeActor];
    
}


/**
 * Creates a new STEnvironmentSceneElement and initiates the creation
 * of a draggable button to represent this scene element.
 *
 * @param sender The object that sent this action
 */
- (void)addEnvironmentButton:(id)sender
{
    CGFloat top = self.topLayoutGuide.length;
    CGPoint desiredCenter = CGPointMake(50, top + 50);
    UIImage *image = [UIImage imageNamed:@"Actor 2"];
    
    
    //Create EnvironmentSceneElement
    STInteractiveSceneElement  *tempEnv = [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeEnvironment
                                                                                       withName:[self.currentScene nextEnviroName]
                                                                                      withImage:image
                                                                                  withinContext:self.context
                                                                                     centeredAt:desiredCenter];
    
    [self.currentScene addEnvironmentSceneElementListObject:(STEnvironmentSceneElement *)tempEnv];
    
    
    //Create Button to represent Environment
    [self.uiKitScene createNewDraggableSceneElementWithSceneElement:tempEnv andTag:STInteractiveSceneElementTypeEnvironment];
}

/**
 * Creates a new STObjectSceneElement and initiates the creation
 * of a draggable button to represent this scene element.
 *
 * @param sender The object that sent this action
 */
- (void)addObjectButton:(id)sender
{
    CGFloat top = self.topLayoutGuide.length;
    CGPoint desiredCenter = CGPointMake(50, top + 50);
    UIImage *image = [UIImage imageNamed:@"Actor 3"];
    
    
    //Create ObjectSceneElement
    STInteractiveSceneElement *tempObject = [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeObject
                                                                                    withName:[self.currentScene nextObjectName]
                                                                                   withImage:image
                                                                               withinContext:self.context
                                                                                  centeredAt:desiredCenter];
    
    [self.currentScene addObjectSceneElementListObject:(STObjectSceneElement *)tempObject];
    
    
    //Create Button to represent Object
    [self.uiKitScene createNewDraggableSceneElementWithSceneElement:tempObject andTag:STInteractiveSceneElementTypeObject];
}

/**
 * Creates a new STTextMedia and initiates the creation
 * of a draggable UITextView to represent this scene element.
 *
 *  @param sender The object that sent this action.
 */
-(void)addTextButton:(id)sender
{
    NSString *text = @"Insert Text Here.";
    CGPoint center = CGPointMake(100, 100);
    
    STTextMedia *media = [STTextMedia initWithText:text withFontSize:20 inContext:self.context atCenter:center];
    [self.currentScene addSceneMediaObject:media];
    [self.uiKitScene createNewDraggableTextViewWithText:text atCenter:center];
}

#pragma mark - View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.appDelegate = (STAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.appDelegate.coreDataHelper.context;
    [self setTitle:[NSString stringWithFormat:@"%@ - %@",self.currentScene.belongingStory.name, self.currentScene.name]];
    self.uiKitScene = [[UIKitEditScene alloc]initWithScene:self.currentScene inContext:self.context andView:self.view];

}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View Controller Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}



@end
