//
//  UIKitEditScene.h
//  Storyteller
//
//  Created by Ryan Britt on 7/8/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIView+DragDrop.h>
#import "STInteractiveSceneElement+EaseOfUse.h"

@class STInteractiveScene;
@class RCDraggableButton;

@interface UIKitEditScene : NSObject <UITextViewDelegate, UIViewDragDropDelegate>


-(id)initWithScene:(STInteractiveScene *)scene inContext:(NSManagedObjectContext *)context andView:(UIView *)view;

-(void)createNewDraggableSceneElementWithSceneElement:(STInteractiveSceneElement *)element andTag:(STInteractiveSceneElementType)tag;
-(void)createNewDraggableTextViewWithText:(NSString *)text atCenter:(CGPoint)center;




@end
