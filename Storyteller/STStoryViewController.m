//
//  STStoryViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STStoryViewController.h"

#import "STAppDelegate.h"
#import "STStory.h"

@interface STStoryViewController ()

@property (strong, nonatomic) STAppDelegate *appDelegate;
@property (strong, nonatomic) STStory *currentStory;
@property (strong, nonatomic) NSManagedObjectContext *currentContext;

@end

@implementation STStoryViewController

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
    
    // Initialize all private properties
    self.appDelegate = (STAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.currentContext = self.appDelegate.coreDataHelper.context;
    self.currentStory = self.appDelegate.currentStory;
    
    [self.navigationItem setTitle:self.appDelegate.currentStory.name];
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
