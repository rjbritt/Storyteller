//
//  STStory.h
//  Storyteller
//
//  Created by Ryan Britt on 6/11/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STInteractiveScene, STMedia;

@interface STStory : NSManagedObject

@property (nonatomic) int32_t editingSceneIndex;
@property (nonatomic) BOOL isOrdered;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int32_t startingSceneIndex;
@property (nonatomic, retain) NSOrderedSet *interactiveSceneList;
@property (nonatomic, retain) NSSet *storyMedia;
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
- (void)addStoryMediaObject:(STMedia *)value;
- (void)removeStoryMediaObject:(STMedia *)value;
- (void)addStoryMedia:(NSSet *)values;
- (void)removeStoryMedia:(NSSet *)values;

@end
