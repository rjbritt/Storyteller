//
//  STViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STEditSceneViewController.h"
#import "STEditStoryTableViewController.h"

#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"
#import "STInteractiveSceneElement+EaseOfUse.h"
#import "STActorSceneElement+EaseOfUse.h"
#import "STTextMedia+EaseOfUse.h"
#import "STMedia+EaseOfUse.h"

#import "STEnvironmentSceneElement.h"
#import "STObjectSceneElement.h"

#import "STAppDelegate.h"
#import "STInteractiveSceneSKScene.h"
#import "STNavigationController.h"
#import <RCDraggableButton.h>
#import <UIView+DragDrop.h>


@interface STEditSceneViewController()

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) STAppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UILabel *tempLabelOutlet;
@end


@implementation STEditSceneViewController


#pragma mark - Button Action Methods

- (IBAction)playButton:(id)sender
{
        UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STEditStoryStoryboard" bundle:nil];
    UINavigationController * stInteractiveSceneSKSceneViewController = [newStoryboard instantiateViewControllerWithIdentifier:@"STSceneViewController"];
    
    // Configure the view.
    SKView * skView = [[SKView alloc]initWithFrame:self.view.frame];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    STInteractiveSceneSKScene * scene = [[STInteractiveSceneSKScene alloc]initWithSize:skView.bounds.size andScene:self.currentScene];
        scene.scaleMode = SKSceneScaleModeAspectFit;
    
    [stInteractiveSceneSKSceneViewController.visibleViewController.view addSubview: skView];
    
    
    //Will need to subclass UIViewController for the stInteractiveSceneSKSceneViewController to have a back button.
//    UIBarButtonItem *backToSceneButton = [[UIBarButtonItem alloc] initWithTitle:@"Test" style:UIBarButtonItemStylePlain target:self action:@selector(backToSceneSelection)];
//
//    stInteractiveSceneSKSceneViewController.visibleViewController.navigationItem.leftBarButtonItem = backToSceneButton;
//    
    // Present the scene.
    [skView presentScene:scene];
    
    self.view.window.rootViewController = stInteractiveSceneSKSceneViewController;
    
}

-(void)backToSceneSelection
{
    //Get new Storyboard and root UISplitViewController
    UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STStoryStoryboard" bundle:nil];
    UISplitViewController *nextViewController = [newStoryboard instantiateInitialViewController];
    
    //Get splitView components
    UINavigationController *splitViewMasterNavController = (UINavigationController *)nextViewController.viewControllers[0];
    STEditStoryTableViewController *editStoryVC = splitViewMasterNavController.viewControllers[0];
    STEditSceneViewController *editSceneVC = nextViewController.viewControllers[1];
    
    //Set properties and delegates.
    editStoryVC.currentStory = self.currentScene.belongingStory;
    editSceneVC.currentScene = [self.currentScene.belongingStory stInteractiveCurrentEditingScene];
    editStoryVC.editSceneDelegate = editSceneVC;
    
#warning Insert Animation Here
    
    self.view.window.rootViewController = nextViewController;
}

/**
 * This method will add an appropriate RCDraggableButton and
 * call the method to add a new STActorSceneElement for a new Actor.
 *
 * @param sender The button that sent this action
 */
- (IBAction)addActorButton:(id)sender
{
    [self currentSceneStatusAtLocation:@"Add ActorButton"];
   
    CGFloat top = self.topLayoutGuide.length;
    CGPoint desiredCenter = CGPointMake(50, top + 50);
    UIImage *image = [UIImage imageNamed:@"Actor"];
    
    
    //Create ActorSceneElement
    STActorSceneElement *tempActor = (STActorSceneElement *)
                                     [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeActor
                                                                                             withName:self.currentScene.nextActorName
                                                                                            withImage:image
                                                                                        withinContext:self.context
                                                                                           centeredAt:desiredCenter];
    
                                      
    [self.currentScene addActorSceneElementListObject:tempActor];

    
    //Create Button to represent Actor
    [self createNewDraggableButtonWithName:tempActor.name
                                 withFrame:[self frameCGRectFromCenter:tempActor.centerPointCGPoint AndSize:image.size]
                                   withTag:STInteractiveSceneElementTypeActor
                                 withImage:image];
    
}

