//
//  STPresentSKSceneViewController.h
//  Storyteller
//
//  Created by Ryan Britt on 6/12/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
@class STInteractiveScene;

@interface STPresentSKSceneViewController : UIViewController
@property (strong, nonatomic) STInteractiveScene *scene;
@end
