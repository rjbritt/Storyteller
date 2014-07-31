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

/**
 *  Designated Initializer for STSlidingViewController. This initializes the currentStory, configures the scene based upon either
 *  the starting scene or not. If not the starting scene, the story's currently editing scene is used.
 *
 *  @param newStory   The story for which to initialize the STSlidingViewController.
 *  @param startScene If the startScene is true, the story is initialized with the startingScene, otherwise, it is initialized with its current editing scene
 *
 *  @return A properly initialized STSlidingViewController with a sliding left panel that shows all the scenes within the story and a sliding right panel that
 *  allows the addition of scene elements.
 */
-(STSlidingViewController *)initWithStory:(STStory *)newStory atStartingScene:(BOOL)startScene;

#pragma mark - SceneManagementDelegate

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
