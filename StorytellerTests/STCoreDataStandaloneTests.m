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
    self.context = ((STAppDelegate *)[[UIApplication sharedApplication] delegate]).coreDataHelper.context;
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void)testStoryEmpty
{
    STStory *temp = [STStory initWithName:@"EmptyTest" inContext:self.context];
    XCTAssertEqual(@"EmptyTest", temp.name, @"These should be equal.");
//    [self.context reset];
}

-(void)testStoryRetrieve1
{
    STStory *temp = [STStory findStoryWithName:@"EmptyTest" inContext:self.context];
    XCTAssertEqual(@"EmptyTest", temp.name);
    
    STStory *temp2 = [STStory findStoryWithName:@"asdfksdfksfllsjflj" inContext:self.context];
    XCTAssertNil(temp2);
}


@end
