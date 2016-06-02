//
//  OCMultiplierSkill.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 30.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCMultiplierSkill.h"

@implementation OCMultiplierSkill

-(void) activate:(OCDragon *)dragon {
    dragon.effectiveStats.strength *= [[self.statsEffectRate objectAtIndex:0] doubleValue];
    dragon.effectiveStats.speed *= [[self.statsEffectRate objectAtIndex:1] doubleValue];
    dragon.effectiveStats.endurance *= [[self.statsEffectRate objectAtIndex:2] doubleValue];
    dragon.effectiveStats.capacity *= [[self.statsEffectRate objectAtIndex:3] doubleValue];
}

@end
