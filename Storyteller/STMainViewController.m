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


@interface STMainViewController ()
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UITextField *storyName;
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
    [nameAlert show];
}

/**
 *  This delegate method handles all the alertview button clicks within this view controller
 *
 *  @param alert       The particular alert that triggered this delegate method.
 *  @param buttonIndex The button index that was tapped
 */
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //There's probably a neater way to do this than hard coding these names
    
    if([alert.title isEqualToString:@"Name"])
    {
        /*
         *  When the Story Designer chooses to create a story with a new name, this method verifies that
         *  there isn't another story with the same name.
         */
        if([[alert buttonTitleAtIndex:buttonIndex] isEqualToString:@"Create Story"])
        {
            NSString *newStoryName = [alert textFieldAtIndex:0].text;
            
            //Check to see if story already exists
            STStory *story = [STStory findStoryWithName:newStoryName inContext:self.context];
            
            if(!story) //if the story doesn't exist, create it
            {
                [self initializeNewStoryWithName:newStoryName];
            }
            else
            {
                UIAlertView *duplicateAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Name"
                                                                         message:@"A Story already exists with that name. Please choose another."
                                                                        delegate:self
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil];
                [duplicateAlert show];
            }
        }
    }
    else if([alert.title isEqualToString:@"Invalid Name"])
    {
        [self initializeNewStory:nil];
    }
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
    
    //Get new Storyboard and root UISplitViewController
    UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STEditStoryStoryboard" bundle:nil];
    UISplitViewController *nextViewController = [newStoryboard instantiateInitialViewController];
    
    //Get splitView components
    UINavigationController *splitViewMasterNavController = (UINavigationController *)nextViewController.viewControllers[0];
    STEditStoryTableViewController *editStoryVC = splitViewMasterNavController.viewControllers[0];
    STEditSceneViewController *editSceneVC = nextViewController.viewControllers[1];
    
    //Set properties and delegates.
    editStoryVC.currentStory = newStory;
    editSceneVC.currentScene = [newStory stInteractiveStartingScene];
    editStoryVC.editSceneDelegate = editSceneVC;
    
#warning Insert Animation Here
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.alpha = 0;
                         nextViewController.view.alpha = 1;
                     }
                     completion:nil];
    
    
    self.view.window.rootViewController = nextViewController;
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
