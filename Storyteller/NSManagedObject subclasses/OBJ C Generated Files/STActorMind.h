//
//  STActorMind.h
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STActorSceneElement;

@interface STActorMind : NSManagedObject

@property (nonatomic, retain) NSSet *presentInElement;
@end

@interface STActorMind (CoreDataGeneratedAccessors)

- (void)addPresentInElementObject:(STActorSceneElement *)value;
- (void)removePresentInElementObject:(STActorSceneElement *)value;
- (void)addPresentInElement:(NSSet *)values;
- (void)removePresentInElement:(NSSet *)values;

@end
