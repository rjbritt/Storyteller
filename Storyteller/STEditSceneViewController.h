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

@interface STEditSceneViewController : UIViewController<UIViewDragDropDelegate, UITextViewDelegate>

@property (strong, nonatomic) STInteractiveScene *currentScene;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

-(void)addActorButton:(id)sender;
-(void)addEnvironmentButton:(id)sender;
-(void)addObjectButton:(id)sender;
-(void)addTextButton:(id)sender;

- (IBAction)showElementSelect:(id)sender;



-(void)updateSTInteractiveSceneElementForButton:(UIButton *)button;



@end
