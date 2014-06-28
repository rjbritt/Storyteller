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

@interface STEditSceneViewController : UIViewController<UIViewDragDropDelegate, UITextViewDelegate>

@property (strong, nonatomic) STInteractiveScene *currentScene;

- (void)addActorElementWithImage:(UIImage *)image;
@end
