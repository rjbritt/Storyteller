//
//  SceneManagementDelegate.h
//  Storyteller
//
//  Created by Ryan Britt on 7/26/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "STInteractiveScene+EaseOfUse.h"
#import "STStory+EaseOfUse.h"

@protocol SceneManagementDelegate

@property (strong, nonatomic)STStory *currentStory;
@property (strong, nonatomic)STInteractiveScene *currentScene;

-(void)selectScene:(STInteractiveScene *)scene;
-(void)addSceneElementWithImage:(UIImage *)image ofType:(STInteractiveSceneElementType)type;
-(void)addText;

@end