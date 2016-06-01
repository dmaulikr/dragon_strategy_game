//
//  OCDragonStats.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 1.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCDragonStats.h"

@implementation OCDragonStats

-(id) initWithStrength:(double) strength_in withSpeed:(double) speed_in withEndurance:(double) endurance_in withCapacity:(double) capacity_in {
    self = [super init];
    if (self)
    {
        self.strength = strength_in;
        self.speed = speed_in;
        self.endurance = endurance_in;
        self.capacity = capacity_in;
    }
    return self;
}

@end
