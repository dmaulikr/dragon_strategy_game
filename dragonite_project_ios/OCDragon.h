//
//  OCdragon.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDragonQuestInfo.h"
#import "OCDragonStats.h"
#import "Formulas.h"

enum OCDragonGender {OCDragonfemale, OCDragonmale};
enum OCDragonType {OCfire, OCwater, OCwind, OCgod};

@interface OCDragon : NSObject

@property OCDragonStats *initialStats;
@property OCDragonStats *baseStats;
@property OCDragonStats *effectiveStats;

@property NSString *name;
@property double energy;
@property enum OCDragonType type;
@property enum OCDragonGender gender;
@property int level;
@property int experience;
@property int questsCompleted;
@property BOOL isLegendary;
//@property BOOL isMythical;


//add these to the constructors
@property int availableStatPoints;
//@property int availableSkillPoints;
@property BOOL onQuest;
@property OCDragonQuestInfo *questInfo;
@property BOOL isResting;
@property BOOL isFavorite;

@property NSString *imageName;

//for testing purposes (god dragon)
@property NSTimeInterval previousQuestTime;
@property BOOL isGod;

//Use this to create random dragons. set the values by using property methods if needed.
- (id)initNewDragonOfType:(enum OCDragonType)typeIn withStatsRange:(int)rangeIn ThatIsLegendary:(BOOL)legendaryIn;
- (id)initDragon;
+ (void)updateStatsPerDragonLevelTo:(int)val;
+ (int)StatsPerDragonLevel;
+ (void)updateNewDragonStatsBoundTo:(int)val;
+ (int)NewDragonStatsBound;
- (NSComparisonResult)compareAccordingToLevelAndFavorite:(OCDragon *)otherDragon;
- (NSComparisonResult)compareAccordingToQuestEndDate:(OCDragon *)otherDragon;
- (void)improveStatsByStrength:(int)strengthIn Speed:(int)speedIn Endurance:(int)enduranceIn;
- (int)experienceRequiredToLevelUp;
- (double)maxEnergy;
- (void)levelUp;
- (void)gainExperience:(int)expGained;
- (void)spendEnergy:(double)energySpent;
- (void)increaseEnergy:(double)energyGained;
- (void)goToQuestNumber:(int)questIndex atRegion:(int)regionIndex withDifficultyLevel:(int)questLevel;
- (int)calculateLengthForQuestWithDifficulty:(int)questLevel isExploration:(BOOL)isExploration;
- (NSString *)typeText;
- (NSTimeInterval)remainingQuestTime;
- (void)calculateEffectiveStats;

@end
