//
//  STViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STEditSceneViewController.h"

#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"
#import "STInteractiveSceneElement+EaseOfUse.h"
#import "STActorSceneElement+EaseOfUse.h"

#import "STAppDelegate.h"
#import "STInteractiveSceneSKScene.h"
//#import "DraggableButton.h"
#import "STNavigationController.h"
#import <RCDraggableButton.h>


@interface STEditSceneViewController()

@property (strong, nonatomic) NSManagedObjectContext *currentContext;
@property (strong, nonatomic) STAppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UILabel *tempLabelOutlet;
@end


@implementation STEditSceneViewController


#pragma mark - Button Action Methods

- (IBAction)playButton:(id)sender
{
    UIViewController * stInteractiveSceneSKSceneViewController = [[UIViewController alloc]init]; 
    
    // Configure the view.
    SKView * skView = [[SKView alloc]initWithFrame:self.view.frame];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    STInteractiveSceneSKScene * scene = [[STInteractiveSceneSKScene alloc]initWithSize:skView.bounds.size andName:self.title];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    stInteractiveSceneSKSceneViewController.view = skView;
    
    // Present the scene.
    [skView presentScene:scene];
    

    //Push the view controller
    ((STNavigationController*)self.navigationController).forceNoAnimatePop = YES;
    [self.navigationController pushViewController:stInteractiveSceneSKSceneViewController animated:NO];
    
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
    CGPoint desiredOrigin = CGPointMake(0, top);
    
    
    UIImage *image = [UIImage imageNamed:@"Actor"];
    CGRect imageFrame = CGRectMake(desiredOrigin.x, desiredOrigin.y, image.size.width, image.size.height);
    
    //Button is created separately from STInteractiveScene element
    //because createNewDraggableButton is also used in loading.
    RCDraggableButton *button = [self createNewDraggableButtonWithName:[self.currentScene nextActorName]
                                                              withFrame:imageFrame
                                                                withTag:STInteractiveSceneElementTypeActor
                                                              withImage:image];
    
    //Create the appropriate STInteractiveSceneElement for this newly created actor button
    [self createSTInteractiveSceneElementFromButton:button];
}

- (IBAction)addEnvironmentButton:(id)sender
{
    
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
#pragma mark - View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.appDelegate = (STAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.currentContext = self.appDelegate.coreDataHelper.context;

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
    //        NSArray *environmentArray = [self.currentScene.environmentList array];
    //        NSArray *objectArray = [self.currentScene.objectList array];

    
    //Create a new draggable button representing each of the actor scene elements
    for (STActorSceneElement *actor in actorsInCurrentScene)
    {
        CGPoint center = [actor centerPointCGPoint];
        UIImage *theImage = [actor getUIImageFromData];
        
        //Since we create a button with a frame and not the saved center, we need to find out what the frame would be for the saved center
        CGRect temp = [self frameCGRectFromCenter:center AndSize:theImage.size];
        
        [self createNewDraggableButtonWithName:actor.name
                                     withFrame:temp
                                       withTag:STInteractiveSceneElementTypeActor
                                     withImage:theImage];
    }
}

#pragma mark - InteractiveSceneElement Update from UIKit

/**
 *  This method is called from an appropriate button response method in order to create a new Interactive Scene Element
 *  with the correct default parameters and add it to the correct list.
 *
 *  @param button The button that will be turned into a new STInteractiveSceneElement.
 */
-(void)createSTInteractiveSceneElementFromButton:(UIButton*)button
{
    [self currentSceneStatusAtLocation:@"Create STInteractiveElement from Button"];
    //For now they will all be similar, but eventually the different Elements will have different
    //initial parameters and must be set in this method.
    switch (button.tag)
    {
        case STInteractiveSceneElementTypeActor:
        {
            STActorSceneElement *tempActor = [STActorSceneElement initActorWithName:button.titleLabel.text
                                                                     withImage:button.imageView.image
                                                                 withinContext:self.currentContext
                                                                    centeredAt:button.center];
            
            [self.currentScene addActorSceneElementListObject:tempActor];
            
        }
            break;
        case STInteractiveSceneElementTypeEnvironment:
        {
        }
            break;
        case STInteractiveSceneElementTypeObject:
            break;
        default: // Invalid Datatype
            break;
    }
}

/**
 *  This method is called on finished dragging from an RCDraggableButton.
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
            STActorSceneElement *temp = [STActorSceneElement findActorSceneElementWithName:button.titleLabel.text
                                                                                   inStory:self.currentScene.belongingStory
                                                                                   inScene:self.currentScene
                                                                                 inContext:self.currentContext];
                                         
            //If there was a returned ActorSceneElement, otherwise, there was an error.
            if(temp)
            {
                NSLog(@"Button Center: %lf , %lf", button.center.x, button.center.y);
                [temp setCenterPoint:button.center];
            }
        }
            break;
        case STInteractiveSceneElementTypeEnvironment:
        {
            
        }
            break;
        case STInteractiveSceneElementTypeObject:
        {
            
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


-(void)currentSceneStatusAtLocation:(NSString *)location
{
    NSLog(@"Current Scene: %@ , Current Actor Count: %i, Location: %@", self.currentScene.name, self.currentScene.actorSceneElementList.count, location);
}

@end
