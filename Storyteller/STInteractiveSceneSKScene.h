//
//  STMyScene.h
//  Storyteller
//

//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class STInteractiveScene;

@interface STInteractiveSceneSKScene : SKScene
@property (strong, nonatomic, readonly) STInteractiveScene *currentScene;
-(id)initWithSize:(CGSize)size andScene:(STInteractiveScene *) scene;

@end
