//
//  STMyScene.m
//  Storyteller
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveScene.h"

//class extension for private properties
@interface STInteractiveScene()
@property id<STInteractiveSceneDataSource> dataSourceDelegate;

@end
@implementation STInteractiveScene

/**
 * initWithSize:size  andData:interactiveDataSource
 * This is the designated initializer for this interactive scene class. This sets up the  scene and passes the data that will be
 * used for conversion to SKNodes.
 *
 * @param size The size in points to initialize this scene to.
 * @param gameDataSource Any UIViewController class that adheres to STInteractiveSceneDataSource to provide the data needed to initialize this STInteractiveScene
 * @return The initialized scene.
 */

-(id)initWithSize:(CGSize)size andData:(id<STInteractiveSceneDataSource>)interactiveDataSource
{
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        self.dataSourceDelegate = interactiveDataSource;
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
    }
    return self;
}

/**
 * didMoveToView:view
 * This is a SKScene lifecycle method that is called as soon as the
 * SkScene is presented
 *
 * configureDataSourceToNodes must be called here because the coordinate conversion has to
 * be done after the view has been presented.
 *
 * @param view SKview that will be presented, called during the SKScene lifecycle.
 *
 */

-(void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    [self configureDataSourceToNodes];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

/**
 * configureDataSourceToNodes
 * This method takes the source data and creates SKNodes or subclasses based on the information from those nodes.
 *
 */

-(void)configureDataSourceToNodes
{
    //Convert the Actor to SKNodes
    for (UIButton *currentButton in [self.dataSourceDelegate actors] )
    {
        
        
        SKSpriteNode *actorSprite = [SKSpriteNode spriteNodeWithTexture:
                                     [SKTexture textureWithImage:
                                      [currentButton imageForState:UIControlStateNormal]]];
        
        actorSprite.name = currentButton.titleLabel.text;
        actorSprite.position =[self convertPointFromView:currentButton.center];
        
        
        
        //Not needed at the moment but this is how it can be used.
        if (currentButton.tag == STInteractiveSceneDataTypePlayableCharacter)
        {
          // configure playable characters
            actorSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:actorSprite.frame.size];
            actorSprite.physicsBody.affectedByGravity = true;
            actorSprite.physicsBody.friction = 0.5f;
            actorSprite.physicsBody.restitution = 1.0f;
            
        }
        else if(currentButton.tag == STInteractiveSceneDataTypeNonPlayableCharacter)
        {
        // configure NPC
            actorSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:actorSprite.frame.size];
            actorSprite.physicsBody.affectedByGravity = false;
            actorSprite.physicsBody.friction = 1.0f;
            actorSprite.physicsBody.restitution = 1.0f;
        }
        
        [self addChild:actorSprite];
    }
    
    //Convert all the environments to SKNodes
    for (UIButton *currentButton in [self.dataSourceDelegate environment])
    {
        
    }
    
//    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//    myLabel.text = @"TEST:";
//    myLabel.fontSize = 12;
//    myLabel.position = CGPointMake(0, 0);
//    [self addChild:myLabel];
    
    
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
