//
//  Building_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 23.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCBuilding.h"
#import "AppDelegate.h"
#import "DragonViewForSelection.h"

@interface Building_ViewController : UIViewController {
    AppDelegate *appDelegate;
}

@property int indexInBuildingArray;
@property OCBuilding *building;


@property (weak, nonatomic) IBOutlet UIButton *upgradeBuilding; //change this to action probably?

@property (weak, nonatomic) IBOutlet UILabel *buildingNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *buildingImage;
@property (weak, nonatomic) IBOutlet UILabel *buildingInformationLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLevelEffectsLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextLevelEffectsLabel;
@property (weak, nonatomic) IBOutlet UIButton *upgradeButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIScrollView *dragonScrollView;
@property (weak, nonatomic) IBOutlet UIView *backgroundFilterView;

@property NSMutableArray *selectedDragonButtonList; //dragon buttons for buildings like the spring
@property NSMutableArray *availableDragonList;
@property NSArray *sortedDragonList; //the sorted version of dragon array in player
@property NSMutableArray *availableDragonButtonList;
@property int selectedDragonIndex;

@property UIColor *dragonButtonColorForNormalState;
@property UIColor *dragonButtonColorForSelectedState;

- (IBAction)closeView;

@end
