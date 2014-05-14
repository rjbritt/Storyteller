//
//  STMyScene.m
//  Storyteller
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveSceneSKScene.h"
#import "STAppDelegate.h"
#import "STInteractiveSceneUtilities.h"


//class extension for private properties
@interface STInteractiveSceneSKScene()
@property (strong, nonatomic) NSManagedObjectContext * currentContext;
@property (strong, nonatomic) STInteractiveScene *currentScene;
@end

@implementation STInteractiveSceneSKScene

dispatch_queue_t backgroundQueue;


/**
 * initWithSize:size  andData:interactiveDataSource
 * This is the designated initializer for this interactive scene class. This sets up the  scene and passes the data that will be
 * used for conversion to SKNodes.
 *
 * @param size The size in points to initialize this scene to.
 * @param gameDataSource Any UIViewController class that adheres to STInteractiveSceneDataSource to provide the data needed to initialize this STInteractiveScene
 * @return The initialized scene.
 */

-(id)initWithSize:(CGSize)size andName:(NSString *) name// will need to implement tag for interactive scene
{
    if (self = [super initWithSize:size])
    {
        backgroundQueue = dispatch_queue_create("com.ryanbritt.dispatchqueue", NULL);
        
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        self.currentContext = ((STAppDelegate *)[[UIApplication sharedApplication]delegate]).coreDataHelper.context;
        
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"STInteractiveScene"];
        NSPredicate *nameFilter = [NSPredicate predicateWithFormat:@"name == %@", name];
        [request setPredicate:nameFilter];
        
        self.currentScene = [self.currentContext executeFetchRequest:request error:nil][0];
        
//#if DEBUG
//        NSLog(@"SKScene");
//        for (STActor *temp in self.currentScene.actorList)
//        {
//            NSLog([NSString stringWithFormat:@"Name: %@ Center:%@ Tag:%i \n",temp.name, temp.center, (int)temp.tag]) ;
//        }
//#endif
        
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
    
    NSArray *actors = [self.currentScene.actorList array];
    
    start = [NSDate date];
    for (STActor * currentActor in actors)
    {
        dispatch_async(backgroundQueue,^(void)
        {
            
            SKSpriteNode *actorSprite = [SKSpriteNode spriteNodeWithTexture:
                                         [SKTexture textureWithImage:
                                          [currentActor getUIImageFromData]]];
            actorSprite.name = currentActor.name;
            actorSprite.position =[self convertPointFromView:[currentActor getCenterPoint]];
            if (currentActor.tag == STInteractiveSceneDataTypePlayableCharacter)
            {
                // configure playable characters
                actorSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:actorSprite.frame.size];
                actorSprite.physicsBody.affectedByGravity = true;
                actorSprite.physicsBody.friction = 0.5f;
                actorSprite.physicsBody.restitution = 0.2f;
                actorSprite.physicsBody.linearDamping = 0.5f;
                
            }
            else //if(currentActor.tag == STInteractiveSceneDataTypeNonPlayableCharacter)
            {
                // configure NPC
                actorSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:actorSprite.frame.size];
                actorSprite.physicsBody.affectedByGravity = false;
                actorSprite.physicsBody.friction = 1.0f;
                actorSprite.physicsBody.restitution = 1.0f;
                
                //setting it to not dynamic means it does not react to forces and impulses.
                actorSprite.physicsBody.dynamic = false;
            }
            
            [self addChild:actorSprite];
        
        });
    }
    end = [NSDate date];
    NSLog([NSString stringWithFormat:@"Time taken: %lf", [end timeIntervalSinceDate:start]]);
    
    
    
    //Convert all the environments to SKNodes
    
    NSArray *environment = [self.currentScene.environmentList array];
    


    
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