/**
 * This method will add an appropriate RCDraggableButton and
 * call the method to add a new STEnvironmentSceneElement for a new Environment.
 *
 * @param sender The button that sent this action
 */
- (IBAction)addEnvironmentButton:(id)sender
{
    [self currentSceneStatusAtLocation:@"Add EnvButton"];
    
    CGFloat top = self.topLayoutGuide.length;
    CGPoint desiredCenter = CGPointMake(50, top + 50);
    UIImage *image = [UIImage imageNamed:@"Environment"];
    
    
    //Create EnvironmentSceneElement
    STEnvironmentSceneElement  *tempEnv = (STEnvironmentSceneElement *)
                                          [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeEnvironment
                                                                                       withName:[self.currentScene nextEnviroName]
                                                                                      withImage:image
                                                                                  withinContext:self.context
                                                                                     centeredAt:desiredCenter];
    
    [self.currentScene addEnvironmentSceneElementListObject:tempEnv];
    
    
    //Create Button to represent Environment
    [self createNewDraggableButtonWithName:tempEnv.name
                                 withFrame:[self frameCGRectFromCenter:tempEnv.centerPointCGPoint AndSize:image.size]
                                   withTag:STInteractiveSceneElementTypeEnvironment
                                 withImage:image];
}

/**
 * This method will add an appropriate RCDraggableButton and
 * call the method to add a new STObjectSceneElement for a new Object.
 *
 * @param sender The button that sent this action
 */
- (IBAction)addObjectButton:(id)sender
{
    [self currentSceneStatusAtLocation:@"Add Object"];
    
    CGFloat top = self.topLayoutGuide.length;
    CGPoint desiredCenter = CGPointMake(50, top + 50);
    UIImage *image = [UIImage imageNamed:@"NPC"];
    
    
    //Create ObjectSceneElement
    STObjectSceneElement  *tempObject = (STObjectSceneElement *)
    [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeObject
                                                 withName:[self.currentScene nextObjectName]
                                                withImage:image
                                            withinContext:self.context
                                               centeredAt:desiredCenter];
    
    [self.currentScene addObjectSceneElementListObject:tempObject];
    
    
    //Create Button to represent Object
    [self createNewDraggableButtonWithName:tempObject.name
                                 withFrame:[self frameCGRectFromCenter:tempObject.centerPointCGPoint AndSize:image.size]
                                   withTag:STInteractiveSceneElementTypeObject
                                 withImage:image];
}

-(IBAction)addTextButton:(id)sender
{
    NSString *text = @"Insert Text Here.";
    CGPoint center = CGPointMake(100, 100);
    
    STTextMedia *media = [STTextMedia initWithText:text withFontSize:20 inContext:self.context atCenter:center];
    [self.currentScene addSceneMediaObject:media];
    [self createNewDraggableTextViewWithText:text atCenter:center];
}

#pragma mark - View Methods

/**
 *  Creates a new DraggableButton instance. This button is used as the UIKit representation of
 *  The different items in the scene.
 *
 *  @param name  The name of the draggable button.
 *  @param frame The frame that the button will occupy.
 *  @param tag   The Tag of the button. This is used to identify what type of item in the scene that this instance represents.
 *  @param image The image that should be displayed as the button.
 *
 *  @return The newly added DraggableButton that represents a STInteractiveSceneElement
 */
-(RCDraggableButton *)createNewDraggableButtonWithName:(NSString*) name withFrame:(CGRect) frame withTag:(int)tag withImage:(UIImage *) image
{
    [self currentSceneStatusAtLocation:@"CreateNewDraggableButton"];
    //Create RCDraggableButton with aforementioned information
    RCDraggableButton *temp = [[RCDraggableButton alloc] initWithFrame:frame];
    [temp setImage:image forState:UIControlStateNormal];
    [temp setTitle:name forState:UIControlStateNormal];
    temp.tag = tag;
    
    //Setup the Button Functions
    temp.dragEndedBlock = //This is the code block that is called at the end of a drag of the RCDraggableButton.
        ^(RCDraggableButton * button)
        {
            [self updateSTInteractiveSceneElementForButton:button];
        };
    
    //Add as subview and return
    [self.view addSubview:temp];
    return temp;
}

