//
//  Formulas.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 5.07.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Formulas : NSObject

+ (double)questLengthForDragonWithSpeed:(int)speed forQuestDifficulty:(int)difficultyLevel;

+ (double)experienceForSuccessfulQuestWithDifficulty:(int)difficultyLevel;

+ (double)experienceForFailedQuestWithDifficulty:(int)difficultyLevel forDragonWithLevel:(int)dragonLevel withStrength:(int)strength;

+ (double)questGoldRewardForQuestDifficulty:(int)difficultyLevel;

+ (double)questSuccessRateForDragonWithLevel:(int)dragonLevel withStrength:(int) strength forQuestDifficulty:(int)difficultyLevel;

+ (double)experienceNeededToLevelUpForDragonWithLevel:(int)dragonLevel;

//Building Formulas

+ (int)dragonsDenDragonCapacityForLevel:(int)level;

+ (double)fountainEnergyRegenerationTimeIntervalForLevel:(int)level;

+ (int)treasuryGoldCapacityForLevel:(int)level;

@end
