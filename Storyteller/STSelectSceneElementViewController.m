//
//  STSelectSceneElementViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 7/5/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STSelectSceneElementViewController.h"
#import "STInteractiveSceneElement+EaseOfUse.h"
#import "STEditSceneViewController.h"

#import "STInteractiveSceneElement+EaseOfUse.h"
#import "STActorSceneElement+EaseOfUse.h"
#import "STEnvironmentSceneElement+EaseOfUse.h"
#import "STObjectSceneElement+EaseOfUse.h"
#import "STTextMedia+EaseOfUse.h"
#import "STMedia+EaseOfUse.h"

#import "STInteractiveScene+EaseOfUse.h"

#import <UIViewController+ECSlidingViewController.h>
#import <ECSlidingViewController.h>
#import <RCDraggableButton.h>


@interface STSelectSceneElementViewController ()
@property (strong, nonatomic) STEditSceneViewController *editSceneVC;
@end

@implementation STSelectSceneElementViewController

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
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Setup for connecting the appropriate scenes
    if (self.slidingViewController)
    {
        UINavigationController *topVC = (UINavigationController *)self.slidingViewController.topViewController;
        self.editSceneVC = (STEditSceneViewController *)topVC.visibleViewController;
    }
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
- (IBAction)addActorButton:(id)sender
{
    [self.editSceneVC addActorButton:sender];
}
- (IBAction)addEnvironmentButton:(id)sender
{
    [self.editSceneVC addEnvironmentButton:sender];
}
- (IBAction)addObjectButton:(id)sender
{
    [self.editSceneVC addObjectButton:sender];
}
- (IBAction)addTextButton:(id)sender
{
    [self.editSceneVC addTextButton:sender];
}



@end
