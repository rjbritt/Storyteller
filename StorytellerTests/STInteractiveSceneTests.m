//
//  STCoreDataFunctionalityTests.m
//  Storyteller
//
//  Created by Ryan Britt on 5/26/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STAppDelegate.h"
#import "STInteractiveScene+EaseOfUse.h"
#import "STStory+EaseOfUse.h"

@interface STInteractiveSceneTests : XCTestCase
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation STInteractiveSceneTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.context = ((STAppDelegate *)[[UIApplication sharedApplication] delegate]).coreDataHelper.context;
}

- (void)tearDown
{
    [self.context reset];
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark - STInteractiveScene Attribute/Class Tests

-(void)testEmptyScene
{
    STInteractiveScene *scene = [STInteractiveScene initWithName:@"Temp" inContext:self.context];
    XCTAssert([@"Temp" isEqualToString:scene.name]);
}

-(void)testSceneRetrieve
{
    [STInteractiveScene initWithName:@"Temp" inContext:self.context];
    
    //Test for existing scene
    STInteractiveScene *foundScene = [STInteractiveScene findSceneWithName:@"Temp" inContext:self.context];
    XCTAssert([@"Temp" isEqualToString:foundScene.name]);
    
    //Test for nonexistant scene
    STInteractiveScene *foundScene2 = [STInteractiveScene findSceneWithName:@"asdfasdfasf" inContext:self.context];
    XCTAssertNil(foundScene2);
}

-(void)testIncrementors
{
    STInteractiveScene *temp = [STInteractiveScene initWithName:@"Temp" inContext:self.context];
    NSString *actorName = temp.nextActorName;
    NSString *enviroName = temp.nextEnviroName;
    NSString *objectName = temp.nextObjectName;
    
    XCTAssertEqual(1, temp.actorTagIncr);
    XCTAssertEqual(1, temp.enviroTagIncr);
    XCTAssertEqual(1, temp.objectTagIncr);
    
    XCTAssert([@"Actor0" isEqualToString:actorName]);
    XCTAssert([@"Environment0" isEqualToString:enviroName]);
    XCTAssert([@"Object0" isEqualToString:objectName]);
}

#pragma mark - STInteractiveScene Relationship Tests

-(void)testNextAndPreviousScenes
{
    STInteractiveScene *firstScene = [STInteractiveScene initWithName:@"One" inContext:self.context];
    STInteractiveScene *secondScene = [STInteractiveScene initWithName:@"Two" inContext:self.context];
    STInteractiveScene *thirdScene = [STInteractiveScene initWithName:@"Three" inContext:self.context];
    
    firstScene.previousScene = nil;
    firstScene.nextScene = secondScene;
    
    secondScene.previousScene = firstScene;
    secondScene.nextScene = thirdScene;
    
    thirdScene.previousScene = secondScene;
    thirdScene.nextScene = nil;
    
    XCTAssert([@"Three" isEqualToString:firstScene.nextScene.nextScene.name]);
    XCTAssert([@"One" isEqualToString:thirdScene.previousScene.previousScene.name]);
    XCTAssert([@"One" isEqualToString:firstScene.nextScene.previousScene.name]);
    XCTAssert([@"Two" isEqualToString:firstScene.nextScene.name]);
    XCTAssert([@"Three" isEqualToString:thirdScene.previousScene.previousScene.nextScene.nextScene.name]);
    
}

-(void)testAddDeleteAndRetrieveActor
{
    XCTFail();
}

-(void)testAddDeleteAndRetrieveActorSet
{
    XCTFail();
}

-(void)testAddDeleteAndRetrieveEnvironment
{
    XCTFail();
}

-(void)testAddDeleteAndRetrieveEnvironmentSet
{
    XCTFail();
}

-(void)testAddDeleteandRetrieveObject
{
    XCTFail();
}

-(void)testAddDeleteAndRetrieveObjectSet
{
    XCTFail();
}
-(void)testSingleInstanceSceneElementMultipleScenes
{
    XCTFail();
}



@end
