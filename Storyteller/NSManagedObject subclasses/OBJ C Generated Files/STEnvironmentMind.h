//
//  STEnvironmentMind.h
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STEnvironmentSceneElement;

@interface STEnvironmentMind : NSManagedObject

@property (nonatomic, retain) NSSet *presentInElement;
@end

@interface STEnvironmentMind (CoreDataGeneratedAccessors)

- (void)addPresentInElementObject:(STEnvironmentSceneElement *)value;
- (void)removePresentInElementObject:(STEnvironmentSceneElement *)value;
- (void)addPresentInElement:(NSSet *)values;
- (void)removePresentInElement:(NSSet *)values;

@end
