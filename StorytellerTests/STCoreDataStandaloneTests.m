//
//  STStoryTest.m
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STAppDelegate.h"
#import "STStory.h"

@interface STCoreDataStandaloneTests : XCTestCase
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation STCoreDataStandaloneTests

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


-(void)testStoryEmpty
{
    STStory *temp = [STStory initWithName:@"EmptyTest" inContext:self.context];
    XCTAssertEqual(@"EmptyTest", temp.name, @"These should be equal.");
}

-(void)testStoryRetrieve
{
    [STStory initWithName:@"EmptyTest" inContext:self.context];
    
    STStory *temp1 = [STStory findStoryWithName:@"EmptyTest" inContext:self.context];
    XCTAssertEqual(@"EmptyTest", temp1.name);
    
    STStory *temp2 = [STStory findStoryWithName:@"asdfksdfksfllsjflj" inContext:self.context];
    XCTAssertNil(temp2);
}

-(void)testAllStoryRetrieve
{
    self.context = ((STAppDelegate *)[[UIApplication sharedApplication] delegate]).coreDataHelper.context;

   [STStory initWithName:@"EmptyTest" inContext:self.context];
   [STStory initWithName:@"EmptyTest2" inContext:self.context];
    
    NSArray *tempArray = [STStory findAllStoriesWithinContext:self.context];
    XCTAssertEqual(2, [tempArray count]);
    

}


@end
