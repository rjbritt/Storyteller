//
//  STTextMedia.h
//  Storyteller
//
//  Created by Ryan Britt on 6/11/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STMedia.h"


@interface STTextMedia : STMedia

@property (nonatomic, retain) NSString * center;
@property (nonatomic, retain) NSString * text;
@property (nonatomic) int32_t fontSize;

@end
