//
//  STPlayStoryViewController.m
//  Storyteller
//
//  Entire View Controller is created programmatically
//
//  Created by Ryan Britt on 6/9/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STPlayStoryPageViewController.h"
#import "STInteractiveSceneSKScene.h"
#import "STPresentSKSceneViewController.h"
#import "STSlidingViewController.h"

#import "STManagedObjectImportAll.h"

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
    STPresentSKSceneViewController* temp;

    //protect from going out of bounds
    if(index < self.allScenes.count)
    {
        UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"STEditStoryStoryboard" bundle:nil];
        temp = [newStoryboard instantiateViewControllerWithIdentifier:@"STPresentSKSceneViewController"];
        STInteractiveScene *sceneToDisplayOnPage = self.allScenes[index];

        temp.scene =  sceneToDisplayOnPage;
    }
    
    return temp;
}
-(NSInteger)indexOfViewController:(UIViewController *)controller
{
    //given that an view controller is only created as above this should work.
    NSInteger index = NSNotFound;
    if([controller isMemberOfClass:[STPresentSKSceneViewController class]])
    {
        for (UIView *temp in controller.view.subviews)
        {
            if([temp isMemberOfClass:[SKView class]])
            {
                SKView *currentView = (SKView *)temp;
                
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
    
    //If we go beyond the first page of the story, then we go back to the editing page
    if ((index == 0) || (index == NSNotFound))
    {
#warning Create Animation Here for context shift
        self.view.window.rootViewController = [[STSlidingViewController alloc] initWithStory:self.story atStartingScene:NO];
    }
    
    //otherwise, return the previous page
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
