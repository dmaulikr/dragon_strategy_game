//
//  OCdragon.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCDragon.h"

static int statsPerLevel = 1;
static int statsBound = 1; //bound for stats in new dragon initialization

@implementation OCDragon

//decide how to deal with names
- (id)initNewDragonOfType:(enum OCDragonType)typeIn withStatsRange:(int)rangeIn ThatIsLegendary:(BOOL)legendaryIn {
    self = [super init];
    if (self) {
        self.name = [[NSString alloc] init];
        self.type = typeIn;
        
        self.initialStats = [[OCDragonStats alloc] init];
        self.baseStats = [[OCDragonStats alloc] init];
        self.effectiveStats = [[OCDragonStats alloc] init];
        
        self.initialStats.strength = arc4random_uniform(rangeIn);
        self.initialStats.speed = arc4random_uniform(rangeIn);
        self.initialStats.endurance = arc4random_uniform(rangeIn);
        
        self.baseStats.strength = arc4random_uniform(rangeIn);
        self.baseStats.speed = arc4random_uniform(rangeIn);
        self.baseStats.endurance = arc4random_uniform(rangeIn);
        
        //calculate effective stats here!! don't forget to add
        
        //self.energy = 5.0; //set current energy equal to max energy calculated with effective endur.
        
        if (arc4random_uniform(2) == 0) self.gender = OCDragonfemale;
        else self.gender = OCDragonmale;
        
        self.level = 1;
        self.experience = 0;
        self.questsCompleted = 0;
        self.isLegendary = legendaryIn;
        //self.isMythical = mythical_in;
        
        self.availableStatPoints = 0;
        //self.availableSkillPoints = 0;
        self.onQuest = NO;
        self.questInfo = [[OCDragonQuestInfo alloc] init];

    }
    return self;
}

- (id)initDragon {
    self = [super init];
    if (self) {
        self.name = [[NSString alloc] init];
        self.initialStats = [[OCDragonStats alloc] init];
        self.baseStats = [[OCDragonStats alloc] init];
        self.effectiveStats = [[OCDragonStats alloc] init];
        self.questInfo = [[OCDragonQuestInfo alloc] init];
        
    }
    return self;
}

- (NSComparisonResult)compareAccordingToLevelAndFavorite:(OCDragon *)otherDragon {
    if (self.isFavorite && !otherDragon.isFavorite) return NSOrderedAscending;
    else if (!self.isFavorite && otherDragon.isFavorite) return NSOrderedDescending;
    else if (self.level > otherDragon.level) return NSOrderedAscending;
    else return NSOrderedDescending;
}

- (NSComparisonResult)compareAccordingToQuestEndDate:(OCDragon *)otherDragon {
    return [self.questInfo.endDate compare:otherDragon.questInfo.endDate];
}

- (void)improveStatsByStrength:(int)strengthIn Speed:(int)speedIn Endurance:(int)enduranceIn {
    self.baseStats.strength = strengthIn;
    self.baseStats.speed = speedIn;
    self.baseStats.endurance = enduranceIn;
    
    //calculate effective
}

- (int)experienceRequiredToLevelUp {
    return [Formulas experienceNeededToLevelUpForDragonWithLevel:self.level];
}

- (double)maxEnergy {
    //calculate this
    return self.effectiveStats.endurance;
}

- (void)levelUp {
    self.experience -= [self experienceRequiredToLevelUp];
    self.level += 1;
    self.availableStatPoints += statsPerLevel;
    
    //for testing
    //if (self.isGod) self.effectiveStats.endurance += 1;
}

- (void)gainExperience:(int)expGained {
    self.experience += expGained;
    if (self.experience >= [self experienceRequiredToLevelUp])
        [self levelUp];
}

- (void)spendEnergy:(double)energySpent {
    self.energy -= energySpent;
    if (self.energy < 0) self.energy = 0;
}

- (void)increaseEnergy:(double)energyGained {
    self.energy += energyGained;
    if (self.energy > [self maxEnergy])
        self.energy = [self maxEnergy];
}

- (void)goToQuestNumber:(int)questIndex atRegion:(int)regionIndex withDifficultyLevel:(int)questLevel {
    
    NSDate *current = [NSDate date];
    
    //exploration case included
    NSTimeInterval questLength = [self calculateLengthForQuestWithDifficulty:questLevel isExploration:(questIndex==0)];
    
    NSDate *questEnd = [current initWithTimeIntervalSinceNow:questLength];
    
    //for testing
    if (self.isGod == YES) {
        self.previousQuestTime = questLength;
        questEnd = [NSDate date];
    }
    
    [self.questInfo dragonGoesAt:current toQuest:questIndex atRegion:regionIndex andComesBackAt:questEnd];
    
    self.onQuest = YES;
}

- (int)calculateLengthForQuestWithDifficulty:(int)questLevel isExploration:(BOOL)isExploration {
    NSTimeInterval questLength = [Formulas questLengthForDragonWithSpeed:self.effectiveStats.speed forQuestDifficulty:questLevel];
    if (isExploration) questLength *= 4;
    return questLength;
}

- (NSString *)typeText {
    if (self.type == OCfire)
        return [NSString stringWithFormat:@"Fire Dragon"];
    else if (self.type == OCwater)
        return [NSString stringWithFormat:@"Water Dragon"];
    else
        return [NSString stringWithFormat:@"Wind Dragon"];
}

- (NSTimeInterval)remainingQuestTime {
    return [self.questInfo.endDate timeIntervalSinceNow];
}

+ (void)updateStatsPerDragonLevelTo:(int)val {
    statsPerLevel = val;
}

+ (int)StatsPerDragonLevel {
    return statsPerLevel;
}

+ (void)updateNewDragonStatsBoundTo:(int)val {
    statsBound = val;
}

+ (int)NewDragonStatsBound {
    return statsBound;
}

- (void)calculateEffectiveStats {
    //change this later
    self.effectiveStats.strength = self.baseStats.strength;
    self.effectiveStats.speed = self.baseStats.speed;
    self.effectiveStats.endurance = self.baseStats.endurance;
}

@end
