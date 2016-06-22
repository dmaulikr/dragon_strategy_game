//
//  AppDelegate.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCPlayer.h"
#import "OCRegion.h"
#import "OCskill.h"
#import "OCAchievement.h"
#import "OCMythicalDragon.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    //@public int count;
    //int prev_screen_for_setting;
}

@property (strong, nonatomic) UIWindow *window;


@property OCPlayer *player;
@property NSMutableArray *skillTree;
@property NSMutableArray *regionList;
@property NSArray *regionButtonCoordinates;
@property NSArray *achievementList;
@property NSDate *lastAchievementCheckDate;
@property NSArray *mythicalDragonList;

@end

