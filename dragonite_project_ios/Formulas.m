//
//  Formulas.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 5.07.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "Formulas.h"

static double timeConstant = 1000;

@implementation Formulas

+ (double)questLengthForDragonWithSpeed:(int)speed forQuestDifficulty:(int)difficultyLevel {
    //turn 0.06 back to 0.6
    return timeConstant * 0.06 * pow((1.0 / (1.5 * (double)speed)), 0.5) * pow((double)difficultyLevel, 3.366);
}

+ (double)experienceForSuccessfulQuestWithDifficulty:(int)difficultyLevel {
    return timeConstant / 10.0 * pow((double)difficultyLevel, 1.5);
}

+ (double)experienceForFailedQuestWithDifficulty:(int)difficultyLevel forDragonWithLevel:(int)dragonLevel withStrength:(int)strength {
    return [self experienceForSuccessfulQuestWithDifficulty:difficultyLevel] * [self questSuccessRateForDragonWithLevel:dragonLevel withStrength:strength forQuestDifficulty:difficultyLevel] / 4.0;
}

+ (double)questGoldRewardForQuestDifficulty:(int)difficultyLevel {
    return 42.0 * pow(1.7, (double)difficultyLevel);
}

+ (double)questSuccessRateForDragonWithLevel:(int)dragonLevel withStrength:(int)strength forQuestDifficulty:(int)difficultyLevel {
    
    double rate = (double)(dragonLevel + strength) / pow(difficultyLevel, 2);
    
    if (rate > 1.0) return 1.0;
    else return rate;
}

+ (double)experienceNeededToLevelUpForDragonWithLevel:(int)dragonLevel {
    return timeConstant / 10.0 * pow((double)dragonLevel, 2.0);
}

//Building formulas

+ (int)dragonsDenDragonCapacityForLevel:(int)level {
    return (int)ceil(0.6 * pow((double)level, 2.0));
}

+ (double)fountainEnergyRegenerationTimeIntervalForLevel:(int)level {
    double time = 10 * 60; //10 mins in seconds
    
    for (int i = 1; i < level; i+=1) {
        time = time - time / 10;
    }
    
    return time;
}

+ (int)treasuryGoldCapacityForLevel:(int)level {
    return 6 * 42 * pow(1.7, 5.0 * (double)level);
}

@end
