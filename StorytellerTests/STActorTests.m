//
//  STActorTests.m
//  Storyteller
//
//  Created by Ryan Britt on 6/1/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STAppDelegate.h"

#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"
#import "STActorSceneElement+EaseOfUse.h"

@interface STActorTests : XCTestCase
@property (nonatomic, strong) NSManagedObjectContext *context;


@end

@implementation STActorTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.context = ((STAppDelegate *)[[UIApplication sharedApplication]delegate]).coreDataHelper.context;
}

- (void)tearDown
{
    [self.context reset];
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFindSpecificActor
{
    STStory *story1 = [STStory initWithName:@"Story1" inContext:self.context];
    STStory *story2 = [STStory initWithName:@"Story2" inContext:self.context];
    
    STInteractiveScene *story1Scene1 = [STInteractiveScene initWithName:@"Story1Scene1" inContext:self.context];
    STInteractiveScene *story1Scene2 = [STInteractiveScene initWithName:@"Story1Scene2" inContext:self.context];
    STInteractiveScene *story1Scene3 = [STInteractiveScene initWithName:@"Story1Scene3" inContext:self.context];
    STInteractiveScene *story1Scene4 = [STInteractiveScene initWithName:@"Story1Scene4" inContext:self.context];
    
    STInteractiveScene *story2Scene1 = [STInteractiveScene initWithName:@"Story2Scene1" inContext:self.context];
    STInteractiveScene *story2Scene2 = [STInteractiveScene initWithName:@"Story2Scene2" inContext:self.context];
    STInteractiveScene *story2Scene3 = [STInteractiveScene initWithName:@"Story2Scene3" inContext:self.context];
    STInteractiveScene *story2Scene4 = [STInteractiveScene initWithName:@"Story2Scene4" inContext:self.context];
    
    STActorSceneElement *actor1 = [STActorSceneElement initActorWithName:@"actor1"
                                                               withImage:[UIImage imageNamed:@"Actor"]
                                                           withinContext:self.context
                                                              centeredAt:CGPointMake(0, 0)];
    
    STActorSceneElement *actor2 = [STActorSceneElement initActorWithName:@"actor2"
                                                               withImage:[UIImage imageNamed:@"Actor"]
                                                           withinContext:self.context
                                                              centeredAt:CGPointMake(0, 0)];
    
    STActorSceneElement *actor3 = [STActorSceneElement initActorWithName:@"actor3"
                                                               withImage:[UIImage imageNamed:@"Actor"]
                                                           withinContext:self.context
                                                              centeredAt:CGPointMake(0, 0)];
    
    
    

    //Add Actor 1 to scene 1
    [story1 addInteractiveSceneListObject:story1Scene1];
    [story1Scene1 addActorSceneElementListObject:actor1];
    
    //Find Actor1 in scene 1
    STActorSceneElement * foundActor1 = [STActorSceneElement findActorSceneElementWithName:actor1.name
                                                                                   inStory:story1
                                                                                   inScene:story1Scene1
                                                                                 inContext:self.context];
    XCTAssert([foundActor1.name isEqualToString:actor1.name]);
    XCTAssert([foundActor1.belongingScene.name isEqualToString:story1Scene1.name]);
    XCTAssert([foundActor1.belongingScene.belongingStory.name isEqualToString:story1.name]);
    
    //Add actor 1 and 2 to scene 2
    [story1 addInteractiveSceneListObject:story1Scene2];
    [story1Scene2 addActorSceneElementListObject:actor1];
    [story1Scene2 addActorSceneElementListObject:actor2];
    
    //Find Actor 2 in scene 2
    STActorSceneElement *foundActor2 = [STActorSceneElement findActorSceneElementWithName:actor2.name
                                                                                  inStory:story1
                                                                                  inScene:story1Scene2
                                                                                inContext:self.context];
    
    XCTAssert([foundActor2.name isEqualToString:actor2.name]);
    XCTAssert([foundActor2.belongingScene.name isEqualToString:story1Scene2.name]);
    XCTAssert([foundActor2.belongingScene.belongingStory.name isEqualToString:story1.name]);
    
    //Add Actor 2 and 3 into scene 1
    [story1Scene1 addActorSceneElementListObject:actor2];
    [story1Scene1 addActorSceneElementListObject:actor3];
    
    //Find Actor2 in scene 1
    STActorSceneElement *foundActor3 = [STActorSceneElement findActorSceneElementWithName:actor2.name
                                                                                  inStory:story1
                                                                                  inScene:story1Scene1
                                                                                inContext:self.context];
    
    XCTAssert([foundActor3.name isEqualToString:actor2.name]);
    XCTAssert([foundActor3.belongingScene.name isEqualToString:story1Scene1.name]);
    XCTAssert([foundActor3.belongingScene.belongingStory.name isEqualToString:story1.name]);
    
}

@end
