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

enum OCDragonGender {OCDragonfemale, OCDragonmale};
enum OCDragonType {OCfire, OCwater, OCwind, OCearth, OCother};

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
@property BOOL isMythical;


//add these to the constructors
@property int availableStatPoints;
@property int availableSkillPoints;
@property BOOL onQuest;
@property OCDragonQuestInfo *questInfo;

//Use this to create random dragons. set the values by using property methods if needed.
-(id) initNewDragonOfType:(enum OCDragonType) type_in withStatsRange:(int) range_in ThatIsLegendary:(BOOL) legendary_in isMythical:(BOOL) mythical_in;


-(void)improveStatsByStrength:(double) strength_in Speed:(double) speed_in Endurance:(double) endurance_in Capacity:(double) capacity_in;

-(int) experienceRequiredToLevelUp;

-(double) maxEnergy;

-(void)levelUp;

-(void)gainExperience:(int) exp_gained;

-(void)spendEnergy:(double) energy_spent;

-(void)increaseEnergy:(double) energy_gained;

-(int) maxGoldThatCanBeCarried;

-(void) goToQuestNumber:(int) quest_idx atRegion:(int) region_idx withDifficultyLevel:(int) quest_level;

-(int) calculateLengthForQuestWithDifficulty:(int) quest_level;

@end
