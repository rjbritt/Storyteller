//
//  UIKitEditScene.m
//  Storyteller
//
//  Created by Ryan Britt on 7/8/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "UIKitEditScene.h"
#import "STInteractiveSceneElement+EaseOfUse.h"

#import "STActorSceneElement+EaseOfUse.h"
#import "STEnvironmentSceneElement+EaseOfUse.h"
#import "STObjectSceneElement+EaseOfUse.h"

#import "STInteractiveScene+EaseOfUse.h"
#import "STTextMedia+EaseOfUse.h"
#import "STMedia+EaseOfUse.h"

#import <UIAlertView+Blocks.h>
#import <RCDraggableButton.h>

@interface UIKitEditScene()

@property (strong, nonatomic) STInteractiveScene *currentScene;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) STTextMedia *editingTextMedia;
@property (weak, nonatomic) UITextView *currentEditingTextView;
@end

@implementation UIKitEditScene

#pragma mark - Initialization


-(id)initWithScene:(STInteractiveScene *)scene inContext:(NSManagedObjectContext *)context andView:(UIView *)view
{
    self = [super init];
    
    self.currentScene = scene;
    self.context = context;
    self.view = view;
    
    [self loadUIKitSceneFromCurrentSTInteractiveScene];
    
    return self;
}

/**
 * loadUIKitSceneFromCurrentSTInteractiveScene
 *
 * Does the heavy lifting of converting the saved STInteractiveScene into a UIKit scene.
 * Converts the actors first, then the environment, and then the objects.
 *
 */
-(void)loadUIKitSceneFromCurrentSTInteractiveScene
{
    [self currentSceneStatusAtLocation:@"Load UIKit from STInteractive Scene"];
    
    NSArray *actorsInCurrentScene = [self.currentScene.actorSceneElementList array];
    NSArray *environmentsInCurrentScene = [self.currentScene.environmentSceneElementList array];
    NSArray *objectsInCurrentScene = [self.currentScene.objectSceneElementList array];
    
    NSArray *mediaInCurrentScene = [self.currentScene.sceneMedia allObjects];
    
    NSArray *allInteractiveElements = [[actorsInCurrentScene arrayByAddingObjectsFromArray:environmentsInCurrentScene]arrayByAddingObjectsFromArray:objectsInCurrentScene];
    
    //Create a new draggable button representing each of the scene elements
    for (STInteractiveSceneElement *element in allInteractiveElements)
    {
        STInteractiveSceneElementType elementType;
        
        if([element isMemberOfClass:[STActorSceneElement class]])
        {
            elementType = STInteractiveSceneElementTypeActor;
        }
        else if([element isMemberOfClass:[STEnvironmentSceneElement class]])
        {
            elementType = STInteractiveSceneElementTypeEnvironment;
        }
        else
        {
            elementType = STInteractiveSceneElementTypeObject;
        }
        
        [self createNewDraggableSceneElementWithSceneElement:element andTag:elementType];
    }
    
    for (STMedia *media in mediaInCurrentScene)
    {
        if([media isMemberOfClass:[STTextMedia class]])
        {
            STTextMedia *textMedia = (STTextMedia *)media;
            [self createNewDraggableTextViewWithText:textMedia.text atCenter:[textMedia centerPointCGPoint]];
        }
    }
    
}



#pragma mark - View Methods
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
-(void)createNewDraggableSceneElementWithSceneElement:(STInteractiveSceneElement *)element andTag:(STInteractiveSceneElementType)tag
{
    [self currentSceneStatusAtLocation:@"CreateNewDraggableButton"];
    
    //Create RCDraggableButton with aforementioned information
    RCDraggableButton *temp = [[RCDraggableButton alloc] initWithFrame: [self frameCGRectFromCenter:element.centerPointCGPoint AndSize:element.getUIImageFromData.size]];
    [temp setImage:element.getUIImageFromData forState:UIControlStateNormal];
    [temp setTitle:element.name forState:UIControlStateNormal];
    temp.tag = tag;
    
    //Setup the Button Functions
    temp.dragEndedBlock = //This is the code block that is called at the end of a drag of the RCDraggableButton.
    ^(RCDraggableButton * button)
    {
        [self updateSTInteractiveSceneElementForButton:button];
    };
    
    //called on double tap. This is to delete an element.
    temp.doubleTapBlock = ^(RCDraggableButton * button)
    {
       [UIAlertView showWithTitle:@"Delete Element?"
                          message:@"Are you sure you want to delete this element?"
                cancelButtonTitle:@"No"
                otherButtonTitles:@[@"Yes"]
                         tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
                             if (buttonIndex == alertView.cancelButtonIndex)
                             {/*do nothing*/}
                             else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"])
                             {
                                 STInteractiveSceneElement *element =
                                 [STInteractiveSceneElement findSceneElementOfType:button.tag
                                                                          withName:button.currentTitle
                                                                           inStory:self.currentScene.belongingStory
                                                                           inScene:self.currentScene
                                                                         inContext:self.context];
                                 
                                 switch (button.tag)
                                 {
                                     case STInteractiveSceneElementTypeActor:
                                         [self.currentScene removeActorSceneElementListObject:(STActorSceneElement *)element];
                                         break;
                                     case STInteractiveSceneElementTypeEnvironment:
                                         [self.currentScene removeEnvironmentSceneElementListObject:(STEnvironmentSceneElement *)element];
                                         break;
                                     case STInteractiveSceneElementTypeObject:
                                         [self.currentScene removeObjectSceneElementListObject:(STObjectSceneElement *)element];
                                         break;
                                         
                                     default:
                                         break;
                                 }
                                 
                                 [button removeFromSuperview];
                                 
                             }
                         }];
    };

    //Return view to be added as subview
    [self.view addSubview:temp];

}

