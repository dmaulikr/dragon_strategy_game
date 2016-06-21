//
//  DragonName_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DragonName_ViewController : UIViewController {
    AppDelegate *appDelegate;
}


- (IBAction)closeButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property UILabel *dragonNameLabel;
@property int dragonIndex;
@end
