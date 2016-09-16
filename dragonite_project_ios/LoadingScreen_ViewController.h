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
#import "MainContainer_ViewController.h"
#import "Map_ViewController.h"

@interface LoadingScreen_ViewController : UIViewController {
    AppDelegate *appDelegate;
}

@property (strong) NSManagedObjectContext *managedObjectContext;
@property (strong) NSMutableArray *savedDragons;
@property (strong) NSMutableArray *savedPlayers;
@property (strong) NSMutableArray *savedQuests;
@property (strong) NSMutableArray *savedBuildings;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property UILabel *achievementLabel;
@end
