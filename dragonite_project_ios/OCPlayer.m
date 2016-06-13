//
//  OCplayer.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCplayer.h"

@implementation OCPlayer

-(id) initPlayerWithName:(NSString *) name_in withGender:(enum OCCharacterGender) gender_in {
    self = [super init];
    if (self)
    {
        self.name = [name_in copy];
        self.gender = gender_in;
        
        self.dragonList = [[NSMutableArray alloc] init];
        self.lastEnergyUpdateDate = [NSDate date]; //should I keep it this way?
    }
    return self;
}

-(void) earnGold:(int) gold_earned {
    self.gold += gold_earned;
}

-(void) spendGold:(int) gold_spent {
    self.gold -= gold_spent;
}

-(void) updateDragonEnergies {
    for (OCDragon *i in self.dragonList) {
        if (!i.onQuest) [i increaseEnergy:self.energyRegenPerMinute];
    }
    self.lastEnergyUpdateDate = [NSDate date];
}

-(void) addNewDragon:(OCDragon *) new_dragon {
    [self.dragonList addObject:new_dragon];
}

-(void) releaseDragon:(OCDragon *) poor_dragon {
    [self.dragonList removeObject:poor_dragon];
}

@end
