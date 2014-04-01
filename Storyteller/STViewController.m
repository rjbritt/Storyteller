//
//  STViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STViewController.h"
#import "STInteractiveScene.h"
#import "DraggableButton.h"

@interface STViewController()
@property BOOL actorHasBeenAdded;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation STViewController

// Interactive Data Source properties
@synthesize actors;
@synthesize environment;


- (IBAction)playButton:(id)sender
{
    UIViewController * gameViewController = [[UIViewController alloc]init];
    
    // Configure the view.
    SKView * skView = [[SKView alloc]initWithFrame:self.view.frame];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    STInteractiveScene * scene = [[STInteractiveScene alloc]initWithSize:skView.bounds.size andData:self];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    gameViewController.view = skView;
    
    // Present the scene.
    [skView presentScene:scene];
    
//    [self presentViewController:gameViewController animated:YES completion:Nil];
    [self.navigationController pushViewController:gameViewController animated:YES];
}

- (IBAction)addEnvironmentButton:(id)sender
{
}



- (IBAction)addActorButton:(id)sender
{
    
    if (!self.actorHasBeenAdded)
    {
        
        UIImage *image = [UIImage imageNamed:@"Actor.png"];
        CGRect imageFrame = CGRectMake(0, 0, image.size.width, image.size.height);
        
        [self.actors addObject:[self createNewDraggableButtonWithName:@"Actor" withFrame: imageFrame  withImage:image andTag:STInteractiveSceneDataTypePlayableCharacter]];
        
        self.actorHasBeenAdded = YES;
    }
    else
    {
        UIImage *image = [UIImage imageNamed:@"NPC.png"];
        CGRect imageFrame = CGRectMake(0, 0, image.size.width, image.size.height);
        
        DraggableButton *temp = [self createNewDraggableButtonWithName:@"NPC" withFrame: imageFrame  withImage:image andTag:STInteractiveSceneDataTypeNonPlayableCharacter];
        temp.tintColor = [UIColor blueColor];
        
        [self.actors addObject:temp];
        
    }
}



-(DraggableButton *)createNewDraggableButtonWithName:(NSString*) name withFrame:(CGRect) frame withImage:(UIImage *) image andTag:(int) tag
{
    DraggableButton *temp = [DraggableButton buttonWithType:UIButtonTypeCustom];
    
    //    [temp addTarget:self action:@selector(hideTabBarButton:) forControlEvents:UIControlEventTouchDragInside];
    //    [temp addTarget:self action:@selector(showTabBarButton:) forControlEvents:UIControlEventTouchDragExit];
    
    [temp setImage:image forState:UIControlStateNormal];
    [temp setTitle:name forState:UIControlStateNormal];
    temp.frame = frame;
    
    [self.scrollView addSubview:temp];
    
    return temp;
}
#pragma -mark View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.actors = [[NSMutableArray alloc]init];
    self.environment = [[NSMutableArray alloc]init];
    self.actorHasBeenAdded = NO;
    
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
}

-(void)viewDidLayoutSubviews
{
    if(self.scrollView)
    {
        
        
//        CGFloat top = self.topLayoutGuide.length;
//        CGFloat bot = self.bottomLayoutGuide.length;
//        
//        self.scrollView.contentInset = UIEdgeInsetsMake(top, 0, bot, 0);
//        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.scrollView.contentSize = self.view.bounds.size;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.scrollView flashScrollIndicators];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


@end
