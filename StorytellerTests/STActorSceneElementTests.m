//
//  STActorSceneElementTests.m
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STAppDelegate.h"
#import "STActorSceneElement+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"
#import "STStory+EaseOfUse.h"

@interface STActorSceneElementTests : XCTestCase
@property (strong, nonatomic) NSManagedObjectContext *context;
@end

@implementation STActorSceneElementTests

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

-(void)testFindSpecificActorInSpecificScene
{
    STStory *tempStory1 =  [STStory initWithName:@"Temp1" inContext:self.context];
    STStory *tempStory2 = [STStory initWithName:@"Temp2" inContext:self.context];
    
    STInteractiveScene *tempScene1 = [STInteractiveScene initWithName:@"tempscene1" inContext:self.context];
    STInteractiveScene *tempScene2 = [STInteractiveScene initWithName:@"tempscene2" inContext:self.context];
    
    UIImage *tempImage = [UIImage imageNamed:@"Actor"];
    CGPoint point = CGPointMake(0, 0);
    
    STActorSceneElement *tempActor = [STActorSceneElement initActorWithName:@"TempActor" withImage:tempImage withinContext:self.context centeredAt:point];
    
    [tempStory1 addInteractiveSceneListObject:tempScene1];
    [tempStory2 addInteractiveSceneListObject:tempScene2];
    
    [tempScene1 addActorSceneElementListObject:tempActor];
    
    STActorSceneElement *foundActor = [STActorSceneElement findActorSceneElementWithName:@"TempActor"
                                                                                 inStory:tempStory1
                                                                                 inScene:tempScene1
                                                                               inContext:self.context];
    XCTAssert([foundActor.name isEqualToString:tempActor.name]);

    
    foundActor = [STActorSceneElement findActorSceneElementWithName:@"TempActor"
                                                            inStory:tempStory2
                                                            inScene:tempScene2
                                                          inContext:self.context];
    XCTAssertFalse([foundActor.name isEqualToString:tempActor.name]);
    
    
}

@end
