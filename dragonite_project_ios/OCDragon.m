//
//  OCdragon.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCDragon.h"

@implementation OCDragon

//decide how to deal with names
-(id) initNewDragonOfType:(enum OCDragonType) type_in withStatsRange:(int) range_in  ThatIsLegendary:(BOOL) legendary_in isMythical:(BOOL) mythical_in {
    
    self = [super init];
    if (self)
    {
        self.name = [[NSString alloc] init];
        self.type = type_in;
        
        self.initialStats = [[OCDragonStats alloc] init];
        self.baseStats = [[OCDragonStats alloc] init];
        self.effectiveStats = [[OCDragonStats alloc] init];
        
        self.initialStats.strength = arc4random_uniform(range_in)+4;
        self.initialStats.speed = arc4random_uniform(range_in)+4;
        self.initialStats.endurance = arc4random_uniform(range_in)+4;
        self.initialStats.capacity = arc4random_uniform(range_in)+4;
        
        self.baseStats.strength = arc4random_uniform(range_in)+4;
        self.baseStats.speed = arc4random_uniform(range_in)+4;
        self.baseStats.endurance = arc4random_uniform(range_in)+4;
        self.baseStats.capacity = arc4random_uniform(range_in)+4;
        
        //calculate effective stats here!! don't forget to add
        
        self.energy = 5.0; //set current energy equal to max energy calculated with effective endur.
        
        if (arc4random_uniform(2) == 0) self.gender = OCDragonfemale;
        else self.gender = OCDragonmale;
        
        self.level = 1;
        self.experience = 0;
        self.questsCompleted = 0;
        self.isLegendary = legendary_in;
        self.isMythical = mythical_in;
        
        self.availableStatPoints = 0;
        self.availableSkillPoints = 0;
        self.onQuest = NO;
        self.questInfo = [[OCDragonQuestInfo alloc] init];

    }
    return self;
}

-(void)improveStatsByStrength:(double) strength_in Speed:(double) speed_in Endurance:(double) endurance_in Capacity:(double) capacity_in {
    self.baseStats.strength = strength_in;
    self.baseStats.speed = speed_in;
    self.baseStats.endurance = endurance_in;
    self.baseStats.capacity = capacity_in;
    
    //calculate effective
}

-(int) experienceRequiredToLevelUp {
    //fix this
    return 100;
}

-(double) maxEnergy {
    //calculate this
    return 0;
}

-(void)levelUp {
    self.experience -= [self experienceRequiredToLevelUp];
    self.level += 1;
}

-(void)gainExperience:(int) exp_gained {
    self.experience += exp_gained;
    if (self.experience >= [self experienceRequiredToLevelUp])
        [self levelUp];
}

-(void)spendEnergy:(double) energy_spent {
    self.energy -= energy_spent;
    if (self.energy < 0) self.energy = 0;
}

-(void)increaseEnergy:(double) energy_gained {
    self.energy += energy_gained;
    if (self.energy > [self maxEnergy])
        self.energy = [self maxEnergy];
}

-(int) maxGoldThatCanBeCarried {
    //calculate
    return 0;
}

-(void) goToQuestNumber:(int) quest_idx atRegion:(int) region_idx withDifficultyLevel:(int) quest_level {
    
    NSDate *current = [NSDate date];
    NSTimeInterval questLength = [self calculateLengthForQuestWithDifficulty:quest_level];
    NSDate *questEnd = [current initWithTimeIntervalSinceNow:questLength];
    
    [self.questInfo dragonGoesAt:current toQuest:quest_idx atRegion:region_idx andComesBackAt:questEnd];
    
    self.onQuest = YES;
}

-(int) calculateLengthForQuestWithDifficulty:(int) quest_level {
    double questLengthWithoutBoost = 20 * pow(quest_level, 1.75);
    return questLengthWithoutBoost * pow(0.9968, self.effectiveStats.speed);
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

@end
