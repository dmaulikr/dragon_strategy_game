//
//  LoadingScreen_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Map_ViewController.h"

@interface LoadingScreen_ViewController : UIViewController {
    AppDelegate *appDelegate;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
