//
//  OCcharacter.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCcharacter.h"
#import "character.h"

@interface OCcharacter() {
    Character *character; //wrapped object
}

@end

@implementation OCcharacter

-(id) initCharacterWithName:(NSString *) name_in withGender:(enum OCCharacterGender) gender_in withLevel:(int) level_in{
    self = [super init];
    if (self)
    {
        character = new Character(std::string([name_in UTF8String]), (Gender)gender_in, level_in);
        if (!character) self = nil;
    }
    return self;
}

- (void)dealloc {
    delete character;
}

-(NSString *) getName {
    return [NSString stringWithUTF8String:(character->get_name()).c_str()];
}

-(int) getLevel {
    return character->get_level();
}

@end
