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

//These tests are designed to be ran with an empty persistent store

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
    
    NSArray *tempArray = [STStory findAllStoriesAscendinglyWithinContext:self.context];
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
    STInteractiveScene *temp2 = [testStory.interactiveSceneList lastObject];
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
    NSOrderedSet *newScenes = [NSOrderedSet orderedSetWithArray:@[[STInteractiveScene initWithName:@"Temp1" inContext:self.context],
                                             [STInteractiveScene initWithName:@"Temp2" inContext:self.context],
                                             [STInteractiveScene initWithName:@"Temp3" inContext:self.context]]];
    
    [testStory addInteractiveSceneList:newScenes];
    XCTAssertEqual(3, testStory.interactiveSceneList.count);
    
    NSArray *tempArray = [testStory.interactiveSceneList array];
    XCTAssert([((STInteractiveScene*)tempArray[0]).name isEqualToString:@"Temp1"]);
    XCTAssert([((STInteractiveScene*)tempArray[1]).name isEqualToString:@"Temp2"]);
    XCTAssert([((STInteractiveScene*)tempArray[2]).name isEqualToString:@"Temp3"]);
    
    
}


-(void)testSetAndRetrieveStartingScene
{
    //Create Story and check initial scene count
    STStory *testStory = [STStory initWithName:@"Test" inContext:self.context];
    XCTAssertEqual(0, testStory.interactiveSceneList.count);
    
    //Add Starting Scene, set Starting scene
    STInteractiveScene *scene = [STInteractiveScene initWithName:@"starting" inContext:self.context];
    [testStory setNewSceneToStartingScene:scene];
    
    XCTAssert([@"starting" isEqualToString:[testStory stInteractiveStartingScene].name]);
}

-(void)testAddingSceneToList
{
    //Create Story and check initial scene count
    STStory *testStory = [STStory initWithName:@"Test" inContext:self.context];
    XCTAssertEqual(0, testStory.interactiveSceneList.count);
    
    //Add Starting Scene, retrieve Starting scene
    STInteractiveScene *scene = [STInteractiveScene initWithName:@"starting" inContext:self.context];

    //adds the scene to the list as well as sets it as the starting scene.
    [testStory setNewSceneToStartingScene:scene];
    
    XCTAssertEqual(1, testStory.interactiveSceneList.count);
    XCTAssert([@"starting" isEqualToString:(testStory.stInteractiveStartingScene).name]);
    XCTAssertEqual(0, testStory.startingSceneIndex);
    
}

@end
