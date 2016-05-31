//
//  OCQuest.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 30.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDragon.h"
#import "OCPlayer.h"
#import <math.h>

@interface OCQuest : NSObject

@property NSString *name;
@property NSString *explanation;
@property double distanceFromBase;
@property int difficultyLevel;
@property int prizeGold;
@property int prizeDragonExperience;

-(void) doQuest:(OCDragon *) dragon and:(OCPlayer *) player;
-(int) successRate0To100:(OCDragon *) dragon;
-(double) successRate0To1:(OCDragon *)dragon;

@end
