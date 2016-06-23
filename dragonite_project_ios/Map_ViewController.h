//
//  Map_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Region_ViewController.h"

@interface Map_ViewController : UIViewController {
    AppDelegate *appDelegate;
    NSMutableArray *buttons;
    CGFloat upperBound;
    CGFloat lowerBound;
}

@property (weak, nonatomic) IBOutlet UIScrollView *mapScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet UIImageView *upperBoundView;
@property (weak, nonatomic) IBOutlet UIImageView *lowerBoundView;
/*@property (weak, nonatomic) IBOutlet UILabel *gemLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldLabel;
@property (weak, nonatomic) IBOutlet UILabel *dragonLabel;*/

@end
