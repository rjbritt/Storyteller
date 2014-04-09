//
//  STActor.h
//  Storyteller
//
//  Created by Ryan Britt on 4/8/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STInteractiveSceneElement.h"

@class STInteractiveScene;

@interface STActor : STInteractiveSceneElement

@property (nonatomic, retain) STInteractiveScene *belongingScene;

+(STActor *)initWithName: (NSString *) name withImage:(UIImage *)image withTag:(int) tag withinContext:(NSManagedObjectContext *)context centeredAt:(CGPoint) center;


@end
