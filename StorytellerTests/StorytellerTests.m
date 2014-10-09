//
//  StorytellerTests.m
//  StorytellerTests
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STAppDelegate.h"

#import "STInteractiveSceneElement+EaseOfUse.h"


@interface StorytellerTests : XCTestCase
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation StorytellerTests

- (void)setUp
{
    [super setUp];
    self.context = [CoreData sharedInstance].context;
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [self.context reset];
    [super tearDown];
}

-(void)testRetrieveAllSceneElements
{
    [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeCharacter
                                                 withName:@"name 1"
                                                withImage:[UIImage imageNamed:@"Actor"]
                                            withinContext:self.context centeredAt:CGPointMake(0, 0)];
    
    [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeEnvironment
                                                 withName:@"name 1"
                                                withImage:[UIImage imageNamed:@"Environment"]
                                            withinContext:self.context centeredAt:CGPointMake(0, 0)];
    
    [STInteractiveSceneElement initializeSceneElementType:STInteractiveSceneElementTypeObject
                                                 withName:@"name 1"
                                                withImage:[UIImage imageNamed:@"NPC"]
                                            withinContext:self.context centeredAt:CGPointMake(0, 0)];
    
//    [STInteractiveSceneElement find]
}

@end
