//
//  OCDragonStats.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 1.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCDragonStats.h"

@implementation OCDragonStats

- (id)initWithStrength:(int)strengthIn withSpeed:(int)speedIn withEndurance:(int)enduranceIn {
    self = [super init];
    if (self) {
        self.strength = strengthIn;
        self.speed = speedIn;
        self.endurance = enduranceIn;
    }
    return self;
}

@end
