//
//  STObjectMind.h
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STObjectSceneElement;

@interface STObjectMind : NSManagedObject

@property (nonatomic, retain) NSSet *presentInElement;
@end

@interface STObjectMind (CoreDataGeneratedAccessors)

- (void)addPresentInElementObject:(STObjectSceneElement *)value;
- (void)removePresentInElementObject:(STObjectSceneElement *)value;
- (void)addPresentInElement:(NSSet *)values;
- (void)removePresentInElement:(NSSet *)values;

@end
