//
//  STMainViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STMainViewController.h"
#import "STEditStoryTableViewController.h"
#import "STEditSceneViewController.h"

#import "STAppDelegate.h"
#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"

#import "STSlidingViewController.h"
#import "STSlidingViewController.h"

#import <RCDraggableButton.h>
#import <UIAlertView+Blocks.h>

@interface STMainViewController ()
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UITextField *storyName;
@property (strong, nonatomic) STSlidingViewController *slidingViewController;
@end

@implementation STMainViewController

/**
 *  This is an IBAction to initialize a new story. It will create an alertview for the user to name the Story.
 *
 *  @param sender What UI item triggered the method.
 */
- (IBAction)initializeNewStory:(id)sender
{
    UIAlertView *nameAlert = [[UIAlertView alloc] initWithTitle:@"Name"
                                                             message:@"Create a name for your Story"
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Create Story",nil];
    
    nameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    nameAlert.tapBlock = ^(UIAlertView *alert, NSInteger buttonIndex)
    {
        // When the Story designer chooses to create a story with a new name, this verifies that
        // there isn't another story with the same name.
        if([[alert buttonTitleAtIndex:buttonIndex] isEqualToString:@"Create Story"])
        {
            NSString *newStoryName = [alert textFieldAtIndex:0].text;
            
            //Check to see if story already exists
            STStory *story = [STStory findStoryWithName:newStoryName inContext:self.context];
            
            if(!story) //if the story doesn't exist, create it
            {
                [self initializeNewStoryWithName:newStoryName];
            }
            else //otherwise show a new alertview that explains that the story already exists
            {
                [UIAlertView showWithTitle:@"Invalid name"
                                   message:@"A Story already exists with that name. Please choose another."
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil
                                  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
                { [self initializeNewStory:nil]; }];
            }
        }
    };
    
    [nameAlert show];
}

/**
 *  Initializes a new story with a starting scene.
 *
 *  @param newStoryName The name of the new story to create.
 */
-(void)initializeNewStoryWithName:(NSString *)newStoryName
{
    STStory *newStory = [STStory initWithName:newStoryName inContext:self.context];
    
    //Create Starting Scene and set the currently editing scene to the starting scene
    STInteractiveScene *startingScene = [STInteractiveScene initWithName:@"First Scene" inContext:self.context];
    [newStory setNewSceneToStartingScene:startingScene];
    newStory.editingSceneIndex = newStory.startingSceneIndex;
    
    self.slidingViewController = [[STSlidingViewController alloc] initWithStory:newStory atStartingScene:YES];
    
#warning Insert Animation Here
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.alpha = 0;
                         self.slidingViewController.view.alpha = 1;
                     }
                     completion:nil];
    
    self.view.window.rootViewController = self.slidingViewController;
}

#pragma mark - Lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.context = ((STAppDelegate*)[[UIApplication sharedApplication]delegate]).coreDataHelper.context;
    [self.navigationItem setTitle:@"Home"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
