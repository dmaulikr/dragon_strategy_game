//
//  OCskill.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 29.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCskill.h"

@implementation OCSkill

-(id) initWithName:(NSString *) name_in withExplanation:(NSString *) explanation_in thatAffectsStrengthBy:(double) strength_in speedBy:(double) speed_in enduranceBy:(double) endurance_in capacityBy:(double) capacity_in {
    
    self = [super init];
    if (self) {
        
        //this might cause problems. be sure to check
        self.name = [name_in copy];
        self.explanation = [explanation_in copy];
        //self.effectRate = rate_in;
        self.statsEffectRate = [NSMutableArray arrayWithObjects: [NSNumber numberWithDouble: strength_in], [NSNumber numberWithDouble: speed_in], [NSNumber numberWithDouble: endurance_in], [NSNumber numberWithDouble: capacity_in], nil];
        
    }
    return self;
}


//Adder version
-(void) activate:(OCDragon *) dragon {
    
    //CHECK if the getter works like this!!!!!
    dragon.effectiveStats.strength += [[self.statsEffectRate objectAtIndex:0] doubleValue];
    dragon.effectiveStats.speed += [[self.statsEffectRate objectAtIndex:1] doubleValue];
    dragon.effectiveStats.endurance += [[self.statsEffectRate objectAtIndex:2] doubleValue];
    dragon.effectiveStats.capacity += [[self.statsEffectRate objectAtIndex:3] doubleValue];
}

@end
