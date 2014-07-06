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

-(IBAction)addActorButton:(id)sender;
-(IBAction)addEnvironmentButton:(id)sender;
-(IBAction)addObjectButton:(id)sender;
-(IBAction)addTextButton:(id)sender;


-(void)updateSTInteractiveSceneElementForButton:(UIButton *)button;



@end
