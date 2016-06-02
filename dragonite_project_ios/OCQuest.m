//
//  OCQuest.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 30.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCQuest.h"

@implementation OCQuest

-(id) initWithDistanceFromBase:(double) distance_in withDifficultyLevel:(int) level_in withRequiredDragonType:(enum OCDragonType) type_in withDragonExperienceReward:(int) exp_in atRegion:(int) region_idx withIndex:(int) quest_idx {
    
    self = [super init];
    if (self) {
        
        self.distanceFromBase = distance_in;
        self.difficultyLevel = level_in;
        self.requiredType = type_in;
        self.dragonExperienceReward = exp_in;
        self.regionNo = region_idx;
        self.index = quest_idx;
        
        self.counter = 0;
        self.lastCounterUpdate = [NSDate date];
        
        
    }
    return self;
}

-(void) startQuest:(OCDragon *) dragon {
    [dragon goToQuestNumber:self.index atRegion:self.regionNo withDifficultyLevel:self.difficultyLevel];
}

-(void) finishQuest:(OCDragon *) dragon and:(OCPlayer *) player {
    
    
    //CUT DOWN ENERGY FROM DRAGON!!!!!!! don't forget
    
    if ([self successful:dragon]) {
        
        int rewardGold = [self calculateGoldReward];
        
        [dragon gainExperience:self.dragonExperienceReward];
        
        if (rewardGold > [dragon maxGoldThatCanBeCarried])
            [player earnGold:[dragon maxGoldThatCanBeCarried]];
        
        else [player earnGold:rewardGold];
        
        if (self.counter < 8) self.counter += 1; //might wanna change 8
        
        if (self.counter == 1) self.lastCounterUpdate = [NSDate date];
    }
    
    else {
        //still give the poor dragon some exp
        //be careful, a player shouldn't be able to send a low level dragon
        //to a high level quest, fail but gain more exp
        
        [dragon gainExperience:[self failedQuestExperience:dragon]];
    }
    
    dragon.onQuest = NO;
}

-(int) successRate0To100:(OCDragon *) dragon {
    
    double rate = 1 / 4.3 * pow((dragon.level + (dragon.effectiveStats.strength / 40) - self.difficultyLevel), (1/3)) + 0.5;
    
    if (rate <= 0) return 0;
    else if (rate >= 1) return 100;
    else return rate*100;
}

-(double) successRate0To1:(OCDragon *)dragon {
    double rate = 1 / 4.3 * pow((dragon.level + (dragon.effectiveStats.strength / 40) - self.difficultyLevel), (1/3)) + 0.5;
    
    if (rate <= 0) return 0;
    else if (rate >= 1) return 1;
    else return rate;
}


//Was the dragon successful?
-(BOOL) successful:(OCDragon *) dragon {
    int random_number = arc4random_uniform(101);
    if (random_number <= [self successRate0To100:dragon])
        return YES;
    else return NO;
    
}

-(int) failedQuestExperience: (OCDragon *) dragon {
    return self.dragonExperienceReward * [self successRate0To1:dragon] / 4;
}

-(int) calculateGoldReward {
    int centerVal = 150 * pow(1.2, self.difficultyLevel);
    
    //might wanna change 0.8
    return ((centerVal - centerVal/7) + arc4random_uniform(2*centerVal/7))*pow(0.8, self.counter);
}

-(NSString *) questButtonImage {
    if (self.requiredType == OCfire)
        return @"fire_dragon.png";
    else if (self.requiredType == OCwater)
        return @"water_dragon.png";
    else
        return @"wind_dragon.png";
}

-(NSTimeInterval) counterUpdateTimeInterval {
    //fix this--calculate
    return 0;
}

//does the check too
-(void) checkAndUpdateCounter {
    if (self.counter > 0 && ( [[NSDate date] compare:[NSDate dateWithTimeInterval:[self counterUpdateTimeInterval] sinceDate:self.lastCounterUpdate]] == NSOrderedDescending )) {
        
        self.counter -=1;
        self.lastCounterUpdate = [NSDate date];
    }
}


@end
