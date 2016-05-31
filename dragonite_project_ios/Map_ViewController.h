//
//  Map_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "OCRegion.h" //just for a test for now

@interface Map_ViewController : UIViewController {
    AppDelegate *appDelegate;
    //OCRegion *region;
}

@property OCRegion *region;

- (IBAction)IncreaseCountButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *Button;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UIView *RegionView;
@property (weak, nonatomic) IBOutlet UIImageView *RegionImageView;

@end
