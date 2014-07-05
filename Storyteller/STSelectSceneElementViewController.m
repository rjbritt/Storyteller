//
//  STSelectSceneElementViewController.m
//  Storyteller
//
//  Example element selector. Use only for testing that different types of the same scene element can be used.
//
//  Created by Ryan Britt on 6/16/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STSelectSceneElementViewController.h"
#import "STEditSceneViewController.h"


@interface STSelectSceneElementViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
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
    
    switch (self.sceneElementType)
    {
            
        case STInteractiveSceneElementTypeActor:
            //set up buttons specific to actors
            [self.button1 setImage:[UIImage imageNamed:@"Actor"] forState:UIControlStateNormal];
            [self.button2 setImage:[UIImage imageNamed:@"Actor 2"] forState:UIControlStateNormal];
            [self.button3 setImage:[UIImage imageNamed:@"Actor 3"] forState:UIControlStateNormal];
            
            break;
        case STInteractiveSceneElementTypeEnvironment:
            //set up buttons specific to environments
            [self.button1 setImage:[UIImage imageNamed:@"Environment"] forState:UIControlStateNormal];
            [self.button2 setImage:[UIImage imageNamed:@"Environment 2"] forState:UIControlStateNormal];
            [self.button3 setImage:[UIImage imageNamed:@"Environment3"] forState:UIControlStateNormal];
            
            break;
        case STInteractiveSceneElementTypeObject:
            //set up buttons specific to objects
            [self.button1 setImage:[UIImage imageNamed:@"Object"] forState:UIControlStateNormal];
            [self.button2 setImage:[UIImage imageNamed:@"Object 2"] forState:UIControlStateNormal];
            [self.button3 setImage:[UIImage imageNamed:@"Object 3"] forState:UIControlStateNormal];

            break;
            
        default:
            break;
            
    }
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initNewButtonWithImage:(UIImage *)image andType:(NSString *)type atOrigin:(CGPoint)origin
{
    UIButton *temp = [[UIButton alloc] initWithFrame:CGRectMake(origin.x, origin.y, image.size.width, image.size.height)];
    [temp setImage:image forState:UIControlStateNormal];
    
    if([type isEqualToString:@"actor"])
    {
        [temp addTarget:self action:@selector(actorSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if ([type isEqualToString:@"environment"])
    {
        [temp addTarget:self action:@selector(envSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [temp addTarget:self action:@selector(objSelect:) forControlEvents:UIControlEventTouchUpInside];

    }
    //Add as subview and return
    [self.view addSubview:temp];
}

-(void)actorSelect:(id)sender
{
    UIButton *button = sender;
}
-(void)envSelect:(id)sender
{
    
}
-(void)objSelect:(id)sender
{
    
}


@end
