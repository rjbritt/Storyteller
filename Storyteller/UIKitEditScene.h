//
//  UIKitEditScene.h
//  Storyteller
//
//  This is a sublcass of NSObject that works as a view controller for handling the
//  placement, update, and delete of UI objects.
//  This class must be created and used within a subclass of UIViewController in order to work properly.
//
//  Created by Ryan Britt on 7/8/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STManagedObjectImportAll.h"
#import <UIKit/UIKit.h>
#import <UIView+DragDrop.h>
@class STInteractiveScene;
@class RCDraggableButton;

@interface UIKitEditScene : NSObject <UITextViewDelegate, UIViewDragDropDelegate>

/**
 *  Designated Initializer used to create an instance of a UIKit Scene based on the
 *  information in the STInteractiveScene within a certain context while attaching
 *  subviews to the specified view.
 *
 *  @param scene   STInteractiveScene that contains all of the information that will be represented within this scene.
 *  @param context NSManagedObjectContext where this scene is found and where updates will be saved.
 *  @param viewController    The subclass of UIViewController which controls the view that will have subviews added to it to create a represented STInteractiveScene.
 *
 *  @return A fully initialized UIKitEditScene object with all of the appropriate information.
 */
-(id)initWithScene:(STInteractiveScene *)scene inContext:(NSManagedObjectContext *)context andPresentingViewController:(UIViewController *)viewController;

/**
 *  Creates a new SceneElement with a RCDraggableButton instance and adds it as a subview. This button is used as the UIKit representation of
 *  the different items in the scene.
 *
 *  @param name  The name of the draggable button.
 *  @param frame The frame that the button will occupy.
 *  @param tag   The Tag of the button. This is used to identify what type of item in the scene that this instance represents.
 *  @param image The image that should be displayed as the button.
 *
 */
-(void)createNewDraggableSceneElementWithSceneElement:(STInteractiveSceneElement *)element andTag:(STInteractiveSceneElementType)tag;

/**
 *  Creates a new UITextView that has been made draggable and adds it as a subview
 *
 *  @param text   The text that will appear in the textview by default
 *  @param center The point where the textview needs to be centered
 *  @param size   The size desired for the textview.
 *
 */
-(void)createNewDraggableTextViewWithText:(NSString *)text atCenter:(CGPoint)center withSize:(CGSize)size;

/**
 *  Produces a CGRect that defines the frame for a TextView given a specific center.
 *
 *  @param center Desired center for the TextView
 *  @param size Desired size for the TextView
 *
 *  @return A properly configured rectangle that will be the frame for the TextView
 */
+(CGRect) frameForTextViewAtCenter:(CGPoint)center withSize:(CGSize)size;


+(CGSize)textViewSize;




@end
