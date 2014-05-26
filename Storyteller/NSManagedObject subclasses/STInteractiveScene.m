//
//  STInteractiveScene.m
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveScene.h"
#import "STActor.h"
#import "STEnvironment.h"
#import "STInteractiveScene.h"
#import "STObject.h"
#import "STStory.h"


@implementation STInteractiveScene

@dynamic actorTagIncr;
@dynamic enviroTagIncr;
@dynamic isOrdered;
@dynamic name;
@dynamic objectTagIncr;
@dynamic actorList;
@dynamic belongingStory;
@dynamic environmentList;
@dynamic nextScene;
@dynamic objectList;
@dynamic previousScene;
@dynamic startingSceneForStory;

- (void)addActorListObject:(STActor *)value
{
    NSMutableSet* tempSet = [NSMutableSet setWithSet:self.actorList];
    [tempSet addObject:value];
    self.actorList = tempSet;
}
@end
