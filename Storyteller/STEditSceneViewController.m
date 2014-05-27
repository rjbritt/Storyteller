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
#import "STActor.h"

#import "STAppDelegate.h"
#import "STInteractiveSceneUtilities.h"
#import "STInteractiveSceneSKScene.h"
#import "DraggableButton.h"
#import "STNavigationController.h"

@interface STEditSceneViewController()

@property (strong, nonatomic) NSMutableArray *actorButtonArray;
@property (strong, nonatomic) NSMutableArray *environmentButtonArray;

@property (strong, nonatomic) NSManagedObjectContext *currentContext;
@property (strong, nonatomic) STAppDelegate *appDelegate;

@property (strong, nonatomic) NSArray *allScenesForCurrentStory;
@property (weak, nonatomic) IBOutlet UILabel *tempLabelOutlet;
@end


@implementation STEditSceneViewController


#pragma mark - Button Action Methods

- (IBAction)playButton:(id)sender
{
    UIViewController * stInteractiveSceneSKSceneViewController = [[UIViewController alloc]init];
    

    //Configure the Actors
    for (UIButton *button in self.actorButtonArray)
    {
        [self updateSTInteractiveSceneElementFromButton:button];
    }
    
    
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
 * This method will add an appropriate DraggableButton for a new Actor
 *
 * @param sender The button that sent this action
 */

- (IBAction)addActorButton:(id)sender
{
    CGFloat top = self.topLayoutGuide.length;
    CGPoint desiredCenter = CGPointMake(0, top);
    DraggableButton *newActor;
    
    
    UIImage *image = [UIImage imageNamed:@"Actor.png"];
    CGRect imageFrame = CGRectMake(desiredCenter.x, desiredCenter.y, image.size.width, image.size.height);
    
//    newActor = [self createNewDraggableButtonWithName:self.currentScene.getNextPCName withFrame: imageFrame  withImage:image andTag:STInteractiveSceneDataTypePlayableCharacter];
    
    [self createSTInteractiveSceneElementFromButton:newActor];
    [self.actorButtonArray addObject:newActor];
}

- (IBAction)addEnvironmentButton:(id)sender //Currently just adds another Actor
{
    CGFloat top = self.topLayoutGuide.length;
    CGPoint desiredCenter = CGPointMake(0, top);
    DraggableButton *newActor;
    
    UIImage *image = [UIImage imageNamed:@"NPC.png"];
    CGRect imageFrame = CGRectMake(desiredCenter.x, desiredCenter.y, image.size.width, image.size.height);
    
//    newActor = [self createNewDraggableButtonWithName:self.currentScene.getNextNPCName withFrame: imageFrame  withImage:image andTag:STInteractiveSceneDataTypeNonPlayableCharacter];


    [self createSTInteractiveSceneElementFromButton:newActor];
    [self.actorButtonArray addObject:newActor];
}



#pragma mark - View Methods
-(DraggableButton *)createNewDraggableButtonWithName:(NSString*) name withFrame:(CGRect) frame withImage:(UIImage *) image andTag:(int) tag
{
    DraggableButton *temp = [DraggableButton buttonWithType:UIButtonTypeCustom];
    
    [temp setImage:image forState:UIControlStateNormal];
    [temp setTitle:name forState:UIControlStateNormal];
    temp.frame = frame;
    temp.tag = tag;
    
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
    self.tempLabelOutlet.text = self.currentScene.name;
    
    //    [self.navigationItem setTitle:self.appDelegate.currentStory.name];


    
}

-(void)viewWillAppear:(BOOL)animated
{
}
-(void)viewDidAppear:(BOOL)animated
{
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


#pragma mark - CoreData Handling Methods

/**
 * loadSavedOrCreateNewSTInteractiveScene
 *
 * Contains the logic for whether a new scene should be created or if a scene with this name already exists.
 * If a scene with this name exists, then a method is called to create the UIKit version of that scene.
 * If not, a new scene in the current context is created.
 */

-(void)loadSavedOrCreateNewSTInteractiveScene
{
    //Attempt to fetch the current scene

    STInteractiveScene *temp = [STInteractiveScene findSceneWithName:self.title inContext:self.currentContext];
    
    // If there was no current scene
    if(!temp)
    {
        //Create the Scene
        self.currentScene = [STInteractiveScene initWithName:self.title inContext:self.currentContext];
    }
    else
    {
        self.currentScene = temp;
        [self createUIKitSceneFromCurrentSTInteractiveScene];
    }
}

/**
 * createUIKitSceneFromCurrentSTInteractiveScene
 *
 * Does the heavy lifting of converting the saved STInteractiveScene into a UIKit scene.
 * Converts the actors first, then the environment, and then the objects.
 *
 */

-(void)createUIKitSceneFromCurrentSTInteractiveScene
{
    NSArray *actorArray = [self.currentScene.actorList allObjects];
    //        NSArray *environmentArray = [self.currentScene.environmentList array];
    //        NSArray *objectArray = [self.currentScene.objectList array];

    
    
    //Create All Actors
    for (STActor *actor in actorArray)
    {
        CGPoint center = [actor centerPointCGPoint];
        UIImage *theImage = [actor getUIImageFromData];
        CGRect temp = CGRectMake(center.x, center.y, theImage.size.width, theImage.size.height);
        [self.actorButtonArray addObject:[self createNewDraggableButtonWithName:actor.name withFrame:temp withImage:theImage andTag:(int)actor.tag]];
    }
}

-(void)updateSTInteractiveSceneElementFromButton:(UIButton*) button
{
    int dataType = button.tag;
    
    switch (dataType)
    {
        case STInteractiveSceneDataTypePlayableCharacter:
        case STInteractiveSceneDataTypeNonPlayableCharacter:
        {
            STActor *temp;
            
            //Attempt to fetch the appropriate STActor
            NSFetchRequest *stActorFetch = [NSFetchRequest fetchRequestWithEntityName:@"STActor"];
            NSPredicate *currentActorNameFilter = [NSPredicate predicateWithFormat:@"name == %@", button.titleLabel.text];
            [stActorFetch setPredicate:currentActorNameFilter];
            NSArray * actorArray = [self.currentContext executeFetchRequest:stActorFetch error:nil];
            
            if(actorArray.count > 0)
            {
                temp = actorArray[0];
                [temp setCenterPoint:button.center];
                temp.name = button.titleLabel.text;
                [temp setImageDataFromUIImage:button.imageView.image];
                temp.tag = button.tag;
            }
            
            [self.appDelegate.coreDataHelper saveContext];
        }
            break;
        case STInteractiveSceneDataTypeSolidEnvironment:
            break;
        case STInteractiveSceneDataTypeObject:
            break;
        default: // Invalid Datatype
            break;
    }
}

-(STInteractiveSceneElement *)createSTInteractiveSceneElementFromButton:(UIButton*) button
{
    int dataType = button.tag;
    
    switch (dataType)
    {
        case STInteractiveSceneDataTypePlayableCharacter:
        case STInteractiveSceneDataTypeNonPlayableCharacter:
        {
            STActor *tempActor = [STActor initWithName:button.titleLabel.text
                                             withImage:button.imageView.image
                                               withTag:button.tag
                                         withinContext:self.currentContext
                                            centeredAt:button.center];
            
            [self.currentScene addActorListObject:tempActor];
            [self.appDelegate.coreDataHelper saveContext];
        }
            break;
        case STInteractiveSceneDataTypeSolidEnvironment:
            break;
        case STInteractiveSceneDataTypeObject:
            break;
        default: // Invalid Datatype
            break;
    }
    return nil;
}



@end
