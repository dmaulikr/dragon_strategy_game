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

@interface Region_ViewController : UIViewController {
    AppDelegate *appDelegate;
}

//@property OCPlayer *player;
@property OCRegion *region;
//@property OCPlayer *player;

- (IBAction)startQuest:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *regionView;
@property (weak, nonatomic) IBOutlet UIImageView *regionImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *dragonScrollView;
@property (weak, nonatomic) IBOutlet UILabel *noQuestsSelectedTitle;
@property (weak, nonatomic) IBOutlet UILabel *questLengthTitle;
@property (weak, nonatomic) IBOutlet UILabel *questSuccessChanceTitle;
@property (weak, nonatomic) IBOutlet UILabel *dragonCapacityTitle;
@property (weak, nonatomic) IBOutlet UILabel *questLengthVal;
@property (weak, nonatomic) IBOutlet UILabel *questSuccessChanceVal;
@property (weak, nonatomic) IBOutlet UILabel *dragonCapacityVal;
@property (weak, nonatomic) IBOutlet UIButton *startQuestButton;



@end
