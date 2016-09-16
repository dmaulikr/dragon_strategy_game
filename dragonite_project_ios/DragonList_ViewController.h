//
//  DragonList_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 7.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DragonName_ViewController.h"
#import "RadialGradient.h"

enum statTypes {strength, speed, endurance};

@interface DragonList_ViewController : UIViewController  {
    AppDelegate *appDelegate;
}

//- (IBAction)backButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *topBoundary;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property NSMutableArray *viewList;

//for stats view
@property OCDragon *selectedDragon;
@property int maxAvailableStats; //available stats of dragon
@property int remainingAvailableStats; //counts remaining while the user adds points
@property int strengthIncrement;
@property int speedIncrement;
@property int enduranceIncrement;

@property UILabel *currentStrengthLabel;
@property UILabel *currentSpeedLabel;
@property UILabel *currentEnduranceLabel;
@property UILabel *adjustedStrengthLabel;
@property UILabel *adjustedSpeedLabel;
@property UILabel *adjustedEnduranceLabel;
@property UILabel *availableStatsLabel;

@property UIButton *strengthMinus;
@property UIButton *strengthPlus;
@property UIButton *speedMinus;
@property UIButton *speedPlus;
@property UIButton *enduranceMinus;
@property UIButton *endurancePlus;

@property UIButton *clearButton;
@property UIButton *distributeEquallyButton; //not quite
@property enum statTypes statToStartAddingExtraPoints;
@property UIButton *saveButton;

//@property int dragonIndexForWhichTheStatsViewIsOn; //-1 means no stats view is on
@property UIButton *selectedStatsViewButton;

//added later, back button
@property UIButton *backButton;

@property float longPressDuration;

@end
