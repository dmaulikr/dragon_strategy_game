//
//  OCDragonStats.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 1.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDragonStats : NSObject

@property double strength;
@property double speed;
@property double endurance;
@property double capacity;

-(id) initWithStrength:(double) strength_in withSpeed:(double) speed_in withEndurance:(double) endurance_in withCapacity:(double) capacity_in;

@end
