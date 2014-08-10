//
//  STViewController.h
//  Storyteller
//

//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <UIView+DragDrop.h>


@class STInteractiveScene;

@interface STEditSceneViewController : UIViewController<UITextFieldDelegate>

/**
 *  Current scene that this VC will show. This must not be nil when a STEditSceneVC instance is loaded.
 */
@property (strong, nonatomic) STInteractiveScene *currentScene;

/**
 * Creates a new STTextMedia and initiates the creation
 * of a draggable UITextView to represent this scene element.
 *
 *  @param center CGPoint representing the desired center of the Text
 */
-(void)addTextAtCenter:(CGPoint)center;

/**
 * Creates a new STActorSceneElement and initiates the creation
 * of a draggable button to represent this scene element.
 *
 * @param image The image that this scene element will use.
 * @param desiredCenter The desired center for the scene element.
 */
-(void)addActorSceneElementWithImage:(UIImage *)image atCenter:(CGPoint)desiredCenter;

/**
 * Creates a new STEnvironmentSceneElement and initiates the creation
 * of a draggable button to represent this scene element.
 *
 * @param image The image that this scene element will use.
 * @param desiredCenter The desired center for the scene element.
 */
-(void)addEnvironmentSceneElementWithImage:(UIImage *)image atCenter:(CGPoint)desiredCenter;

/**
 * Creates a new STObjectSceneElement and initiates the creation
 * of a draggable button to represent this scene element.
 *
 * @param image The image that this scene element will use.
 * @param desiredCenter The desired center for the scene element.
 */
-(void)addObjectSceneElementWithImage:(UIImage *)image atCenter:(CGPoint)desiredCenter;

/**
 *  Switches between an anchored or non anchored position to show the
 *  element select panel. Configured for the element select panel being shown on the right side of the screen.
 *
 *  @param sender What entity sent the message. May be nil.
 */
- (IBAction)showElementSelect:(id)sender;


@end
