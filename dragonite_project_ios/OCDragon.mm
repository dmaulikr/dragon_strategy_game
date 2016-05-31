//
//  OCdragon.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCDragon.h"
#import "dragon.h"


@interface OCDragon() {
    Dragon *dragon; //wrapped object
}

@end

/*@interface OCDragon (AccessWrappedObject)

-(Dragon *) getWrappedDragon;

@end */


@implementation OCDragon

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

- (void) dealloc {
    delete dragon;
}

-(void)improveStatsByStrength:(double) strength_in Speed:(double) speed_in Endurance:(double) endurance_in Capacity:(double) capacity_in {
    dragon->improve_stats(Dragon_Stats(strength_in, speed_in, endurance_in, capacity_in));
}

-(void)levelUp {
    dragon->level_up();
}

-(void)gainExperience:(int) exp_gained {
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

//So that we can access the dragon inside
-(Dragon *) getWrappedDragon {
    return dragon;
}

                                /*Getters and Setters for the Stats*/
-(double) initialStrength {
    return dragon->get_initial_strength();
}

-(double) initialSpeed {
    return dragon->get_initial_speed();
}

-(double) initialEndurance {
    return dragon->get_initial_endurance();
}

-(double) initialCapacity {
    return dragon->get_initial_capacity();
}


-(double) baseStrength {
    return dragon->get_base_strength();
}

-(double) baseSpeed {
    return dragon->get_base_speed();
}

-(double) baseEndurance {
    return dragon->get_base_endurance();
}

-(double) baseCapacity {
    return dragon->get_base_capacity();
}


-(double) effectiveStrength {
    return dragon->get_effective_strength();
}

-(double) effectiveSpeed {
    return dragon->get_effective_speed();
}

-(double) effectiveEndurance {
    return dragon->get_effective_endurance();
}

-(double) effectiveCapacity {
    return dragon->get_effective_capacity();
}


-(void) setInitialStrength:(double) val {
    dragon->set_initial_strength(val);
}

-(void) setInitialSpeed:(double) val {
    dragon->set_initial_speed(val);
}

-(void) setInitialEndurance:(double) val {
    dragon->set_initial_endurance(val);
}

-(void) setInitialCapacity:(double) val {
    dragon->set_initial_capacity(val);
}


-(void) setBaseStrength:(double) val {
    dragon->set_base_strength(val);
}

-(void) setBaseSpeed:(double) val {
    dragon->set_base_speed(val);
}

-(void) setBaseEndurance:(double) val {
    dragon->set_base_endurance(val);
}

-(void) setBaseCapacity:(double) val {
    dragon->set_base_capacity(val);
}


-(void) setEffectiveStrength:(double) val {
    dragon->set_effective_strength(val);
}

-(void) setEffectiveSpeed:(double) val {
    dragon->set_effective_speed(val);
}

-(void) setEffectiveEndurance:(double) val {
    dragon->set_effective_endurance(val);
}

-(void) setEffectiveCapacity:(double) val {
    dragon->set_effective_capacity(val);
}


-(void) setInitialStatswithStrength:(double) strength_in withSpeed:(double) speed_in withEndurance:(double) endurance_in withCapacity:(double) capacity_in {
    dragon->set_initial_stats(strength_in, speed_in, endurance_in, capacity_in);
}

-(void) setBaseStatswithStrength:(double) strength_in withSpeed:(double) speed_in withEndurance:(double) endurance_in withCapacity:(double) capacity_in {
    dragon->set_base_stats(strength_in, speed_in, endurance_in, capacity_in);
}

-(int) maxGoldThatCanBeCarried {
    return dragon->max_gold_that_can_be_carried();
}

-(int) level {
    return dragon->get_level();
}

@end
