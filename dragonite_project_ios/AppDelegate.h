//
//  AppDelegate.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "OCPlayer.h"
#import "OCRegion.h"
#import "OCBuilding.h"
#import "OCskill.h"
#import "OCAchievement.h"
#import "OCMythicalDragon.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> 

@property (strong, nonatomic) UIWindow *window;


@property OCPlayer *player;
@property NSMutableArray *skillTree;
@property NSMutableArray *regionList;
@property NSArray *regionButtonCoordinates;
@property NSArray *achievementList;
@property NSDate *lastAchievementCheckDate;
@property NSArray *mythicalDragonList;
@property NSArray *buildingList;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)resetQuestCounters;

@end

