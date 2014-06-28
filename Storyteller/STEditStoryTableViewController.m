//
//  STEditStoryTableViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 5/26/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STEditStoryTableViewController.h"
#import "STEditSceneViewController.h"
#import "STMainViewController.h"
#import "STPlayStoryPageViewController.h"

#import "STAppDelegate.h"
#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"


@interface STEditStoryTableViewController ()
@property (strong, nonatomic) NSArray *allScenesForCurrentStory;
@end

@implementation STEditStoryTableViewController

#pragma mark - View Lifecycle Methods
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.allScenesForCurrentStory = [self.currentStory.interactiveSceneList array];
    self.clearsSelectionOnViewWillAppear = NO;
    [self.navigationItem setTitle:self.currentStory.name];
    
    //Set the buttons for the navigation bar of this view controller in order to go back to Main Screen
    UIBarButtonItem *mainViewControllerBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Main Screen" style:UIBarButtonItemStyleDone target:self action:@selector(toMainViewController)];
    
    UIBarButtonItem *playBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playStory)];
    self.navigationItem.leftBarButtonItem = mainViewControllerBarButton;
    self.navigationItem.rightBarButtonItems = @[playBarButton, self.editButtonItem];

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentStory.startingSceneIndex inSection:0]
                                animated:NO
                          scrollPosition:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - View Action Methods
/**
 *  This method is to progress through the story. It will initially only support playing a story as a book format.
 */
-(void)playStory
{
    STPlayStoryPageViewController *playStoryVC = [[STPlayStoryPageViewController alloc]init];
    playStoryVC.story = self.currentStory;
    self.view.window.rootViewController = playStoryVC;

}

/**
 *  This method returns the user to the main view controller by resetting the root view controller.
 */
-(void)toMainViewController
{
    //Save current Scene
    STAppDelegate *appDelegate = (STAppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate.coreDataHelper saveContext];
    
    //Get Storyboard
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    STMainViewController *viewController = (STMainViewController *)[mainStoryboard instantiateInitialViewController];

#warning insert animation here
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.alpha = 0;
                         viewController.view.alpha = 1;
                     }
                     completion:nil];
    
    self.view.window.rootViewController = viewController;

}

#pragma mark - Tableview

/**
 *  This is a tableview property mutator for the .editing property.
 *  This modification changes it so that the tableview data is reloaded on change, 
 *  so that additional rows can be shown on editing.
 *
 *  @param editing  Whether this tableview is editing or not
 *  @param animated Whether this transition needs to be animated or not.
 */
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView reloadData];
}

#pragma mark - TableView Datasource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger rows;
    
    if(self.editing)
    {
        rows = self.allScenesForCurrentStory.count + 1;
    }
    else
    {
        rows = self.allScenesForCurrentStory.count;
    }
    
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //If editing, there will be one extra row that is for adding a new scene.
    if(self.editing)
    {
        if(indexPath.row == self.allScenesForCurrentStory.count)
        {
            cell.textLabel.text = @"Add a New Scene";
        }
        else
        {
            cell.textLabel.text = ((STInteractiveScene *)(self.allScenesForCurrentStory[indexPath.row])).name;

        }
    }
    else
    {
        cell.textLabel.text = ((STInteractiveScene *)(self.allScenesForCurrentStory[indexPath.row])).name;

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Save current Scene
    STAppDelegate *appDelegate = (STAppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate.coreDataHelper saveContext];
    
    //Set current Editing scene to the new scene.
    self.currentStory.editingSceneIndex = indexPath.row;
    
    //Create a new EditSceneViewController, set it as the current scene.
    STEditSceneViewController *temp = [self.storyboard instantiateViewControllerWithIdentifier:@"STEditSceneViewController"];
    temp.currentScene = [self.currentStory stInteractiveCurrentEditingScene];

    //Change this view controller's delegate and then change the detail view to temp.
    //Doing it this way, we may not need a delegate. Verify Later
    self.editSceneDelegate = temp;
    self.splitViewController.viewControllers = @[self.splitViewController.viewControllers[0], temp];
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle style;
    
    //Only the last row should be an insert. Will have to change how we do this for long scenes. Probably just put the + in the corner.
    if(indexPath.row == self.allScenesForCurrentStory.count)
    {
        style = UITableViewCellEditingStyleInsert;
    }
    else
    {
        style = UITableViewCellEditingStyleDelete;
    }
    
    return style;
}

 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     if (editingStyle == UITableViewCellEditingStyleDelete)
     {
         // Delete the row from the data source
        [self.currentStory removeObjectFromInteractiveSceneListAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     }
     else if (editingStyle == UITableViewCellEditingStyleInsert)
     {
         // Provide a UIAlert which will handle the actual adding to the datasource on "Create Scene"
         UIAlertView *nameAlert = [[UIAlertView alloc] initWithTitle:@"Name"
                                                             message:@"Create a name for your Scene"
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                                   otherButtonTitles:@"Create Scene",nil];
         nameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
         [nameAlert show];
     }
 }



/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - AlertView Delegate Method

/**
 *  This delegate method handles all the alertview button clicks within this view controller
 *
 *  @param alert       The particular alert that triggered this delegate method.
 *  @param buttonIndex The button index that was tapped
 */
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    if([alert.title isEqualToString:@"Name"])
    {
        
        if([[alert buttonTitleAtIndex:buttonIndex] isEqualToString:@"Create Scene"])
        {
            
            NSString *newSceneName = [alert textFieldAtIndex:0].text;
            [self addNewSceneWithName:newSceneName];
        }
    }
}

#pragma mark - Core Data Manipulation Methods

/**
 *  This method handles all the core data and UI coordination for adding a new scene into the current story.
 *
 *  @param name The name of the new scene to be added.
 */
-(void)addNewSceneWithName:(NSString *)name
{
    STAppDelegate *delegate = (STAppDelegate *)[[UIApplication sharedApplication]delegate];
    [self.currentStory addInteractiveSceneListObject:[STInteractiveScene initWithName:name inContext:delegate.coreDataHelper.context]];
    
    [delegate.coreDataHelper saveContext];
    
    self.allScenesForCurrentStory = [self.currentStory.interactiveSceneList array];
    [self setEditing:NO animated:YES];
}

@end
