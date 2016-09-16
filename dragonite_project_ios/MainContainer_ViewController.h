//
//  MainContainer_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 23.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Map_ViewController.h"
#import "Base_ViewController.h"
//#import "CircularProgressView.h"
//#import "AppDelegate.h"
#import "SideNotificationCenter.h"

enum Screen {Map, Base};

@interface MainContainer_ViewController : UIViewController {
    AppDelegate *appDelegate;
}

- (IBAction)changeChildView:(id)sender;
- (IBAction)resetAction:(id)sender;

@property NSTimer *mainTimer;
@property UILabel *achievementLabel;
@property Map_ViewController *mapView;
@property Base_ViewController *baseView;
@property (weak, nonatomic) IBOutlet UILabel *gemLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldLabel;
@property (weak, nonatomic) IBOutlet UILabel *dragonLabel;
@property (weak, nonatomic) IBOutlet UIView *topBoundary;
@property (weak, nonatomic) IBOutlet UIView *goldProgressContainerView;
@property (weak, nonatomic) IBOutlet UIProgressView *goldProgressView;
@property (weak, nonatomic) IBOutlet UIImageView *goldIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gemIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *dragonIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *gemPlusButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *achievementButton;
@property (weak, nonatomic) IBOutlet UIButton *adsButton;

//reset button constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resetButtonHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resetButtonBottomConstraint;

//settings button constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *settingsButtonHeightConstraint;

@property (weak, nonatomic) IBOutlet UIButton *changeChildButton;
@property (weak, nonatomic) IBOutlet UIButton *dragonsButton;

@property SideNotificationCenter *sideNotificationCenter;

@property enum Screen currentChildView;


@property (strong) NSMutableArray *savedDragons;
@property (strong) NSMutableArray *savedPlayers;
@property (strong) NSMutableArray *savedQuests;

//explanation view
@property UIView *explanationView;

@property NSDate *lastResetButtonAnimationDate;
@property NSDate *lastSettingsButtonAnimationDate;

@property UIView *viewToHide; //view that hides the other views during the loading process

//@property NSTimeInterval *adBoostDuration;

@end
