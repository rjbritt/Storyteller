//
//  STViewController.h
//  Storyteller
//

//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <UIView+DragDrop.h>


@class STInteractiveScene;

@interface STEditSceneViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) STInteractiveScene *currentScene;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

-(void)addTextButton:(id)sender;
-(void)addActorSceneElementWithImage:(UIImage *)image;
-(void)addEnvironmentSceneElementWithImage:(UIImage *)image;
-(void)addObjectSceneElementWithImage:(UIImage *)image;

- (IBAction)showElementSelect:(id)sender;



@end
