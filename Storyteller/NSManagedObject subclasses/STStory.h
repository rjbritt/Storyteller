//
//  STStory.h
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STInteractiveScene;

@interface STStory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *interactiveSceneList;
@property (nonatomic, retain) NSManagedObject *storyMedia;
@property (nonatomic, retain) STInteractiveScene *startingScene;
@end

@interface STStory (CoreDataGeneratedAccessors)

- (void)addInteractiveSceneListObject:(STInteractiveScene *)value;
- (void)removeInteractiveSceneListObject:(STInteractiveScene *)value;
- (void)addInteractiveSceneList:(NSSet *)values;
- (void)removeInteractiveSceneList:(NSSet *)values;
            
@end

