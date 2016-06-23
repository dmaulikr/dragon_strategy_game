//
//  MainContainer_ViewController.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 23.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Map_ViewController.h"
#import "Base_ViewController.h"
//#import "AppDelegate.h"

enum Screen {Map, Base};

@interface MainContainer_ViewController : UIViewController {
    AppDelegate *appDelegate;
}

- (IBAction)changeChildView:(id)sender;



@property UILabel *achievementLabel;
@property Map_ViewController *mapView;
@property Base_ViewController *baseView;


@property (weak, nonatomic) IBOutlet UILabel *gemLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldLabel;
@property (weak, nonatomic) IBOutlet UILabel *dragonLabel;

@property (weak, nonatomic) IBOutlet UIImageView *topBoundaryImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomBoundaryImage;

//Can I have this with the same name?
@property (weak, nonatomic) IBOutlet UIButton *changeChildButton;

@property (weak, nonatomic) IBOutlet UILabel *currentChildViewLabel;
@property (weak, nonatomic) IBOutlet UIButton *dragonsButton;



@property enum Screen currentChildView;

@end
