//
//  OCplayer.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCCharacter.h"
#import "OCDragon.h"

@interface OCPlayer : OCCharacter

@property NSMutableArray *dragonList; //Dragons that the player has
@property double energyRegenPerMinute; //same for each one of the dragons

-(id) initPlayerWithName:(NSString *) name_in withGender:(enum OCCharacterGender) gender_in;

-(void) dealloc;

-(int) getGold;

-(int) getExperience;

-(void) levelUp;

-(void) gainExperience:(int) exp_gained;

-(void) earnGold:(int) gold_earned;

-(void) spendGold:(int) gold_spent;

-(void) updateDragonEnergies;

-(void) addNewDragon:(OCDragon *) new_dragon;

-(void) releaseDragon:(OCDragon *) poor_dragon; //:(

@end
