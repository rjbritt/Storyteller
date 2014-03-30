//
//  STMyScene.h
//  Storyteller
//

//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "STInteractiveSceneDataSource.h"

@interface STInteractiveScene : SKScene

-(id)initWithSize:(CGSize)size andData:(id<STInteractiveSceneDataSource>) interactiveDataSource;

@end
