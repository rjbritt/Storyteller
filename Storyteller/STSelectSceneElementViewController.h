//
//  STSelectSceneElementViewController.h
//  Storyteller
//
//  Created by Ryan Britt on 7/5/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class STEditSceneViewController;

@interface STSelectSceneElementViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UITabBarDelegate>
@property (strong,nonatomic)STEditSceneViewController *editSceneDelegate;

typedef NS_ENUM(NSUInteger, SelectedSceneElementType)
{
    SelectedSceneElementTypeActor = 0,
    SelectedSceneElementTypeEnvironment,
    SelectedSceneElementTypeObject,
    SelectedSceneElementTypeMedia,
};


@end
