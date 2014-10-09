//
//  STPresentSKSceneViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 6/12/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STPresentSKSceneViewController.h"
#import "STInteractiveSceneSKScene.h"
#import "STMainViewController.h"
#import "STManagedObjectImportAll.h"
#import "STEditSceneViewController.h"
#import "STEditStoryTableViewController.h"

#import "STSlidingViewController.h"

@interface STPresentSKSceneViewController ()
@property (strong, nonatomic) SKView *skView;
@property (strong, nonatomic) STInteractiveSceneSKScene* skScene;
@end

@implementation STPresentSKSceneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    // Create and Present the scene.
    self.skView = [[SKView alloc]initWithFrame:self.view.frame];
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    
    self.skScene = [[STInteractiveSceneSKScene alloc]initWithSize:self.skView.bounds.size andScene:self.scene];
    self.skScene.scaleMode = SKSceneScaleModeAspectFit;
    
    [self.view addSubview: self.skView];
    [self.skView presentScene:self.skScene];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.navigationController)
    {
        UIBarButtonItem *backToSceneButton = [[UIBarButtonItem alloc]
                                       initWithTitle:self.scene.name
                                               style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(backToSceneSelection)];
        
        self.navigationController.visibleViewController.navigationItem.leftBarButtonItem = backToSceneButton;
        //
        self.view.window.rootViewController = self.presentingViewController;
        
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToSceneSelection
{
    //Load the selected story, set the editing scene to the starting scene.
    STStory *selectedStory = self.scene.belongingStory;
    STSlidingViewController *nextViewController = [[STSlidingViewController alloc] initWithStory:selectedStory atStartingScene:NO];
#warning Insert Animation Here
    
    self.view.window.rootViewController = nextViewController;
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
