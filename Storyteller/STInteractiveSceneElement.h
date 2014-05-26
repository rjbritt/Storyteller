//
//  STInteractiveSceneElement.h
//  Storyteller
//
//  Created by Ryan Britt on 4/8/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface STInteractiveSceneElement : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * center;
@property (nonatomic) int64_t tag;
@property (nonatomic, retain) NSString * name;

-(CGPoint) centerPointCGPoint;
-(void) setCenterPoint:(CGPoint)point;
-(UIImage *) getUIImageFromData;
-(void) setImageDataFromUIImage: (UIImage *)image;

@end
