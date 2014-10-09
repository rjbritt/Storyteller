//
//  STActor.h
//  Storyteller
//
//  Created by Ryan Britt on 10/4/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface STActor : NSManagedObject

@property (nonatomic, retain) NSSet *validCharacters;
@end

@interface STActor (CoreDataGeneratedAccessors)

- (void)addValidCharactersObject:(NSManagedObject *)value;
- (void)removeValidCharactersObject:(NSManagedObject *)value;
- (void)addValidCharacters:(NSSet *)values;
- (void)removeValidCharacters:(NSSet *)values;

@end
