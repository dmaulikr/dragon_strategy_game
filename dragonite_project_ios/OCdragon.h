//
//  OCdragon.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>

enum OCDragonGender {OCDragonfemale, OCDragonmale};
enum OCDragonType {OCfire, OCwater, OCwind, OCearth, OCother};

@interface OCdragon : NSObject


//Constructor that initializes everything with certain values without default arguments
-(id)initDragonWithName:(NSString *) name_in withType:(enum OCDragonType) type_in withGender:(enum OCDragonGender) gender_in withStrength:(double) strength_in withSpeed:(double) speed_in withEndurance:(double) endurance_in withCapacity:(double) capacity_in withLevel:(int) level_in withNumberOfQuestsCompleted:(int) number_of_quests_completed_in isLegendary:(BOOL) legendary_in isMythical:(BOOL) mythical_in;

//Same thing for the default argument version
-(id)initDragonWithName:(NSString *) name_in withType:(enum OCDragonType) type_in withGender:(enum OCDragonGender) gender_in withStrength:(double) strength_in withSpeed:(double) speed_in withEndurance:(double) endurance_in withCapacity:(double) capacity_in;


//To generate with random stats, no defaults
-(id)initRandomDragonWithName:(NSString *) name_in withType:(enum OCDragonType) type_in withGender:(enum OCDragonGender) gender_in withLevel:(int) level_in withNumberOfQuestsCompleted:(int) number_of_quests_completed_in isLegendary:(BOOL) legendary_in isMythical:(BOOL) mythical_in;

//I like defaults
-(id)initRandomDragonWithName:(NSString *) name_in withType:(enum OCDragonType) type_in withGender:(enum OCDragonGender) gender_in;

//Destructor
-(void) dealloc;

-(void)improveStatsByStrength:(double) strength_in Speed:(double) speed_in Endurance:(double) endurance_in Capacity:(double) capacity_in;

-(void)levelUp;

-(void)gainExperienceOf:(int) exp_gained;

-(void)spendEnergy:(double) energy_spent;

-(void)increaseEnergy:(double) energy_gained;

-(double)getEnergy;

@end
