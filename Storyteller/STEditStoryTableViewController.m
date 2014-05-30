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


@interface STEditStoryTableViewController ()
@property (strong, nonatomic) NSArray *allScenesForCurrentStory;
@end

@implementation STEditStoryTableViewController

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
    self.clearsSelectionOnViewWillAppear = YES;
    
    [self.navigationItem setTitle:self.currentStory.name];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    UIBarButtonItem *editBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEdit)];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *mainViewControllerBarButton =[[UIBarButtonItem alloc] initWithTitle:@"All Stories" style:UIBarButtonItemStyleDone target:self action:@selector(toMainViewController)];
    self.navigationItem.leftBarButtonItem = mainViewControllerBarButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toMainViewController
{
    //Save current Scene
    STAppDelegate *appDelegate = (STAppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate.coreDataHelper saveContext];
    
    //Get Storyboard
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    STMainViewController *viewController = (STMainViewController *)[mainStoryboard instantiateInitialViewController];

#warning insert animation here
    self.view.window.rootViewController = viewController;

}

-(void)toggleEdit
{
    self.editing = !self.editing;
    
    if(self.editing)
    {
        self.navigationItem.rightBarButtonItem.title = @"Done";
    }
    else
    {
        self.navigationItem.rightBarButtonItem.title = @"Edit";
    }
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView reloadData];
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
    
    
    // Configure the cell...
    return cell;
}

//The row selected is the new scene to edit
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentStory.editingSceneIndex = indexPath.row;
    [self.editSceneDelegate refreshUIForNewScene:[self.currentStory stInteractiveCurrentEditingScene]];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle style;
    
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

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     if (editingStyle == UITableViewCellEditingStyleDelete)
     {
         // Delete the row from the data source
         // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     }
     else if (editingStyle == UITableViewCellEditingStyleInsert)
     {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         
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
    self.editing = NO;
    [self.tableView reloadData];
}


    
@end
