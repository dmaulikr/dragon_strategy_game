//
//  Building_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 23.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCBuilding.h"

@interface Building_ViewController : UIViewController

@property OCBuilding *building;


@property (weak, nonatomic) IBOutlet UIButton *upgradeBuilding;
@property (weak, nonatomic) IBOutlet UIButton *closeView;



@property (weak, nonatomic) IBOutlet UIImageView *buildingImage;
@property (weak, nonatomic) IBOutlet UILabel *buildingInformationLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLevelEffectsLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextLevelEffectsLabel;
@property (weak, nonatomic) IBOutlet UIButton *upgradeButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;


@end