-(UITextView *)createNewDraggableTextViewWithText:(NSString *)text atCenter:(CGPoint)center
{
    CGRect frame = [STTextMedia genericRectForTextFieldAtCenter:center];
    UITextView *tempTextView = [[UITextView alloc]initWithFrame:frame];
    [tempTextView setFont:[UIFont systemFontOfSize:20]];
    tempTextView.text = text;
    tempTextView.opaque =  NO;
    tempTextView.backgroundColor = [UIColor clearColor];
    tempTextView.tag = STTextMediaType;
    
    
    //make a view draggable
    [tempTextView makeDraggable];
    [tempTextView setDragMode:UIViewDragDropModeNormal];
#warning will need to set delegate in order to execute update on successful drag.
    
    
    [self.view addSubview: tempTextView];
    
    return tempTextView;
}

#pragma mark - View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.appDelegate = (STAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.appDelegate.coreDataHelper.context;

    [self loadUIKitSceneFromCurrentSTInteractiveScene];
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



#pragma mark - UIKit From InteractiveSceneElement

/**
 * createUIKitSceneFromCurrentSTInteractiveScene
 *
 * Does the heavy lifting of converting the saved STInteractiveScene into a UIKit scene.
 * Converts the actors first, then the environment, and then the objects.
 *
 */
-(void)loadUIKitSceneFromCurrentSTInteractiveScene
{
    [self currentSceneStatusAtLocation:@"Load UIKit from STInteractive Scene"];
    
    NSArray *actorsInCurrentScene = [self.currentScene.actorSceneElementList array];
    NSArray *environmentsInCurrentScene = [self.currentScene.environmentSceneElementList array];
    NSArray *objectsInCurrentScene = [self.currentScene.objectSceneElementList array];
    
    NSArray *mediaInCurrentScene = [self.currentScene.sceneMedia allObjects];

    NSArray *allInteractiveElements = [[actorsInCurrentScene arrayByAddingObjectsFromArray:environmentsInCurrentScene]arrayByAddingObjectsFromArray:objectsInCurrentScene];
    
    //Create a new draggable button representing each of the scene elements
    for (STInteractiveSceneElement *element in allInteractiveElements)
    {
        CGPoint center = [element centerPointCGPoint];
        UIImage *theImage = [element getUIImageFromData];
   
        STInteractiveSceneElementType elementType;
        
        if([element isMemberOfClass:[STActorSceneElement class]])
        {
            elementType = STInteractiveSceneElementTypeActor;
        }
        else if([element isMemberOfClass:[STEnvironmentSceneElement class]])
        {
            elementType = STInteractiveSceneElementTypeEnvironment;
        }
        else
        {
            elementType = STInteractiveSceneElementTypeObject;
        }
        
        //Since we create a button with a frame and not the saved center, we need to find out what the frame would be for the saved center
        CGRect temp = [self frameCGRectFromCenter:center AndSize:theImage.size];
        [self createNewDraggableButtonWithName:element.name
                                     withFrame:temp
                                       withTag:elementType
                                     withImage:theImage];
    }
    
    for (STMedia *media in mediaInCurrentScene)
    {
        STMediaType mediaType;
        if([media isMemberOfClass:[STTextMedia class]])
        {
            mediaType = STTextMediaType;
            STTextMedia *textMedia = (STTextMedia *)media;
            [self createNewDraggableTextViewWithText:textMedia.text atCenter:[textMedia centerPointCGPoint]];
            
            
        }
    }
    
}


#pragma mark - Scene Update from UIKit

//need another method to update text
-(void)updateMediaElementLocationForSender:(id)sender
{
    //update STTextMedia;
    if ([sender isMemberOfClass:[UITextView class]])
    {
        UITextView *textView = (UITextView *)sender;
        STTextMedia *media = [STTextMedia findTextMediaWithText:textView.text
                                                        inScene:self.currentScene
                                                       andStory:self.currentScene.belongingStory
                                                      inContext:self.context];
        
        [media setCenterPoint:textView.center];
    }
}


