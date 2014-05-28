//
//  STInteractiveScene.h
//  Storyteller
//
//  Created by Ryan Britt on 5/27/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STActor, STEnvironment, STInteractiveScene, STObject, STStory;

@interface STInteractiveScene : NSManagedObject

@property (nonatomic) int32_t actorTagIncr;
@property (nonatomic) int32_t enviroTagIncr;
@property (nonatomic) BOOL isOrdered;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int32_t objectTagIncr;
@property (nonatomic, retain) NSOrderedSet *actorList;
@property (nonatomic, retain) STStory *belongingStory;
@property (nonatomic, retain) NSOrderedSet *environmentList;
@property (nonatomic, retain) STInteractiveScene *nextScene;
@property (nonatomic, retain) NSOrderedSet *objectList;
@property (nonatomic, retain) STInteractiveScene *previousScene;
@property (nonatomic, retain) STStory *startingSceneForStory;
@end

@interface STInteractiveScene (CoreDataGeneratedAccessors)

- (void)insertObject:(STActor *)value inActorListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromActorListAtIndex:(NSUInteger)idx;
- (void)insertActorList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeActorListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInActorListAtIndex:(NSUInteger)idx withObject:(STActor *)value;
- (void)replaceActorListAtIndexes:(NSIndexSet *)indexes withActorList:(NSArray *)values;
- (void)addActorListObject:(STActor *)value;
- (void)removeActorListObject:(STActor *)value;
- (void)addActorList:(NSOrderedSet *)values;
- (void)removeActorList:(NSOrderedSet *)values;
- (void)insertObject:(STEnvironment *)value inEnvironmentListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromEnvironmentListAtIndex:(NSUInteger)idx;
- (void)insertEnvironmentList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeEnvironmentListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInEnvironmentListAtIndex:(NSUInteger)idx withObject:(STEnvironment *)value;
- (void)replaceEnvironmentListAtIndexes:(NSIndexSet *)indexes withEnvironmentList:(NSArray *)values;
- (void)addEnvironmentListObject:(STEnvironment *)value;
- (void)removeEnvironmentListObject:(STEnvironment *)value;
- (void)addEnvironmentList:(NSOrderedSet *)values;
- (void)removeEnvironmentList:(NSOrderedSet *)values;
- (void)insertObject:(STObject *)value inObjectListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromObjectListAtIndex:(NSUInteger)idx;
- (void)insertObjectList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeObjectListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInObjectListAtIndex:(NSUInteger)idx withObject:(STObject *)value;
- (void)replaceObjectListAtIndexes:(NSIndexSet *)indexes withObjectList:(NSArray *)values;
- (void)addObjectListObject:(STObject *)value;
- (void)removeObjectListObject:(STObject *)value;
- (void)addObjectList:(NSOrderedSet *)values;
- (void)removeObjectList:(NSOrderedSet *)values;
@end
