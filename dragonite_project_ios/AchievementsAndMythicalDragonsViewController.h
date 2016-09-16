//
//  AchievementsAndMythicalDragonsViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.08.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "achievementCell.h"
#import "mythicalDragonCell.h"

enum currentCollectionView {achievementsView, mythicalDragonsView};

@interface AchievementsAndMythicalDragonsViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    AppDelegate *appDelegate;
}

@property enum currentCollectionView viewBeingShown;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property UICollectionView *achievementCollectionView;
@property UICollectionView *mythicalDragonCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *achievementsButton;
@property (weak, nonatomic) IBOutlet UIButton *mythicalDragonsButton;

- (IBAction)showAchievements:(id)sender;
- (IBAction)showMythicalDragons:(id)sender;


@end
