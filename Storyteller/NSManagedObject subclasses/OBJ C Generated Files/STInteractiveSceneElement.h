//
//  STInteractiveSceneElement.h
//  Storyteller
//
//  Created by Ryan Britt on 6/24/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface STInteractiveSceneElement : NSManagedObject

@property (nonatomic, retain) NSString * center;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) double rotation;

@end
