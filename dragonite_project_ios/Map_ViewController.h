//
//  Map_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MapFilter.h"
#import "Region_ViewController.h"

@interface Map_ViewController : UIViewController {
    AppDelegate *appDelegate;
    NSMutableArray *buttons;
    //CGFloat upperBound;
    //CGFloat lowerBound;
}

@property (weak, nonatomic) IBOutlet UIScrollView *mapScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property NSTimer *timerInMainContainer;

@end
