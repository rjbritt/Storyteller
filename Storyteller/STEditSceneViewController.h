//
//  STViewController.h
//  Storyteller
//

//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class STInteractiveScene;

@interface STEditSceneViewController : UIViewController

@property (strong, nonatomic) STInteractiveScene *currentScene;
@end
