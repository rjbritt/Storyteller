//
//  STSelectSceneElementViewController.m
//  Storyteller
//
//  Created by Ryan Britt on 7/5/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STSelectSceneElementViewController.h"
#import "STEditSceneViewController.h"
#import <UIView+DragDrop.h>

@interface STSelectSceneElementViewController ()
@property (strong, nonatomic) STEditSceneViewController *editSceneVC;
@property (strong, nonatomic) NSArray *sceneElementImageArray;
@property SelectedSceneElementType currentSceneElementType;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation STSelectSceneElementViewController

-(NSArray *)sceneElementImageArray
{
    if (!_sceneElementImageArray)
    {
        _sceneElementImageArray = [[NSArray alloc]init];
    }
    return  _sceneElementImageArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sceneElementImageArray = @[@"Actor",@"Actor 2", @"Actor 3"];    // Do any additional setup after loading the view.
    self.currentSceneElementType = SelectedSceneElementTypeActor;
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addTextButton:(id)sender
{
    [self.editSceneDelegate showElementSelect:sender];
    [self.editSceneDelegate addTextButton:sender];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:self.sceneElementImageArray[indexPath.row]];
    switch (self.currentSceneElementType)
    {
        case SelectedSceneElementTypeActor:
        case SelectedSceneElementTypeEnvironment:
        case SelectedSceneElementTypeObject:
            cell.backgroundView = [[UIImageView alloc]initWithImage:image];
            break;
        case SelectedSceneElementTypeMedia:
        {
            UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 100, 200)];
            [textView setText:@"Text Box"];
            textView.editable = NO;
            textView.userInteractionEnabled = NO;
            textView.backgroundColor = [UIColor grayColor];
            cell.backgroundView = textView;
        }
            break;
        default:
            break;
    }

    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sceneElementImageArray.count;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([item.title isEqualToString:@"Actor"])
    {
        self.currentSceneElementType = SelectedSceneElementTypeActor;
        self.sceneElementImageArray = @[@"Actor",@"Actor 2", @"Actor 3"];
        [self.collectionView reloadData];
    }
    else if ([item.title isEqualToString:@"Environment"])
    {
        self.currentSceneElementType = SelectedSceneElementTypeEnvironment;
        self.sceneElementImageArray = @[@"Environment", @"Environment 2", @"Environment3"];
        [self.collectionView reloadData];
    }
    else if ([item.title isEqualToString:@"Object"])
    {
        self.currentSceneElementType = SelectedSceneElementTypeObject;
        self.sceneElementImageArray = @[@"Object", @"Object 2", @"Object 3"];
        [self.collectionView reloadData];
    }
    else if ([item.title isEqualToString:@"Media"])
    {
        self.currentSceneElementType = SelectedSceneElementTypeMedia;
        self.sceneElementImageArray = @[@"textfield"];
        [self.collectionView reloadData];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *currentCell = [self.collectionView cellForItemAtIndexPath:indexPath];
    UIImage *currentImage;
    if ([currentCell.backgroundView isMemberOfClass:[UIImageView class]])
    {
        currentImage = ((UIImageView *)currentCell.backgroundView).image;
    }

    switch (self.currentSceneElementType)
    {
        case SelectedSceneElementTypeActor:
            [self.editSceneDelegate showElementSelect:nil];
            [self.editSceneDelegate addActorSceneElementWithImage:currentImage];
            break;
        case SelectedSceneElementTypeEnvironment:
            [self.editSceneDelegate showElementSelect:nil];
            [self.editSceneDelegate addEnvironmentSceneElementWithImage:currentImage];
            break;
        case SelectedSceneElementTypeObject:
            [self.editSceneDelegate showElementSelect:nil];
            [self.editSceneDelegate addObjectSceneElementWithImage:currentImage];
            break;
        case SelectedSceneElementTypeMedia:
            [self.editSceneDelegate showElementSelect:nil];
            [self.editSceneDelegate addTextButton:nil];
            break;
            
        default:
            break;
    }
    
}
@end
