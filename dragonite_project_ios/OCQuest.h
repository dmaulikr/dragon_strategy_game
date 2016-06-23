//
//  OCQuest.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 30.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OCDragon.h"
#import "OCPlayer.h"
#import <math.h>

@interface OCQuest : NSObject

@property NSString *name;
@property NSString *explanation;
@property NSDate *lastCounterUpdate; //when was the last time we updated the counter
@property int counter; //increment after each successful attempt
@property int regionNo;
@property int index; //object lives at which index of region's quest list
@property double distanceFromBase;
@property int difficultyLevel;
@property int dragonExperienceReward;
@property enum OCDragonType requiredType;
@property BOOL successfullyCompletedAtLeastOnce;

-(id) initWithDistanceFromBase:(double) distance_in withDifficultyLevel:(int) level_in withRequiredDragonType:(enum OCDragonType) type_in withDragonExperienceReward:(int) exp_in atRegion:(int) region_idx withIndex:(int) quest_idx;
-(void) startQuest:(OCDragon *) dragon;
-(void) finishQuest:(OCDragon *) dragon and:(OCPlayer *) player;
-(int) successRate0To100:(OCDragon *) dragon;
-(double) successRate0To1:(OCDragon *)dragon;
-(NSString *) questButtonImage;
-(NSTimeInterval) counterUpdateTimeInterval;
-(void) checkAndUpdateCounter;

//For the region screen
//-(void) setScrollView:(UIScrollView *) scrollView forDragons:(NSMutableArray *) dragonList;

@end
