//
//  STStoryTests.m
//  Storyteller
//
//  Created by Ryan Britt on 5/26/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STAppDelegate.h"
#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"

@interface STStoryTests : XCTestCase
@property (strong,nonatomic) NSManagedObjectContext *context;
@end

@implementation STStoryTests

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

#pragma mark - STStory Attribute/Class Tests
-(void)testEmptyStory
{
    STStory *temp = [STStory initWithName:@"EmptyTest" inContext:self.context];
    XCTAssert([@"EmptyTest" isEqualToString:temp.name]);
}


-(void)testStoryRetrieve
{
    [STStory initWithName:@"EmptyTest" inContext:self.context];
    
    STStory *temp1 = [STStory findStoryWithName:@"EmptyTest" inContext:self.context];
    XCTAssert([@"EmptyTest" isEqualToString: temp1.name]);
    
    STStory *temp2 = [STStory findStoryWithName:@"asdfksdfksfllsjflj" inContext:self.context];
    XCTAssertNil(temp2);
}

-(void)testAllStoryRetrieve
{
    [STStory initWithName:@"EmptyTest" inContext:self.context];
    [STStory initWithName:@"EmptyTest2" inContext:self.context];
    
    NSArray *tempArray = [STStory findAllStoriesWithinContext:self.context];
    XCTAssertEqual(2, [tempArray count]);
}

#pragma mark - STStory Relationship Tests
-(void)testMediaInAndOutOfStory
{
    XCTFail();
}

-(void)testSceneSingleInAndOutOfStory
{
    //Create Story and check initial scene count
    STStory *testStory = [STStory initWithName:@"Test" inContext:self.context];
    XCTAssertEqual(0, testStory.interactiveSceneList.count);
    
    // Create Scene and add it to the story. Verify that there is one more object in the scene list
    STInteractiveScene *temp = [STInteractiveScene initWithName:@"Temp" inContext:self.context];
    [testStory addInteractiveSceneListObject:temp];
    XCTAssertEqual(1, testStory.interactiveSceneList.count);
    
    // Retrieve the scene. Verify not nil and that name is equal to what we expect it to be.
    STInteractiveScene *temp2 = [testStory.interactiveSceneList member:temp];
    XCTAssertNotNil(temp2);
    XCTAssert([@"Temp" isEqualToString:temp2.name]);
    
    //Verify that the scene links back to the original story
    XCTAssert([temp2.belongingStory.name isEqualToString:@"Test"]);
    
}

-(void)testSceneSetInAndOutOfStory
{
    //Create Story and check initial scene count
    STStory *testStory = [STStory initWithName:@"Test" inContext:self.context];
    XCTAssertEqual(0, testStory.interactiveSceneList.count);
    
    
    //Add scenes, check scene count
    NSSet *newScenes = [NSSet setWithArray:@[[STInteractiveScene initWithName:@"Temp1" inContext:self.context],
                                             [STInteractiveScene initWithName:@"Temp2" inContext:self.context],
                                             [STInteractiveScene initWithName:@"Temp3" inContext:self.context]]];
    
    [testStory addInteractiveSceneList:newScenes];
    XCTAssertEqual(3, testStory.interactiveSceneList.count);
    
    //Cannot determine the order that the items in the set are given to the array, so must test for all possibilities.
    NSArray *tempArray = [testStory.interactiveSceneList allObjects];
    XCTAssert([((STInteractiveScene*)tempArray[0]).name isEqualToString:@"Temp1"] ||
              [((STInteractiveScene*)tempArray[1]).name isEqualToString:@"Temp1"] ||
              [((STInteractiveScene*)tempArray[2]).name isEqualToString:@"Temp1"]);
    
    XCTAssert([((STInteractiveScene*)tempArray[0]).name isEqualToString:@"Temp2"] ||
              [((STInteractiveScene*)tempArray[1]).name isEqualToString:@"Temp2"] ||
              [((STInteractiveScene*)tempArray[2]).name isEqualToString:@"Temp2"]);
    
    XCTAssert([((STInteractiveScene*)tempArray[0]).name isEqualToString:@"Temp3"] ||
              [((STInteractiveScene*)tempArray[1]).name isEqualToString:@"Temp3"] ||
              [((STInteractiveScene*)tempArray[2]).name isEqualToString:@"Temp3"]);
    
    
}


-(void)testSetAndRetrieveStartingScene
{
    //Create Story and check initial scene count
    STStory *testStory = [STStory initWithName:@"Test" inContext:self.context];
    XCTAssertEqual(0, testStory.interactiveSceneList.count);
    
    //Add Starting Scene, retrieve Starting scene
    STInteractiveScene *scene = [STInteractiveScene initWithName:@"starting" inContext:self.context];
    testStory.startingScene = scene;
    
    XCTAssert([@"starting" isEqualToString:testStory.startingScene.name]);
}

@end