/**
 *  Creates a new UITextView that has been made draggable and adds it as a subview
 *
 *  @param text   The text that will appear in the textview by default
 *  @param center The point where the textview needs to be centered
 *
 */
-(void)createNewDraggableTextViewWithText:(NSString *)text atCenter:(CGPoint)center
{
    CGRect frame = [STTextMedia genericRectForTextFieldAtCenter:center];
    
    UITextView *tempTextView = [[UITextView alloc]initWithFrame:frame];
    [tempTextView setFont:[UIFont systemFontOfSize:20]];
    tempTextView.text = text;
    tempTextView.opaque =  NO;
    tempTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    tempTextView.tag = STTextMediaType;
    tempTextView.delegate = self;
    
    
    //make a view draggable
    [tempTextView makeDraggableWithDropViews:@[self.view] delegate:self];
    [tempTextView setDragMode:UIViewDragDropModeNormal];

    UIView *accessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    accessoryView.backgroundColor = [UIColor redColor];
    UIButton *tempButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [tempButton addTarget:self action:@selector(deleteTextView) forControlEvents:UIControlEventTouchUpInside];
    [tempButton setTitle:@"Delete" forState:UIControlStateNormal];
    
    [accessoryView addSubview:tempButton];
    tempTextView.inputAccessoryView = accessoryView;
    [self.view addSubview:tempTextView];
}

#pragma mark - TextView Delegate And Modification Methods

/**
 *  TextView Delegate method used to signify that a textView has begun editing. This
 *  is used to identify the textview that is currently being edited as its instance of STTextMedia
 *
 *  @param textView The textView that is being edited.
 */
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.editingTextMedia = [STTextMedia findTextMediaWithText:textView.text
                                                       inScene:self.currentScene
                                                      andStory:self.currentScene.belongingStory
                                                     inContext:self.context];
    self.currentEditingTextView = textView;
    if([textView.text isEqualToString: @"Insert Text Here."])
    {
        textView.text = @"";
    }

}

/**
 *  TextView Delegate method used to signify that a textView has ended editing. This
 *  is used to set the appropriate STTextMedia's current text as to keep it in line with
 *  TextView for proper loading.
 *
 *  @param textView The textView that has finished editing.
 */
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@""])
    {
        textView.text = @"Insert Text Here.";
    }
    self.editingTextMedia.text = textView.text;
}

-(void)deleteTextView
{
    [self.currentScene removeSceneMediaObject:self.editingTextMedia];
    [self.currentEditingTextView removeFromSuperview];
}

#pragma mark - Scene Update from UIKit


/**
 *  This is a generic method that should be able to update any location of a media item
 *  within the scene. The first iteration is only for STTextMedia.
 *
 *  @param sender Whatever media element that needs to be updated.
 */
-(void)updateMediaElementLocationForSender:(id)sender
{
    //update STTextMedia Location;
    if ([sender isMemberOfClass:[UITextView class]])
    {
        UITextView *textView = (UITextView *)sender;
        STTextMedia *media = [STTextMedia findTextMediaWithText:textView.text
                                                        inScene:self.currentScene
                                                       andStory:self.currentScene.belongingStory
                                                      inContext:self.context];
        
        [media setCenterPoint:textView.center];
    }
}


/**
 *  This method is called on finished dragging from an RCDraggableButton for a STInteractiveSceneElement.
 *
 *  @param button The button that sent this message.
 */
