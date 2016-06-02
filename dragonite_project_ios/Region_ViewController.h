//
//  Region_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 2.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCRegion.h"

@interface Region_ViewController : UIViewController

@property OCRegion *region;
//@property OCPlayer *player;

@property (strong, nonatomic) IBOutlet UIView *regionView;
@property (weak, nonatomic) IBOutlet UIImageView *regionImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *dragonScrollView;

@end
