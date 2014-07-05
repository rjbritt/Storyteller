//
//  STEditSceneViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STEditSceneViewController.h"
#import "STEditStoryTableViewController.h"
#import "STSelectSceneElementViewController.h"

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
#import "STPresentSKSceneViewController.h"
#import <RCDraggableButton.h>
#import <ECSlidingViewController.h>
#import <UIViewController+ECSlidingViewController.h>

@interface STEditSceneViewController()

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) STAppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) STTextMedia *editingTextMedia;
@property (weak, nonatomic) IBOutlet UILabel *tempLabelOutlet;
@end


@implementation STEditSceneViewController


#pragma mark - Button Action Methods


/**
 *  Initiates an example of what the scene will look like when it is
 *  presented as an element of a story. Sets the new rootViewController since a navigation element is needed
 *  between the UISplitView and UINavigationView.
 *
 *  @param sender The Object that sent the action.
 */
- (IBAction)playButton:(id)sender
{
        UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STEditStoryStoryboard" bundle:nil];
    UINavigationController * skSceneNavigationController = [newStoryboard instantiateViewControllerWithIdentifier:@"STPresentSKSceneNavigationController"];
    STPresentSKSceneViewController *temp = skSceneNavigationController.viewControllers[0];
    temp.scene = self.currentScene;
    
#warning  Insert animation here
    self.view.window.rootViewController = skSceneNavigationController;
    
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
    [self createNewDraggableSceneElementWithName:tempActor.name
                                 withFrame:[self frameCGRectFromCenter:tempActor.centerPointCGPoint AndSize:image.size]
                                   withTag:STInteractiveSceneElementTypeActor
                                 withImage:image];
    
}


/**
 * Creates a new STEnvironmentSceneElement and initiates the creation
 * of a draggable button to represent this scene element.
 *
 * @param sender The object that sent this action
 */
- (IBAction)addEnvironmentButton:(id)sender
{
    [self currentSceneStatusAtLocation:@"Add EnvButton"];
    
    CGFloat top = self.topLayoutGuide.length;
    CGPoint desiredCenter = CGPointMake(50, top + 50);
    UIImage *image = [UIImage imageNamed:@"Actor 2"];
    
    
    //Create EnvironmentSceneElement
    STEnvironmentSceneElement  *tempEnv = (STEnvironmentSceneElement *)
                                          [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeEnvironment
                                                                                       withName:[self.currentScene nextEnviroName]
                                                                                      withImage:image
                                                                                  withinContext:self.context
                                                                                     centeredAt:desiredCenter];
    
    [self.currentScene addEnvironmentSceneElementListObject:tempEnv];
    
    
    //Create Button to represent Environment
    [self createNewDraggableSceneElementWithName:tempEnv.name
                                 withFrame:[self frameCGRectFromCenter:tempEnv.centerPointCGPoint AndSize:image.size]
                                   withTag:STInteractiveSceneElementTypeEnvironment
                                 withImage:image];
}

/**
 * Creates a new STObjectSceneElement and initiates the creation
 * of a draggable button to represent this scene element.
 *
 * @param sender The object that sent this action
 */
- (IBAction)addObjectButton:(id)sender
{
    [self currentSceneStatusAtLocation:@"Add Object"];
    
    CGFloat top = self.topLayoutGuide.length;
    CGPoint desiredCenter = CGPointMake(50, top + 50);
    UIImage *image = [UIImage imageNamed:@"Actor 3"];
    
    
    //Create ObjectSceneElement
    STObjectSceneElement  *tempObject = (STObjectSceneElement *)
    [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeObject
                                                 withName:[self.currentScene nextObjectName]
                                                withImage:image
                                            withinContext:self.context
                                               centeredAt:desiredCenter];
    
    [self.currentScene addObjectSceneElementListObject:tempObject];
    
    
    //Create Button to represent Object
    [self createNewDraggableSceneElementWithName:tempObject.name
                                 withFrame:[self frameCGRectFromCenter:tempObject.centerPointCGPoint AndSize:image.size]
                                   withTag:STInteractiveSceneElementTypeObject
                                 withImage:image];
}

/**
 * Creates a new STTextMedia and initiates the creation
 * of a draggable UITextView to represent this scene element.
 *
 *  @param sender The object that sent this action.
 */
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
 *  Creates a new SceneElement with a RCDraggableButton instance. This button is used as the UIKit representation of
 *  the different items in the scene.
 *
 *  @param name  The name of the draggable button.
 *  @param frame The frame that the button will occupy.
 *  @param tag   The Tag of the button. This is used to identify what type of item in the scene that this instance represents.
 *  @param image The image that should be displayed as the button.
 *
 *  @return The newly added DraggableButton that represents a STInteractiveSceneElement
 */
