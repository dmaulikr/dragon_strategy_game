//
//  OCQuest.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 30.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCQuest.h"

@implementation OCQuest

-(void) doQuest:(OCDragon *) dragon and:(OCPlayer *) player {
    if ([self successful:dragon]) {
        
        [dragon gainExperience:self.prizeDragonExperience];
        
        if (self.prizeGold > [dragon maxGoldThatCanBeCarried])
            [player earnGold:[dragon maxGoldThatCanBeCarried]];
        
        else [player earnGold:self.prizeGold];
    }
    
    else {
        //still give the poor dragon some exp
        //be careful, a player shouldn't be able to send a low level dragon
        //to a high level quest, fail but gain more exp
        
        [dragon gainExperience:[self failedQuestExperience:dragon]];
    }
}

-(int) successRate0To100:(OCDragon *) dragon {
    
    double rate = 1 / 4.3 * pow((dragon.level + (dragon.effectiveStrength / 40) - self.difficultyLevel), (1/3)) + 0.5;
    
    if (rate <= 0) return 0;
    else if (rate >= 1) return 100;
    else return rate*100;
}

-(double) successRate0To1:(OCDragon *)dragon {
    double rate = 1 / 4.3 * pow((dragon.level + (dragon.effectiveStrength / 40) - self.difficultyLevel), (1/3)) + 0.5;
    
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
    return self.prizeDragonExperience * [self successRate0To1:dragon] / 4;
}

@end
