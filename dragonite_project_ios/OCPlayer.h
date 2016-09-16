//
//  OCplayer.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCCharacter.h"
#import "OCDragon.h"

@interface OCPlayer : OCCharacter

@property NSMutableArray *dragonList; //Dragons that the player has
@property double energyRegenPerMinute; //same for each one of the dragons
@property int maxBuildingLevel; //current lvl of main building
@property int maxGold; //depends on the treasury
@property int maxDragonCount; //depends on dragons' den
@property int gold;
@property int gem;
@property int numberOfResets;
@property NSDate *lastEnergyUpdateDate;
@property int numberOfDifferentQuestsCompleted;
@property int highestQuestDifficultyAchievedInCurrentReset;
@property int highestQuestDifficultyAchievedInPreviousReset;

//added later
@property int totalNumberOfQuestsCompleted;
@property int numberOfDragonsFound;
@property int numberOfMythicalDragonsDiscovered;

@property BOOL adBonusIsActive; //this one works a little differently than the others
@property BOOL goldBoostIsActive;
@property BOOL expBoostIsActive;
@property BOOL luckBoostIsActive;

@property NSDate *adBonusEndDate;
@property NSDate *goldBoostEndDate;
@property NSDate *expBoostEndDate;
@property NSDate *luckBoostEndDate;

//more to add
@property NSDate *nextCounterResetDate;
@property int energyRegenTimeInterval;


- (id)initPlayerWithName:(NSString *)nameIn withGender:(enum OCCharacterGender)genderIn;
- (id)initPlayer;
- (void)earnGold:(int)goldEarned;
- (void)spendGold:(int)goldSpent;
- (void)updateDragonEnergies;
- (void)addNewDragon:(OCDragon *)newDragon;
- (void)releaseDragon:(OCDragon *)poorDragon; //:(
//- (void)checkIfQuestsEnded;
- (int)numberOfDragonsAvailable;
- (void)reset;

@end
