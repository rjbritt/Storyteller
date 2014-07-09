//
//  STLoadStoryTableViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STLoadStoryTableViewController.h"
#import "STAppDelegate.h"
#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"
#import "STEditStoryTableViewController.h"
#import "STEditSceneViewController.h"

#import <ECSlidingViewController.h>
#import "ECSlidingViewController+EditStorySlidingViewController.h"

@interface STLoadStoryTableViewController ()
@property (strong, nonatomic) STAppDelegate *appDelegate;
@property (strong, nonatomic) NSArray *storyList;
@property (strong, nonatomic) UISplitViewController *storySplitViewController;

@end

@implementation STLoadStoryTableViewController

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
    
    self.appDelegate = (STAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.storyList = [STStory findAllStoriesAscendinglyWithinContext:self.appDelegate.coreDataHelper.context];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationItem setTitle:@"Load Story"];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.storyList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = ((STStory *)self.storyList[indexPath.row]).name;
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Load the selected story, set the editing scene to the starting scene.
    STStory *selectedStory = self.storyList[indexPath.row];
    ECSlidingViewController *nextViewController = [ECSlidingViewController slidingViewControllerForStory:selectedStory atStartingScene:NO];

#warning Insert Animation Here
    //Flip Animation maybe?
    self.view.window.rootViewController = nextViewController;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         // Delete All the scenes from the story
         STStory  *storyToDelete = self.storyList[indexPath.row];
         [storyToDelete removeInteractiveSceneList:storyToDelete.interactiveSceneList];
         
         //Delete the Story itself.
         [self.appDelegate.coreDataHelper.context deleteObject:storyToDelete];
         
         self.storyList = [STStory findAllStoriesAscendinglyWithinContext:self.appDelegate.coreDataHelper.context];
         [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         [self.tableView reloadData];

     }
     else if (editingStyle == UITableViewCellEditingStyleInsert)
     {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

@end
