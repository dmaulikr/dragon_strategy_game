//
//  OCDragonStats.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 1.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDragonStats : NSObject

@property int strength;
@property int speed;
@property int endurance;

- (id)initWithStrength:(int)strengthIn withSpeed:(int)speedIn withEndurance:(int)enduranceIn;

@end
