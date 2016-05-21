//
//  Map_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface Map_ViewController : UIViewController {
    AppDelegate *appDelegate;
}
- (IBAction)IncreaseCountButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *Button;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@end
