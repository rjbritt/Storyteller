//
//  STInteractiveScene.h
//  Storyteller
//
//  Created by Ryan Britt on 6/9/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STActorSceneElement, STEnvironmentSceneElement, STMedia, STObjectSceneElement, STStory;

@interface STInteractiveScene : NSManagedObject

@property (nonatomic) int32_t actorTagIncr;
@property (nonatomic) int32_t enviroTagIncr;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int32_t objectTagIncr;
@property (nonatomic, retain) NSOrderedSet *actorSceneElementList;
@property (nonatomic, retain) STStory *belongingStory;
@property (nonatomic, retain) NSOrderedSet *environmentSceneElementList;
@property (nonatomic, retain) NSOrderedSet *objectSceneElementList;
@property (nonatomic, retain) STMedia *sceneMedia;
@end

@interface STInteractiveScene (CoreDataGeneratedAccessors)

- (void)insertObject:(STActorSceneElement *)value inActorSceneElementListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromActorSceneElementListAtIndex:(NSUInteger)idx;
- (void)insertActorSceneElementList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeActorSceneElementListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInActorSceneElementListAtIndex:(NSUInteger)idx withObject:(STActorSceneElement *)value;
- (void)replaceActorSceneElementListAtIndexes:(NSIndexSet *)indexes withActorSceneElementList:(NSArray *)values;
- (void)addActorSceneElementListObject:(STActorSceneElement *)value;
- (void)removeActorSceneElementListObject:(STActorSceneElement *)value;
- (void)addActorSceneElementList:(NSOrderedSet *)values;
- (void)removeActorSceneElementList:(NSOrderedSet *)values;
- (void)insertObject:(STEnvironmentSceneElement *)value inEnvironmentSceneElementListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromEnvironmentSceneElementListAtIndex:(NSUInteger)idx;
- (void)insertEnvironmentSceneElementList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeEnvironmentSceneElementListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInEnvironmentSceneElementListAtIndex:(NSUInteger)idx withObject:(STEnvironmentSceneElement *)value;
- (void)replaceEnvironmentSceneElementListAtIndexes:(NSIndexSet *)indexes withEnvironmentSceneElementList:(NSArray *)values;
- (void)addEnvironmentSceneElementListObject:(STEnvironmentSceneElement *)value;
- (void)removeEnvironmentSceneElementListObject:(STEnvironmentSceneElement *)value;
- (void)addEnvironmentSceneElementList:(NSOrderedSet *)values;
- (void)removeEnvironmentSceneElementList:(NSOrderedSet *)values;
- (void)insertObject:(STObjectSceneElement *)value inObjectSceneElementListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromObjectSceneElementListAtIndex:(NSUInteger)idx;
- (void)insertObjectSceneElementList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeObjectSceneElementListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInObjectSceneElementListAtIndex:(NSUInteger)idx withObject:(STObjectSceneElement *)value;
- (void)replaceObjectSceneElementListAtIndexes:(NSIndexSet *)indexes withObjectSceneElementList:(NSArray *)values;
- (void)addObjectSceneElementListObject:(STObjectSceneElement *)value;
- (void)removeObjectSceneElementListObject:(STObjectSceneElement *)value;
- (void)addObjectSceneElementList:(NSOrderedSet *)values;
- (void)removeObjectSceneElementList:(NSOrderedSet *)values;
@end
