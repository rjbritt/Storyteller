//
//  STInteractiveScene.m
//  Storyteller
//
//  Created by Ryan Britt on 4/8/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveScene.h"
#import "STActor.h"
#import "STEnvironment.h"
#import "STObject.h"
#import "STStory.h"


@implementation STInteractiveScene

@dynamic name;
@dynamic npcTagIncr;
@dynamic tag;
@dynamic pcTagIncr;
@dynamic envTagIncr;
@dynamic actorList;
@dynamic belongingStory;
@dynamic environmentList;
@dynamic objectList;


- (void)addActorListObject:(STActor *)value
{
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.actorList];
    [tempSet addObject:value];
    self.actorList = tempSet;
}

+(STInteractiveScene *)initWithName:(NSString *)name inContext:(NSManagedObjectContext *)context
{
    STInteractiveScene * temp = [NSEntityDescription insertNewObjectForEntityForName:@"STInteractiveScene" inManagedObjectContext:context];
    temp.name = name;
    return temp;
}

-(NSString *)getNextNPCName
{
    NSString *temp = [NSString stringWithFormat:@"Actor_NonPlayableCharacter%i",(int) self.npcTagIncr];
    self.npcTagIncr ++;
    return temp;
}

-(NSString *)getNextPCName
{
    NSString *temp = [NSString stringWithFormat:@"Actor_PlayableCharacter%i",(int) self.npcTagIncr];
    self.pcTagIncr ++;
    return temp;
}

-(NSString *)getNextEnvName
{
    NSString *temp = [NSString stringWithFormat:@"Environmentr%i",(int) self.envTagIncr];
    self.envTagIncr ++;
    return temp;
}

@end
