//
//  STInteractiveScene.h
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STActor, STEnvironment, STInteractiveScene, STObject, STStory;

@interface STInteractiveScene : NSManagedObject

@property (nonatomic) int64_t actorTagIncr;
@property (nonatomic) int64_t enviroTagIncr;
@property (nonatomic) BOOL isOrdered;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int64_t objectTagIncr;
@property (nonatomic, retain) NSSet *actorList;
@property (nonatomic, retain) STStory *belongingStory;
@property (nonatomic, retain) NSSet *environmentList;
@property (nonatomic, retain) STInteractiveScene *nextScene;
@property (nonatomic, retain) NSSet *objectList;
@property (nonatomic, retain) STInteractiveScene *previousScene;
@property (nonatomic, retain) STStory *startingSceneForStory;
@end

@interface STInteractiveScene (CoreDataGeneratedAccessors)

- (void)addActorListObject:(STActor *)value;
- (void)removeActorListObject:(STActor *)value;
- (void)addActorList:(NSSet *)values;
- (void)removeActorList:(NSSet *)values;

- (void)addEnvironmentListObject:(STEnvironment *)value;
- (void)removeEnvironmentListObject:(STEnvironment *)value;
- (void)addEnvironmentList:(NSSet *)values;
- (void)removeEnvironmentList:(NSSet *)values;

- (void)addObjectListObject:(STObject *)value;
- (void)removeObjectListObject:(STObject *)value;
- (void)addObjectList:(NSSet *)values;
- (void)removeObjectList:(NSSet *)values;

@end
