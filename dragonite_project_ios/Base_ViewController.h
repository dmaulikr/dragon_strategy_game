//
//  Base_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "AppDelegate.h"

@interface Base_ViewController : UIViewController {
    AppDelegate *appDelegate;
}

- (IBAction)IncreaseCountButton:(id)sender;
@end