-(RCDraggableButton *)createNewDraggableSceneElementWithName:(NSString*) name withFrame:(CGRect) frame withTag:(int)tag withImage:(UIImage *) image
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


/**
 *  Creates a new UITextView that has been made draggable.
 *
 *  @param text   The text that will appear in the textview by default
 *  @param center The point where the textview needs to be centered
 *
 *  @return A properly configured draggable UITextView.
 */
-(UITextView *)createNewDraggableTextViewWithText:(NSString *)text atCenter:(CGPoint)center
{
    CGRect frame = [STTextMedia genericRectForTextFieldAtCenter:center];
    
    UITextView *tempTextView = [[UITextView alloc]initWithFrame:frame];
    [tempTextView setFont:[UIFont systemFontOfSize:20]];
    tempTextView.text = text;
    tempTextView.opaque =  NO;
    tempTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    tempTextView.tag = STTextMediaType;
    tempTextView.delegate = self;
    
    
    //make a view draggable
    [tempTextView makeDraggableWithDropViews:@[self.view] delegate:self];
    [tempTextView setDragMode:UIViewDragDropModeNormal];
    
    
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


#pragma mark - View Controller Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"actorElementSelect"] || [segue.identifier isEqualToString:@"environmentElementSelect"] || [segue.identifier isEqualToString:@"objectElementSelect"])
    {
        STSelectSceneElementViewController *selectVC = segue.destinationViewController;
        selectVC.editSceneDelegate = self;
        
        if ([segue.identifier isEqualToString:@"actorElementSelect"])
        {
            selectVC.sceneElementType = STInteractiveSceneElementTypeActor;
        }
        else if([segue.identifier isEqualToString:@"environmentElementSelect"])
        {
            selectVC.sceneElementType = STInteractiveSceneElementTypeEnvironment;
        }
        else
        {
            selectVC.sceneElementType = STInteractiveSceneElementTypeObject;
        }
        
    }
    
    
}


#pragma mark - UIView + DragDrop Delegate Methods
- (void) view:(UIView *)view wasDroppedOnDropView:(UIView *)drop
{
    if ([view isMemberOfClass:[UITextView class]])
    {
        [self updateMediaElementLocationForSender:view];
    }
}

- (BOOL) viewShouldReturnToStartingPosition:(UIView*)view
{
    return NO;
}

- (void) draggingDidBeginForView:(UIView*)view
{
    
}
- (void) draggingDidEndWithoutDropForView:(UIView*)view
{
    if ([view isMemberOfClass:[UITextView class]])
    {
        [self updateMediaElementLocationForSender:view];
    }
}

- (void) view:(UIView *)view didHoverOverDropView:(UIView *)dropView
{

}
- (void) view:(UIView *)view didUnhoverOverDropView:(UIView *)dropView
{
    
}

#pragma mark - TextView Delegate

/**
 *  TextView Delegate method used to signify that a textView has begun editing. This
 *  is used to identify the textview that is currently being edited as its instance of STTextMedia
 *
 *  @param textView The textView that is being edited.
 */
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.editingTextMedia = [STTextMedia findTextMediaWithText:textView.text
                                                       inScene:self.currentScene
                                                      andStory:self.currentScene.belongingStory
                                                     inContext:self.context];
}

/**
 *  TextView Delegate method used to signify that a textView has ended editing. This
 *  is used to set the appropriate STTextMedia's current text as to keep it in line with 
 *  TextView for proper loading.
 *
 *  @param textView The textView that has finished editing.
 */
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.editingTextMedia.text = textView.text;
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
        [self createNewDraggableSceneElementWithName:element.name
                                     withFrame:temp
                                       withTag:elementType
                                     withImage:theImage];
    }
    
    for (STMedia *media in mediaInCurrentScene)
    {
        if([media isMemberOfClass:[STTextMedia class]])
        {
            STTextMedia *textMedia = (STTextMedia *)media;
            [self createNewDraggableTextViewWithText:textMedia.text atCenter:[textMedia centerPointCGPoint]];
            
            
        }
    }
    
}


#pragma mark - Scene Update from UIKit


/**
 *  This is a generic method that should be able to update any location of a media item
 *  within the scene. The first iteration is only for STTextMedia.
 *
 *  @param sender Whatever media element that needs to be updated.
 */
-(void)updateMediaElementLocationForSender:(id)sender
{
    //update STTextMedia Location;
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

/**
 *  Debug method. Tells current state of the scene at a particular location within the scene.
 *
 *  @param location The string that represents the location.
 */
-(void)currentSceneStatusAtLocation:(NSString *)location
{
    NSLog(@"Current Scene: %@ , Current Actor Count: %i, Location: %@", self.currentScene.name, self.currentScene.actorSceneElementList.count, location);
}

@end
