//
//  OCplayer.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCplayer.h"

@implementation OCPlayer

- (id)initPlayerWithName:(NSString *)nameIn withGender:(enum OCCharacterGender)genderIn {
    self = [super init];
    if (self) {
        self.name = [nameIn copy];
        self.gender = genderIn;
        self.gold = 0;
        self.gem = 0;
        self.numberOfDifferentQuestsCompleted = 0;
        self.highestQuestDifficultyAchievedInCurrentReset = 0;
        self.highestQuestDifficultyAchievedInPreviousReset = 0;
        
        //max dragon count?
        
        self.dragonList = [[NSMutableArray alloc] init];
        self.lastEnergyUpdateDate = [NSDate date]; //should I keep it this way?
        
        //added this later
        self.energyRegenTimeInterval = 60;
    }
    return self;
}

- (id)initPlayer {
    self = [super init];
    if (self) {
        self.dragonList = [[NSMutableArray alloc] init];
        self.lastEnergyUpdateDate = [NSDate date]; //should I keep it this way?
    }
    return self;
}

- (void)earnGold:(int)goldEarned {
    if (self.gold + goldEarned > self.maxGold) self.gold = self.maxGold;
    else self.gold += goldEarned;
}

- (void)spendGold:(int)goldSpent {
    self.gold -= goldSpent;
}

- (void)updateDragonEnergies {
    for (OCDragon *i in self.dragonList) {
        if (!i.onQuest) [i increaseEnergy:self.energyRegenPerMinute];
    }
    //self.lastEnergyUpdateDate = [NSDate date]; //might wanna convert this to something more portable
    self.lastEnergyUpdateDate = [self.lastEnergyUpdateDate dateByAddingTimeInterval:self.energyRegenTimeInterval];
}

- (void)addNewDragon:(OCDragon *)newDragon {
    [self.dragonList addObject:newDragon];
}

- (void)releaseDragon:(OCDragon *)poorDragon {
    [self.dragonList removeObject:poorDragon];
}

- (int)numberOfDragonsAvailable {
    int count = 0;
    for (OCDragon *dragon in self.dragonList) {
        if (!dragon.onQuest && !dragon.isResting) ++count;
    }
    return count;
}

- (void)reset {
    
    //update stats per level
    [OCDragon updateStatsPerDragonLevelTo:[self statsPerLevelForResetAtDifficultyLevel:self.highestQuestDifficultyAchievedInCurrentReset]];
    //update new dragon initial stats bound
    [OCDragon updateNewDragonStatsBoundTo:[self newDragonStatsBoundForResetAtDifficultyLevel:self.highestQuestDifficultyAchievedInCurrentReset]];
    
    self.highestQuestDifficultyAchievedInPreviousReset = self.highestQuestDifficultyAchievedInCurrentReset;
    self.highestQuestDifficultyAchievedInCurrentReset = 0;
    
    //reset the dragons
    for (OCDragon *dragon in self.dragonList) {
        dragon.baseStats.strength = dragon.initialStats.strength;
        dragon.baseStats.speed = dragon.initialStats.speed;
        dragon.baseStats.endurance = dragon.initialStats.endurance;
        
        dragon.availableStatPoints = 0;
        dragon.experience = 0;
        dragon.level = 1;
    }
    
    //building reset is in another function
    
    //player gold and gem
    self.gold = 0;
    self.gem += 1;
}

- (int)statsPerLevelForResetAtDifficultyLevel:(int)level {
    return level;
}

- (int)newDragonStatsBoundForResetAtDifficultyLevel:(int)level {
    return 2*level; //change this
}
@end
