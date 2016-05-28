//
//  OCplayer.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCplayer.h"
#import "player.h"

@interface OCPlayer() {
    Player *player;
}

@end

@implementation OCPlayer

-(id) initPlayerWithName:(NSString *) name_in withGender:(enum OCCharacterGender) gender_in {
    self = [super init];
    if (self)
    {
        player = new Player(std::string([name_in UTF8String]), (Gender)gender_in);
        if (!player) self = nil;
    }
    return self;
}

- (void)dealloc {
    delete player;
}

-(int) getGold {
    return player->get_gold();
}

-(int) getExperience {
    return player->get_experience();
}

-(void) levelUp {
    player->level_up();
}

-(void) gainExperience:(int) exp_gained {
    player->gain_experience(exp_gained);
}

-(void) earnGold:(int) gold_earned {
    player->earn_gold(gold_earned);
}

-(void) spendGold:(int) gold_spent {
    player->spend_gold(gold_spent);
}

-(void) updateDragonEnergies {
    player->update_dragon_energies();
}

-(void) addNewDragon:(OCDragon *) new_dragon {
    //player->add_new_dragon([new_dragon getWrappedDragon]);
}

@end
