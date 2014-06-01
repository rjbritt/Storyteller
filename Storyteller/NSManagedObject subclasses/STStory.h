//
//  STStory.h
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STInteractiveScene, STMedia;

@interface STStory : NSManagedObject

@property (nonatomic) int32_t editingSceneIndex;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int32_t startingSceneIndex;
@property (nonatomic) BOOL isOrdered;
@property (nonatomic, retain) NSOrderedSet *interactiveSceneList;
@property (nonatomic, retain) STMedia *storyMedia;
@end

@interface STStory (CoreDataGeneratedAccessors)

- (void)insertObject:(STInteractiveScene *)value inInteractiveSceneListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromInteractiveSceneListAtIndex:(NSUInteger)idx;
- (void)insertInteractiveSceneList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeInteractiveSceneListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInInteractiveSceneListAtIndex:(NSUInteger)idx withObject:(STInteractiveScene *)value;
- (void)replaceInteractiveSceneListAtIndexes:(NSIndexSet *)indexes withInteractiveSceneList:(NSArray *)values;
- (void)addInteractiveSceneListObject:(STInteractiveScene *)value;
- (void)removeInteractiveSceneListObject:(STInteractiveScene *)value;
- (void)addInteractiveSceneList:(NSOrderedSet *)values;
- (void)removeInteractiveSceneList:(NSOrderedSet *)values;
@end