/**
 *  This method is called on finished dragging from an RCDraggableButton for a STInteractiveSceneElement.
 *
 *  @param button The button that sent this message.
 */
-(void)updateSTInteractiveSceneElementForButton:(UIButton *)button
{
    [self currentSceneStatusAtLocation:@"Update Button"];
    
    //The button tag must be analyzed to verify the type of element that we are accessing. An Actor could
    //theoretically have the same name as an Environment. This must be understood so that the appropriate STInteractiveSceneElement
    //can be found.
    switch (button.tag)
    {
        case STInteractiveSceneElementTypeActor:
        {
            STActorSceneElement *temp = (STActorSceneElement *)
                                        [STInteractiveSceneElement findSceneElementOfType:STInteractiveSceneElementTypeActor
                                                                                 withName:button.titleLabel.text
                                                                                  inStory:self.currentScene.belongingStory
                                                                                  inScene:self.currentScene
                                                                                inContext:self.context];
            
            //If there was a returned ActorSceneElement, otherwise, there was an error.
            if(temp)
            {
                [temp setCenterPoint:button.center];
            }
        }
            break;
            
        case STInteractiveSceneElementTypeEnvironment:
        {
            STEnvironmentSceneElement *temp = (STEnvironmentSceneElement *)
                                              [STInteractiveSceneElement findSceneElementOfType:STInteractiveSceneElementTypeEnvironment
                                                                                       withName:button.titleLabel.text
                                                                                        inStory:self.currentScene.belongingStory
                                                                                        inScene:self.currentScene
                                                                                      inContext:self.context];
            
            //If there was a returned Environment, otherwise, there was an error.
            if(temp)
            {
                [temp setCenterPoint:button.center];
            }
        }
            break;
            
        case STInteractiveSceneElementTypeObject:
        {
            STObjectSceneElement *temp = (STObjectSceneElement *)
                                         [STInteractiveSceneElement findSceneElementOfType:STInteractiveSceneElementTypeObject
                                                                                  withName:button.titleLabel.text
                                                                                   inStory:self.currentScene.belongingStory
                                                                                   inScene:self.currentScene
                                                                                 inContext:self.context];
            
            //If there was a returned Object, otherwise, there was an error.
            if(temp)
            {
                [temp setCenterPoint:button.center];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - Utility Methods

/**
 *  This method returns a CGRect in UIView coordinates that can be understood as the frame of an image given its
 *  center and size
 *
 *  @param center The centerpoint of the rectangle.
 *  @param size   The size of the rectangle.
 *
 *  @return A configured Frame Rectangle
 */
-(CGRect)frameCGRectFromCenter:(CGPoint)center AndSize:(CGSize)size
{
    CGRect frame = CGRectMake(center.x-((size.width)/2),center.y-((size.height)/2), size.width, size.height);
    
    return frame;
}

/**
 *  Easy method of calculating a bounding rectangle for variable length text. 
 *  Obtained from http://stackoverflow.com/questions/9181368/ios-dynamic-sizing-labels/18750292#18750292
 *
 *  @param text    The text for which a user wants the bounding rectangle.
 *  @param font    The font the text will use.
 *  @param maxSize The maximum size that the rectangle can be.
 *
 *  @return returns An appropriate bounding rectangle for the particular text.
 */
-(CGRect)rectForText:(NSString *)text
           usingFont:(UIFont *)font
       boundedBySize:(CGSize)maxSize
{
    NSAttributedString *attrString =
    [[NSAttributedString alloc] initWithString:text
                                    attributes:@{ NSFontAttributeName:font}];
    
    return [attrString boundingRectWithSize:maxSize
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                    context:nil];
}

-(void)currentSceneStatusAtLocation:(NSString *)location
{
    NSLog(@"Current Scene: %@ , Current Actor Count: %i, Location: %@", self.currentScene.name, self.currentScene.actorSceneElementList.count, location);
}

@end
