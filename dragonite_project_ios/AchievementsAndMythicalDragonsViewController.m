//
//  AchievementsAndMythicalDragonsViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.08.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "AchievementsAndMythicalDragonsViewController.h"

@interface AchievementsAndMythicalDragonsViewController ()

@end

@implementation AchievementsAndMythicalDragonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    float rightInset = 5.0;
    float topInset = 8.0;
    float leftInset = 5.0;
    float bottomInset = 8.0;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Set the current view
    self.viewBeingShown = achievementsView;
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
    self.scrollView.delegate = self;
    //self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    self.achievementCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.scrollView.frame.size.height) collectionViewLayout:layout1];
    self.achievementCollectionView.contentInset = UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset);
    [self.achievementCollectionView setDataSource:self];
    [self.achievementCollectionView setDelegate:self];
    [self.achievementCollectionView registerClass:[achievementCell class] forCellWithReuseIdentifier:@"achievementCellIdentifier"];
    [self.achievementCollectionView setBackgroundColor:[UIColor redColor]];
    [self.scrollView addSubview:self.achievementCollectionView];
    
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
    self.mythicalDragonCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.scrollView.frame.size.height) collectionViewLayout:layout2];
    self.mythicalDragonCollectionView.contentInset = UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset);
    [self.mythicalDragonCollectionView setDataSource:self];
    [self.mythicalDragonCollectionView setDelegate:self];
    [self.mythicalDragonCollectionView registerClass:[mythicalDragonCell class] forCellWithReuseIdentifier:@"mythicalDragonCellIdentifier"];
    [self.mythicalDragonCollectionView setBackgroundColor:[UIColor blueColor]];
    [self.scrollView addSubview:self.mythicalDragonCollectionView];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.achievementCollectionView)
        return [appDelegate.achievementList count];
    else
        return [appDelegate.mythicalDragonList count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == self.achievementCollectionView){
        achievementCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"achievementCellIdentifier" forIndexPath:indexPath];
        //cell.label.text = self.array1[indexPath.item];
        return cell;
    } else if (collectionView == self.mythicalDragonCollectionView){
        mythicalDragonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mythicalDragonCellIdentifier" forIndexPath:indexPath];
        //cell.label.text = self.array2[indexPath.item];
        return cell;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width / 6, self.view.frame.size.width / 6);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        //NSLog(@"achievements");
        self.viewBeingShown = achievementsView;
    }
    else if (scrollView.contentOffset.x == scrollView.frame.size.width) {
        //NSLog(@"mythical dragons");
        self.viewBeingShown = mythicalDragonsView;
    }
}

- (IBAction)showAchievements:(id)sender {
    if (self.viewBeingShown == achievementsView) return;
    
    self.viewBeingShown = achievementsView;
    [self.scrollView setContentOffset:CGPointMake(0, 0)  animated:YES];
}

- (IBAction)showMythicalDragons:(id)sender {
    if (self.viewBeingShown == mythicalDragonsView) return;
    
    self.viewBeingShown = mythicalDragonsView;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)  animated:YES];
}
@end
