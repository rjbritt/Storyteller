//
//  STSelectSceneElementViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 7/5/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STSelectSceneElementViewController.h"
#import "STEditSceneViewController.h"


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
    [self.editSceneDelegate showElementSelect:sender];
    [self.editSceneDelegate addActorButton:sender];
}
- (IBAction)addEnvironmentButton:(id)sender
{
    [self.editSceneDelegate showElementSelect:sender];
    [self.editSceneDelegate addEnvironmentButton:sender];
}
- (IBAction)addObjectButton:(id)sender
{
    [self.editSceneDelegate showElementSelect:sender];
    [self.editSceneDelegate addObjectButton:sender];
}
- (IBAction)addTextButton:(id)sender
{
    [self.editSceneDelegate showElementSelect:sender];
    [self.editSceneDelegate addTextButton:sender];
}



@end
