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
    dragon.effectiveStrength *= [[self.statsEffectRate objectAtIndex:0] doubleValue];
    dragon.effectiveSpeed *= [[self.statsEffectRate objectAtIndex:1] doubleValue];
    dragon.effectiveEndurance *= [[self.statsEffectRate objectAtIndex:2] doubleValue];
    dragon.effectiveCapacity *= [[self.statsEffectRate objectAtIndex:3] doubleValue];
}

@end
