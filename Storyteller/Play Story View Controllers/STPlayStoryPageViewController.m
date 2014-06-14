//
//  STPlayStoryViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 6/9/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STPlayStoryPageViewController.h"
#import "STInteractiveSceneSKScene.h"
#import "STPresentSKSceneViewController.h"

#import "STStory+EaseOfUse.h"

@interface STPlayStoryPageViewController ()
@end

@implementation STPlayStoryPageViewController

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
    
    //Each page will be a separate scene
    self.allScenes = [self.story.interactiveSceneList array];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                        forKey:UIPageViewControllerOptionSpineLocationKey];
    
    UIPageViewController *pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                            options:options];
    
    pageViewController.dataSource = self;
    pageViewController.view.frame = self.view.bounds;
    UIViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[initialViewController];
    [pageViewController setViewControllers:viewControllers
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:YES completion:nil];
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    [pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController *)viewControllerAtIndex:(NSInteger)index
{
    
//    UIViewController *controller = [[UIViewController alloc]init];
//    STInteractiveScene *sceneToDisplayOnPage = self.allScenes[index];
//
//    // Configure the view based on scene to display
//    SKView * skView = [[SKView alloc]initWithFrame:self.view.frame];
//    
//    STInteractiveSceneSKScene * scene = [[STInteractiveSceneSKScene alloc]initWithSize:skView.bounds.size andScene:sceneToDisplayOnPage];
//    scene.scaleMode = SKSceneScaleModeAspectFit;
//    
//    [controller.view addSubview: skView];
//    [skView presentScene:scene];
    
    STPresentSKSceneViewController* temp;

    //protect from going out of bounds
    if(index < self.allScenes.count)
    {
        UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STEditStoryStoryboard" bundle:nil];
        temp = [newStoryboard instantiateViewControllerWithIdentifier:@"STPresentSKSceneViewController"];
        STInteractiveScene *sceneToDisplayOnPage = self.allScenes[index];

        temp.scene =  sceneToDisplayOnPage;
        
        //Modify stpresentskscenenviewcontroller to
        //work w/ navigation controller as well as
        //independently control the presentation of an skscene.

    }
    
    return temp;
}
-(NSInteger)indexOfViewController:(UIViewController *)controller
{
    //given that an view controller is only created as above this should work. This will be ripped out later.
    
    NSInteger index;
    if([controller isMemberOfClass:[STPresentSKSceneViewController class]])
    {
        for (UIView *temp in controller.view.subviews)
        {
            if([temp isMemberOfClass:[SKView class]])
            {
                SKView *currentView = (SKView *)temp;
                
                //protect from falling over the edge
                index = [self.allScenes indexOfObject:
                         ((STInteractiveSceneSKScene *)currentView.scene).currentScene];

            }
        }

    }
    return index;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    NSInteger index = [self indexOfViewController:viewController];
    
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:viewController];
    if(index == NSNotFound)
    {
        return nil;
    }
    index ++;
    return [self viewControllerAtIndex:index];
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
