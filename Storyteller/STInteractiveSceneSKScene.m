//
//  STMyScene.m
//  Storyteller
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveSceneSKScene.h"
#import "STAppDelegate.h"

#import "STActorSceneElement+EaseOfUse.h"
#import "STEnvironmentSceneElement.h"
#import "STObjectSceneElement.h"

#import "STInteractiveScene+EaseOfUse.h"
#import "STInteractiveSceneElement+EaseOfUse.h"
#import "STMedia+EaseOfUse.h"
#import "STTextMedia+EaseOfUse.h"


//class extension for private properties
@interface STInteractiveSceneSKScene()
@property (strong, nonatomic, readwrite) STInteractiveScene *currentScene;
@property (strong, nonatomic) NSManagedObjectContext * currentContext;
@end

@implementation STInteractiveSceneSKScene

dispatch_queue_t backgroundQueue;


/**
 * initWithSize:  andScene:
 * This is the designated initializer for this interactive scene class. This sets up the  scene and passes the scene that will be
 * used for conversion to SKNodes.
 *
 * @param size The size in points to initialize this scene to.
 * @param scene The STInteractiveScene that needs to be shown.
 * @return The initialized scene.
 */

-(id)initWithSize:(CGSize)size andScene:(STInteractiveScene *) scene
{
    if (self = [super initWithSize:size])
    {
        backgroundQueue = dispatch_queue_create("com.ryanbritt.dispatchqueue", NULL);
        
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        self.currentContext = ((STAppDelegate *)[[UIApplication sharedApplication]delegate]).coreDataHelper.context;
        
        self.currentScene = scene;
    }
    return self;
}

/** *
 * didMoveToView:view
 * This is a SKScene lifecycle method that is called as soon as the
 * SkScene is presented
 *
 * configureDataSourceToNodes must be called here because the coordinate conversion has to
 * be done after the view has been presented.
 *
 * @param view SKview that will be presented, called during the SKScene lifecycle.
 * //
 */

-(void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    [self configureDataSourceToNodes];
    
    //Configure Media
    NSArray *sceneMedia = [self.currentScene.sceneMedia allObjects];
    for (STMedia *media in sceneMedia)
    {
        if([media isMemberOfClass:[STTextMedia class]])
           {
               STTextMedia *textMedia = (STTextMedia *)media;
               UITextView *tempTextView = [[UITextView alloc]initWithFrame:
                                           [STTextMedia genericRectForTextFieldAtCenter:textMedia.centerPointCGPoint]];
               
               tempTextView.text = textMedia.text;
               tempTextView.tag = STTextMediaType;
               tempTextView.font = [UIFont systemFontOfSize:textMedia.fontSize];
               tempTextView.backgroundColor = [UIColor clearColor];
               tempTextView.userInteractionEnabled =  NO;
               [view.superview addSubview:tempTextView];
               
           }
    }
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
    NSDate *start;
    NSDate *end;
    
    NSArray *actors = [self.currentScene.actorSceneElementList array];
    NSArray *environment = [self.currentScene.environmentSceneElementList array];
    NSArray *objects = [self.currentScene.objectSceneElementList array];
    
    NSArray *combinedArray = [[actors arrayByAddingObjectsFromArray:environment]arrayByAddingObjectsFromArray:objects];
    
    start = [NSDate date];
    for (STInteractiveSceneElement *element in combinedArray)
    {
//        dispatch_async(backgroundQueue, ^(void)
//        {
            if([element isMemberOfClass:[STActorSceneElement class]])
            {
                SKSpriteNode *actorSprite = [self actorSceneElementToSpriteNode:(STActorSceneElement*)element];
                [self addChild:actorSprite];
            }
            else if([element isMemberOfClass:[STEnvironmentSceneElement class]])
            {
                SKSpriteNode *enviroSprite = [self environmentSceneElementToSpriteNode:(STEnvironmentSceneElement*)element];
                [self addChild:enviroSprite];
            }
            else
            {
                SKSpriteNode *objectSprite = [self objectSceneElementToSpriteNode:(STObjectSceneElement *)element];
                [self addChild:objectSprite];
            }
//        });
    }
    end = [NSDate date];
    NSLog([NSString stringWithFormat:@"Time taken: %lf", [end timeIntervalSinceDate:start]]);
    

}

-(SKSpriteNode *) actorSceneElementToSpriteNode:(STActorSceneElement *)actor
{
    SKSpriteNode *actorSprite = [SKSpriteNode spriteNodeWithTexture:
                                 [SKTexture textureWithImage:
                                  [actor getUIImageFromData]]];
    actorSprite.name = actor.name;
    actorSprite.position =[self convertPointFromView:[actor centerPointCGPoint]];
//    
//    // configure Actor
//    actorSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:actorSprite.frame.size];
//    actorSprite.physicsBody.affectedByGravity = true;
//    actorSprite.physicsBody.friction = 0.5f;
//    actorSprite.physicsBody.restitution = 0.2f;
//    actorSprite.physicsBody.linearDamping = 0.5f;
    
    return actorSprite;
    
}

-(SKSpriteNode *) environmentSceneElementToSpriteNode:(STEnvironmentSceneElement *)enviro
{
    SKSpriteNode *enviroSprite = [SKSpriteNode spriteNodeWithTexture:
                                  [SKTexture textureWithImage:[enviro getUIImageFromData]]];
    
    enviroSprite.name = enviro.name;
    enviroSprite.position =[self convertPointFromView:[enviro centerPointCGPoint]];
//    
//    // configure Environment
//    enviroSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:enviroSprite.frame.size];
//    enviroSprite.physicsBody.affectedByGravity = false;
//    enviroSprite.physicsBody.friction = 1.0f;
//    enviroSprite.physicsBody.restitution = 1.0f;
//    
//    //setting it to not dynamic means it does not react to forces and impulses.
//    enviroSprite.physicsBody.dynamic = false;
    
    return enviroSprite;
}

-(SKSpriteNode *) objectSceneElementToSpriteNode:(STObjectSceneElement *)object
{
    SKSpriteNode *objectSprite = [SKSpriteNode spriteNodeWithTexture:
                                  [SKTexture textureWithImage:[object getUIImageFromData]]];
    
    objectSprite.name = object.name;
    objectSprite.position =[self convertPointFromView:[object centerPointCGPoint]];
//    
//    // configure Object
//    objectSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:objectSprite.frame.size];
//    objectSprite.physicsBody.affectedByGravity = false;
//    objectSprite.physicsBody.friction = 1.0f;
//    objectSprite.physicsBody.restitution = 1.0f;
//    
//    //setting it to not dynamic means it does not react to forces and impulses.
//    objectSprite.physicsBody.dynamic = false;
    
    return objectSprite;
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
