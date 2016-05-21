//
//  OCdragon.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCdragon.h"
#import "dragon.h"


@interface OCdragon() {
    Dragon *dragon; //wrapped object
}

@end

@implementation OCdragon

-(id)initDragonWithName:(NSString *)name_in withType:(enum OCDragonType) type_in withGender:(enum OCDragonGender) gender_in withStrength:(double) strength_in withSpeed:(double) speed_in withEndurance:(double) endurance_in withCapacity:(double) capacity_in withLevel:(int) level_in withNumberOfQuestsCompleted:(int) number_of_quests_completed_in isLegendary:(BOOL) legendary_in isMythical:(BOOL) mythical_in {
    self = [super init];
    if (self)
    {
        dragon = new Dragon(std::string([name_in UTF8String]), (Dragon_Type)type_in, (Gender)gender_in, strength_in, speed_in, endurance_in, capacity_in, level_in, number_of_quests_completed_in, legendary_in, mythical_in);
        if (!dragon) self = nil;
    }
    return self;
}

-(id)initDragonWithName:(NSString *)name_in withType:(enum OCDragonType) type_in withGender:(enum OCDragonGender) gender_in withStrength:(double) strength_in withSpeed:(double) speed_in withEndurance:(double) endurance_in withCapacity:(double) capacity_in {
    self = [super init];
    if (self)
    {
        dragon = new Dragon(std::string([name_in UTF8String]), (Dragon_Type)type_in, (Gender)gender_in, strength_in, speed_in, endurance_in, capacity_in);
        if (!dragon) self = nil;
    }
    return self;
}


-(id)initRandomDragonWithName:(NSString *)name_in withType:(enum OCDragonType) type_in withGender:(enum OCDragonGender) gender_in withLevel:(int) level_in withNumberOfQuestsCompleted:(int) number_of_quests_completed_in isLegendary:(BOOL) legendary_in isMythical:(BOOL) mythical_in {
    self = [super init];
    if (self)
    {
        dragon = new Dragon(std::string([name_in UTF8String]), (Dragon_Type)type_in, (Gender)gender_in, level_in, number_of_quests_completed_in, legendary_in, mythical_in);
        if (!dragon) self = nil;
    }
    return self;
}

-(id)initRandomDragonWithName:(NSString *)name_in withType:(enum OCDragonType) type_in withGender:(enum OCDragonGender) gender_in {
    self = [super init];
    if (self)
    {
        dragon = new Dragon(std::string([name_in UTF8String]), (Dragon_Type)type_in, (Gender)gender_in);
        if (!dragon) self = nil;
    }
    return self;
}

- (void)dealloc {
    delete dragon;
}

-(void)improveStatsByStrength:(double) strength_in Speed:(double) speed_in Endurance:(double) endurance_in Capacity:(double) capacity_in {
    dragon->improve_stats(Dragon_Stats(strength_in, speed_in, endurance_in, capacity_in));
}

-(void)levelUp {
    dragon->level_up();
}

-(void)gainExperienceOf:(int) exp_gained {
    dragon->gain_experience(exp_gained);
}

-(void)spendEnergy:(double) energy_spent {
    dragon->spend_energy(energy_spent);
}

-(void)increaseEnergy:(double) energy_gained {
    dragon->increase_energy(energy_gained);
}

-(double)getEnergy {
    return dragon->get_energy();
}

@end
