//
//  Region_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 2.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import "OCRegion.h"
#import "DragonViewForSelection.h"

@interface Region_ViewController : UIViewController {
    AppDelegate *appDelegate;
}

@property int regionIndex;
@property OCRegion *region;

- (IBAction)startQuest:(id)sender;
- (IBAction)backButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *topBoundary;
@property (weak, nonatomic) IBOutlet UIView *questInformationContainer;

@property (strong, nonatomic) IBOutlet UIView *regionView;
@property (weak, nonatomic) IBOutlet UIImageView *regionImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *dragonScrollView;
@property (weak, nonatomic) IBOutlet UILabel *questInstructionLabel;
@property (weak, nonatomic) IBOutlet UILabel *questLengthTitle;
@property (weak, nonatomic) IBOutlet UILabel *questSuccessChanceTitle;
@property (weak, nonatomic) IBOutlet UILabel *dragonCapacityTitle;
@property (weak, nonatomic) IBOutlet UILabel *questLengthVal;
@property (weak, nonatomic) IBOutlet UILabel *questSuccessChanceVal;
@property (weak, nonatomic) IBOutlet UILabel *dragonCapacityVal;
@property (weak, nonatomic) IBOutlet UIButton *startQuestButton;



@end
