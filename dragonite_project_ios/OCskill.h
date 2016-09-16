//
//  OCskill.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 29.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCdragon.h"

//enum AffectedStat {strength, speed, endurance, capacity};


/*                              NOT BEING USED */
//
//
//

@interface OCSkill : NSObject

@property NSString *name;
@property NSString *explanation;
//@property int effectRate;
@property NSMutableArray *statsEffectRate; //0 means no effect since this is technically
//the adder implementation

-(id) initWithName:(NSString *) name_in withExplanation:(NSString *) explanation_in thatAffectsStrengthBy:(double) strength_in speedBy:(double) speed_in enduranceBy:(double) endurance_in;

-(void) activate:(OCDragon *) dragon; //implementation for the adder version will be on this base class


@end