-(void)updateSTInteractiveSceneElementForButton:(UIButton *)button
{
    [self currentSceneStatusAtLocation:@"Update Button"];
    
    //The button tag must be analyzed to verify the type of element that we are accessing. An Actor could
    //theoretically have the same name as an Environment. This must be understood so that the appropriate STInteractiveSceneElement
    //can be found.
    switch (button.tag)
    {
        case STInteractiveSceneElementTypeActor:
        {
            STActorSceneElement *temp = (STActorSceneElement *)
            [STInteractiveSceneElement findSceneElementOfType:STInteractiveSceneElementTypeActor
                                                     withName:button.titleLabel.text
                                                      inStory:self.currentScene.belongingStory
                                                      inScene:self.currentScene
                                                    inContext:self.context];
            
            //If there was a returned ActorSceneElement, otherwise, there was an error.
            if(temp)
            {
                [temp setCenterPoint:button.center];
            }
        }
            break;
            
        case STInteractiveSceneElementTypeEnvironment:
        {
            STEnvironmentSceneElement *temp = (STEnvironmentSceneElement *)
            [STInteractiveSceneElement findSceneElementOfType:STInteractiveSceneElementTypeEnvironment
                                                     withName:button.titleLabel.text
                                                      inStory:self.currentScene.belongingStory
                                                      inScene:self.currentScene
                                                    inContext:self.context];
            
            //If there was a returned Environment, otherwise, there was an error.
            if(temp)
            {
                [temp setCenterPoint:button.center];
            }
        }
            break;
            
        case STInteractiveSceneElementTypeObject:
        {
            STObjectSceneElement *temp = (STObjectSceneElement *)
            [STInteractiveSceneElement findSceneElementOfType:STInteractiveSceneElementTypeObject
                                                     withName:button.titleLabel.text
                                                      inStory:self.currentScene.belongingStory
                                                      inScene:self.currentScene
                                                    inContext:self.context];
            
            //If there was a returned Object, otherwise, there was an error.
            if(temp)
            {
                [temp setCenterPoint:button.center];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - Utility Methods

/**
 *  This method returns a CGRect in UIView coordinates that can be understood as the frame of an image given its
 *  center and size
 *
 *  @param center The centerpoint of the rectangle.
 *  @param size   The size of the rectangle.
 *
 *  @return A configured Frame Rectangle
 */
-(CGRect)frameCGRectFromCenter:(CGPoint)center AndSize:(CGSize)size
{
    CGRect frame = CGRectMake(center.x-((size.width)/2),center.y-((size.height)/2), size.width, size.height);
    
    return frame;
}

/**
 *  Easy method of calculating a bounding rectangle for variable length text.
 *  Obtained from http://stackoverflow.com/questions/9181368/ios-dynamic-sizing-labels/18750292#18750292
 *
 *  @param text    The text for which a user wants the bounding rectangle.
 *  @param font    The font the text will use.
 *  @param maxSize The maximum size that the rectangle can be.
 *
 *  @return returns An appropriate bounding rectangle for the particular text.
 */
-(CGRect)rectForText:(NSString *)text
           usingFont:(UIFont *)font
       boundedBySize:(CGSize)maxSize
{
    NSAttributedString *attrString =
    [[NSAttributedString alloc] initWithString:text
                                    attributes:@{ NSFontAttributeName:font}];
    
    return [attrString boundingRectWithSize:maxSize
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                    context:nil];
}

/**
 *  Debug method. Tells current state of the scene at a particular location within the scene.
 *
 *  @param location The string that represents the location.
 */
-(void)currentSceneStatusAtLocation:(NSString *)location
{
    NSLog(@"Current Scene: %@ , Current Actor Count: %i, Location: %@", self.currentScene.name, self.currentScene.actorSceneElementList.count, location);
}

#pragma mark - UIView + DragDrop Delegate Methods
- (void) view:(UIView *)view wasDroppedOnDropView:(UIView *)drop
{
    if ([view isMemberOfClass:[UITextView class]])
    {
        [self updateMediaElementLocationForSender:view];
    }
}

- (BOOL) viewShouldReturnToStartingPosition:(UIView*)view
{
    return NO;
}

- (void) draggingDidBeginForView:(UIView*)view
{
    
}
- (void) draggingDidEndWithoutDropForView:(UIView*)view
{
    if ([view isMemberOfClass:[UITextView class]])
    {
        [self updateMediaElementLocationForSender:view];
    }
}

- (void) view:(UIView *)view didHoverOverDropView:(UIView *)dropView
{
    
}
- (void) view:(UIView *)view didUnhoverOverDropView:(UIView *)dropView
{
    
}

#pragma mark - Alertview Delegate Methods

/**
 *  This delegate method handles all the alertview button clicks within this view controller
 *
 *  @param alert       The particular alert that triggered this delegate method.
 *  @param buttonIndex The button index that was tapped
 */
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //There's probably a neater way to do this than hard coding these names
    
    if([alert.title isEqualToString:@""])
    {
    }

}




@end
