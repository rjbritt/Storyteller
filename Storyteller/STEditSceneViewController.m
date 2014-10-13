//
//  STEditSceneViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "CoreData.h"

#import "STEditSceneViewController.h"
#import "STEditStoryTableViewController.h"
#import "STPresentSKSceneViewController.h"
#import "STPlayStoryPageViewController.h"
#import "STEditSceneViewController.h"

#import "STManagedObjectImportAll.h"

#import <UIViewController+ECSlidingViewController.h>

#import "UIKitEditScene.h"


@interface STEditSceneViewController()

@property (strong, nonatomic) NSManagedObjectContext *context;
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

#pragma mark - Public Methods
/**
 * Creates a new STCharacterSceneElement and initiates the creation
 * of a draggable button to represent this scene element.
 *
 * @param image The image that this scene element will use.
 * @param desiredCenter The desired center for the scene element.
 */
-(void)addCharacterSceneElementWithImage:(UIImage *)image atCenter:(CGPoint)desiredCenter
{
    //Create CharacterSceneElement data
    STInteractiveSceneElement *tempActor = [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeCharacter
                                                                                        withName:self.currentScene.nextCharacterElementName
                                                                                       withImage:image
                                                                                   withinContext:self.context
                                                                                      centeredAt:desiredCenter];
                                      
    [self.currentScene addCharacterSceneElementListObject:(STCharacterSceneElement *)tempActor];
    
    //Create Button to represent Actor
    [self.uiKitScene createNewDraggableSceneElementWithSceneElement:tempActor andTag:STInteractiveSceneElementTypeCharacter];
    
}


/**
 * Creates a new STEnvironmentSceneElement and initiates the creation
 * of a draggable button to represent this scene element.
 *
 * @param image The image that this scene element will use.
 * @param desiredCenter The desired center for the scene element.
 */
-(void)addEnvironmentSceneElementWithImage:(UIImage *)image atCenter:(CGPoint)desiredCenter;
{
    //Create EnvironmentSceneElement
    STInteractiveSceneElement  *tempEnv = [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeEnvironment
                                                                                       withName:[self.currentScene nextEnviroElementName]
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
 * @param image The image that this scene element will use.
 * @param desiredCenter The desired center for the scene element.
 */
-(void)addObjectSceneElementWithImage:(UIImage *)image atCenter:(CGPoint)desiredCenter
{
    
    //Create ObjectSceneElement
    STInteractiveSceneElement *tempObject = [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeObject
                                                                                    withName:[self.currentScene nextObjectElementName]
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
 *  @param center CGPoint representing the desired center of the Text
 */
-(void)addTextAtCenter:(CGPoint)center
{
    NSString *text = @"Insert Text Here.";
    
    STTextMedia *media = [STTextMedia initWithText:text withFontSize:20 inContext:self.context atCenter:center];
    [self.currentScene addSceneMediaObject:media];
    [self.uiKitScene createNewDraggableTextViewWithText:text atCenter:center withSize:[UIKitEditScene textViewSize]];
}

#pragma mark - ECSlidingViewController Methods
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

/**
 *  Switches between an anchored or non anchored position to show the
 *  element select panel. Configured for the element select panel being shown on the right side of the screen.
 *
 *  @param sender What entity sent the message. May be nil.
 */
- (IBAction)showElementSelect:(id)sender
{
    //Allows switching between anchored and not
    if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionCentered) {
        [self.slidingViewController anchorTopViewToLeftAnimated:YES];
    } else {
        [self.slidingViewController resetTopViewAnimated:YES];
    }
}


#pragma mark - View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.context = [[CoreData sharedInstance]context];
    UITextField * titleText =(UITextField *) self.navigationItem.titleView;

    titleText.text = [NSString stringWithFormat:@"%@ - %@",self.currentScene.belongingStory.name, self.currentScene.name];
    titleText.textColor = self.view.tintColor;
    self.uiKitScene = [[UIKitEditScene alloc]initWithScene:self.currentScene inContext:self.context andPresentingViewController:self];

}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
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

#pragma mark - UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = self.currentScene.name;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currentScene.name = textField.text;
    textField.text = [NSString stringWithFormat:@"%@ - %@", self.currentScene.belongingStory.name, self.currentScene.name];
    
    //updates the tableview if the tableview. If the tableview is onscreen at the same time, this allows the simultaneous changes.
    // Might be better to do with a notification
    if(self.slidingViewController)
    {
        UINavigationController *underLeftVC = ((UINavigationController *)self.slidingViewController.underLeftViewController);
        [((STEditStoryTableViewController *)underLeftVC.visibleViewController).tableView reloadData];
    }
    
}

@end
