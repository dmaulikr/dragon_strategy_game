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
#import "Formulas.h"
#import <math.h>

@interface OCQuest : NSObject

@property NSString *name;
@property NSString *explanation;
@property NSDate *lastCounterUpdate; //when was the last time we updated the counter
@property int counter; //increment after each successful attempt
@property int regionNo;
@property int index; //object lives at which index of region's quest list,
//index 0 = exploration

//@property double distanceFromBase;
@property int difficultyLevel;
//@property int dragonExperienceReward;
@property enum OCDragonType requiredType;
@property BOOL successfullyCompletedAtLeastOnce;
@property int numberOfDragonsCurrentlyOnThisQuest; //how many are doing this quest right now

- (id)initWithDifficultyLevel:(int)levelIn withRequiredDragonType:(enum OCDragonType)typeIn atRegion:(int)regionIndex withIndex:(int)questIndex;
- (void)startQuest:(OCDragon *)dragon;
- (void)finishQuest:(OCDragon *)dragon and:(OCPlayer *)player;
- (int)successRate0To100:(OCDragon *)dragon;
- (double) uccessRate0To1:(OCDragon *)dragon;
- (NSString *) questButtonImage;
//- (NSTimeInterval)counterUpdateTimeInterval;
//- (void)checkAndUpdateCounter;
- (int)calculateGoldRewardEstimate;
- (int)calculateEnergyRequirement;

//For the region screen
//-(void) setScrollView:(UIScrollView *) scrollView forDragons:(NSMutableArray *) dragonList;

@end
