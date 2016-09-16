//
//  OCQuest.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 30.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCQuest.h"

@implementation OCQuest

- (id)initWithDifficultyLevel:(int)levelIn withRequiredDragonType:(enum OCDragonType)typeIn atRegion:(int)regionIndex withIndex:(int)questIndex {
    self = [super init];
    if (self) {
        self.difficultyLevel = levelIn;
        self.requiredType = typeIn;
        self.regionNo = regionIndex;
        self.index = questIndex;
        self.successfullyCompletedAtLeastOnce = NO;
        
        self.numberOfDragonsCurrentlyOnThisQuest = 0;
        
        self.counter = 0;
        self.lastCounterUpdate = [NSDate date];
        
        
    }
    return self;
}

- (void)startQuest:(OCDragon *)dragon {
    [dragon goToQuestNumber:self.index atRegion:self.regionNo withDifficultyLevel:self.difficultyLevel];
}

- (void)finishQuest:(OCDragon *)dragon and:(OCPlayer *)player {
    
    self.numberOfDragonsCurrentlyOnThisQuest -= 1;
    player.totalNumberOfQuestsCompleted += 1;
    
    //CUT DOWN ENERGY FROM DRAGON!!!!!!! don't forget
    [dragon spendEnergy:[self calculateEnergyRequirement]];
    
    if ([self successful:dragon]) {  // ^_^ Yeay
        
        if (!self.successfullyCompletedAtLeastOnce) {
            self.successfullyCompletedAtLeastOnce = YES;
            player.numberOfDifferentQuestsCompleted += 1;
        }
        
        int rewardGold = [self calculateGoldReward];
        
        [dragon gainExperience:[self successfulQuestExperience]];
        dragon.questsCompleted += 1;
        
        [player earnGold:rewardGold];
        
        if (self.counter < 8) self.counter += 1; //might wanna change 8
        
        if (self.counter == 1) self.lastCounterUpdate = [NSDate date];
        
        NSLog(@"Quest Counter: %d", self.counter);
        
        //update player's success if it's not exploration
        if (self.index != 0 && self.difficultyLevel > player.highestQuestDifficultyAchievedInCurrentReset)
            player.highestQuestDifficultyAchievedInCurrentReset = self.difficultyLevel;
        
        //notify the side notification center and the viewcontrollers
        if (self.index == 0) {
            NSString *notificationText = [NSString stringWithFormat:@"%@ has explored a new region.", dragon.name];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"AddNotification"
             object:notificationText];
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"ExploredRegion"
             object:[NSNumber numberWithInt:self.regionNo]];
        }
        
        else {
            NSString *notificationText = [NSString stringWithFormat:@"%@ has successfully completed a quest.", dragon.name];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"AddNotification"
             object:notificationText];
        }
    }
    
    else { // :(
        //still give the poor dragon some exp
        //be careful, a player shouldn't be able to send a low level dragon
        //to a high level quest, fail but gain more exp
        
        [dragon gainExperience:[self failedQuestExperience:dragon]];
        
        //notify the side notification center
        NSString *notificationText = [NSString stringWithFormat:@"%@ has failed a quest.", dragon.name];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"AddNotification"
         object:notificationText];
    }
    
    dragon.onQuest = NO;
}

- (int)successRate0To100:(OCDragon *)dragon {
    
    return (int)(100 * [self successRate0To1:dragon]);
}

- (double)successRate0To1:(OCDragon *)dragon {
    
    //for test
    //return 1;
    
    double rate = [Formulas questSuccessRateForDragonWithLevel:dragon.level withStrength:dragon.effectiveStats.strength forQuestDifficulty:self.difficultyLevel];
    
    if (rate <= 0) return 0;
    else if (rate >= 1) return 1;
    else return rate;
}


//Was the dragon successful?
- (BOOL)successful:(OCDragon *)dragon {
    
    if (self.index == 0 || dragon.isGod) return YES; //Exploration quests will always be successful
    
    int random_number = arc4random_uniform(101);
    if (random_number <= [self successRate0To100:dragon])
        return YES;
    else return NO;
    
}

- (int)successfulQuestExperience {
    
    //test
    //return (int)([Formulas experienceForSuccessfulQuestWithDifficulty:self.difficultyLevel]*pow(0.8, self.counter) + 0.5);
    
    //this is the actual thing
    return (int)([Formulas experienceForSuccessfulQuestWithDifficulty:self.difficultyLevel]*pow(0.8, self.counter));
}

- (int)failedQuestExperience:(OCDragon *)dragon {
    return (int)([Formulas experienceForFailedQuestWithDifficulty:self.difficultyLevel forDragonWithLevel:dragon.level withStrength:dragon.effectiveStats.strength]*pow(0.8, self.counter));
}

- (int)calculateGoldReward {
    
    //exploration case
    if (self.index == 0) return 0;
    
    double centerVal = [Formulas questGoldRewardForQuestDifficulty:self.difficultyLevel];
    
    //for testing
    return (int)(centerVal * pow(0.8, self.counter) );
    
    //might wanna change 0.8, also I checked,the uniform and centerVal part actually makes sense
    return (int)( ((centerVal - centerVal/7) + arc4random_uniform(2*(int)centerVal/7))*pow(0.8, self.counter) );
}

// this is the previous function without the random part
- (int)calculateGoldRewardEstimate {
    //if (self.index == 0) return 0;
    
    double centerVal = [Formulas questGoldRewardForQuestDifficulty:self.difficultyLevel];
    return (int)centerVal;
}

- (NSString *)questButtonImage {
    if (self.requiredType == OCfire)
        return @"fire_dragon.png";
    else if (self.requiredType == OCwater)
        return @"water_dragon.png";
    else
        return @"wind_dragon.png";
}

/*- (NSTimeInterval)counterUpdateTimeInterval {
    //fix this--calculate
    return 0;
} */

//does the check too
/*-(void) checkAndUpdateCounter {
    if (self.counter > 0 && ( [[NSDate date] compare:[NSDate dateWithTimeInterval:[self counterUpdateTimeInterval] sinceDate:self.lastCounterUpdate]] == NSOrderedDescending )) {
        
        self.counter -=1;
        self.lastCounterUpdate = [NSDate date];
    }
} */

- (int)calculateEnergyRequirement {
    if (self.index == 0)
        return (int)(pow((double)self.difficultyLevel, 1.5));
    else return self.difficultyLevel;
}

@end
