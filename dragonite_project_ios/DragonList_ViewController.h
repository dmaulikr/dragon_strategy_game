//
//  DragonList_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 7.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DragonList_ViewController : UIViewController  {
    AppDelegate *appDelegate;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
//size depends on the number of dragon views. for each one of them, have a bool that shows if
//stats view and skills view active
//@property NSMutableArray *extraActiveViews;


@end
