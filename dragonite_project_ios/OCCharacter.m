//
//  OCcharacter.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCCharacter.h"

@implementation OCCharacter

-(id) initCharacterWithName:(NSString *) name_in withGender:(enum OCCharacterGender) gender_in withLevel:(int) level_in{
    self = [super init];
    if (self)
    {
        self.name = [name_in copy];
        self.gender = gender_in;
        self.level = level_in;
    }
    return self;
}

@end
