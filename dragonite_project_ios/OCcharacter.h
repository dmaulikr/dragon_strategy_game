//
//  OCcharacter.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>

enum OCCharacterGender {OCCharacterfemale, OCCharactermale};

@interface OCCharacter : NSObject

@property NSString *name;
@property enum OCCharacterGender gender;
@property int level;

-(id) initCharacterWithName:(NSString *) name_in withGender:(enum OCCharacterGender) gender_in
                  withLevel:(int) level_in;

@end
