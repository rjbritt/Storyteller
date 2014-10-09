//
//  STInteractiveScene.h
//  Storyteller
//
//  Created by Ryan Britt on 7/11/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STCharacterSceneElement, STEnvironmentSceneElement, STMedia, STObjectSceneElement, STStory;

@interface STInteractiveScene : NSManagedObject

@property (nonatomic) int32_t actorTagIncr;
@property (nonatomic) int32_t enviroTagIncr;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int32_t objectTagIncr;
@property (nonatomic, retain) NSOrderedSet *characterSceneElementList;
@property (nonatomic, retain) STStory *belongingStory;
@property (nonatomic, retain) NSOrderedSet *environmentSceneElementList;
@property (nonatomic, retain) NSOrderedSet *objectSceneElementList;
@property (nonatomic, retain) NSSet *sceneMedia;
@end

@interface STInteractiveScene (CoreDataGeneratedAccessors)

- (void)insertObject:(STCharacterSceneElement *)value inCharacterSceneElementListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCharacterSceneElementListAtIndex:(NSUInteger)idx;
- (void)insertCharacterSceneElementList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCharacterSceneElementListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCharacterSceneElementListAtIndex:(NSUInteger)idx withObject:(STCharacterSceneElement *)value;
- (void)replaceCharacterSceneElementListAtIndexes:(NSIndexSet *)indexes withCharacterSceneElementList:(NSArray *)values;
- (void)addCharacterSceneElementListObject:(STCharacterSceneElement *)value;
- (void)removeCharacterSceneElementListObject:(STCharacterSceneElement *)value;
- (void)addCharacterSceneElementList:(NSOrderedSet *)values;
- (void)removeCharacterSceneElementList:(NSOrderedSet *)values;
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
- (void)addSceneMediaObject:(STMedia *)value;
- (void)removeSceneMediaObject:(STMedia *)value;
- (void)addSceneMedia:(NSSet *)values;
- (void)removeSceneMedia:(NSSet *)values;

@end
