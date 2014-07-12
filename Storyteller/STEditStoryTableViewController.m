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

#import "STAppDelegate.h"
#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"
#import "STSelectSceneElementViewController.h"
#import "ECSlidingViewController+EditStorySlidingViewController.h"

#import <ECSlidingViewController.h>
#import <UIViewController+ECSlidingViewController.h>


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
    self.clearsSelectionOnViewWillAppear = NO;
    
    //Set the buttons for the navigation bar of this view controller in order to go back to Main Screen
    UIBarButtonItem *mainViewControllerBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Main Screen" style:UIBarButtonItemStyleDone target:self action:@selector(toMainViewController)];
    UIBarButtonItem *addSceneBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addScene)];
    self.navigationItem.leftBarButtonItem = mainViewControllerBarButton;
    self.navigationItem.rightBarButtonItems = @[addSceneBarButton,self.editButtonItem];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Set all information based on currentStory input
    self.allScenesForCurrentStory = [self.currentStory.interactiveSceneList array];
    [self.navigationItem setTitle:@""];
    
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentStory.editingSceneIndex inSection:0]
                                animated:NO
                          scrollPosition:0];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - View Action Methods
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
-(void)addScene
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

-(void)changeToSceneAtIndex:(NSInteger)index
{
    //Save current Scene
    STAppDelegate *appDelegate = (STAppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate.coreDataHelper saveContext];
    
    //Set new current editing scene
    self.currentStory.editingSceneIndex = index;
    
    [self.slidingViewController changeEditSceneViewControllerToScene:[self.currentStory stInteractiveCurrentEditingScene]];

    
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
}

#pragma mark - TableView Datasource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.allScenesForCurrentStory.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = ((STInteractiveScene *)(self.allScenesForCurrentStory[indexPath.row])).name;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeToSceneAtIndex:indexPath.row];
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     //To Do: Handle only one element left in the list  at the beginning of the if statement
     if (editingStyle == UITableViewCellEditingStyleDelete)
     {
         NSLog(@"Number of scene Elements in story before delete: %i", [self.currentStory numberOfSceneElementsForCurrentStory]);

         // Delete the row from the data source
        [self.currentStory removeObjectFromInteractiveSceneListAtIndex:indexPath.row];
         
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

         NSIndexPath * newPath;
         //If the last entry
         if(indexPath.row == self.currentStory.interactiveSceneList.count)
         {
             //Select the next row up
             newPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
         }
         else
         {
             newPath = indexPath;
         }
         [self.tableView selectRowAtIndexPath: newPath animated:YES scrollPosition:UITableViewScrollPositionNone];
         [self changeToSceneAtIndex:newPath.row];
      
         NSLog(@"Number of scene Elements in story after delete: %i", [self.currentStory numberOfSceneElementsForCurrentStory]);


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
    [self.tableView reloadData];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.currentStory.interactiveSceneList.count-1 inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:newIndexPath
                          atScrollPosition:UITableViewScrollPositionNone animated:YES];
    [self.tableView selectRowAtIndexPath:newIndexPath
                                animated:YES
                          scrollPosition:UITableViewScrollPositionNone];
    
    [self changeToSceneAtIndex:newIndexPath.row];

    
    
}

@end
