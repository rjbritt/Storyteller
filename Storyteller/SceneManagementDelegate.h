//
//  SceneManagementDelegate.h
//  Storyteller
//
//  Created by Ryan Britt on 7/26/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "STInteractiveSceneElement+EaseOfUse.h"
#import "STStory+EaseOfUse.h"

@protocol SceneManagementDelegate

@property (strong, nonatomic)STStory *currentStory;
@property (strong, nonatomic)STInteractiveScene *currentScene;

/**
 *  Selects a new scene and changes the topViewController for the STSlidingViewController. If Nil is passed, an appropriate screen for no selected scene is shown.
 *
 *  @param scene A scene within the current story to switch to. Or Nil, if no scene is selected (reserved for the case that there
 *  are no available scenes to choose from).
 */
-(void)selectScene:(STInteractiveScene *)scene;

/**
 *  Adds a new scene element to the appropriate scene view controller and STInteractiveScene
 *  through the use of delegate methods.
 *
 *  @param image UIImage that represents the new scene element
 *  @param type  A string that is either "Actor", "Environment", or "Object". Any other string
 *  is not processed as a scene element.
 */
-(void)addSceneElementWithImage:(UIImage *)image ofType:(NSString *)type;

/**
 *  Adds a new text box to the appropriate scene view controller and STInteractiveScene through
 *  the use of delegate methods.
 */
-(void)addText;

@end