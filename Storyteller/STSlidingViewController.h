//
//  STSlidingViewController.h
//  Storyteller
//
//  Created by Ryan Britt on 7/26/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "ECSlidingViewController.h"
#import "SceneManagementDelegate.h"
#import "STInteractiveSceneElement+EaseOfUse.h"

@interface STSlidingViewController : ECSlidingViewController  <SceneManagementDelegate, UIGestureRecognizerDelegate>

-(STSlidingViewController *)initWithStory:(STStory *)newStory atStartingScene:(BOOL)startScene;
-(void)selectScene:(STInteractiveScene *)scene;
-(void)addSceneElementWithImage:(UIImage *)image ofType:(STInteractiveSceneElementType)type;
-(void)addText;

@end
