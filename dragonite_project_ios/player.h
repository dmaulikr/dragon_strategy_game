//
//  player.h
//  dragonite_project
//
//  Created by Utku Gürkan on 22.04.2016.
//  Copyright © 2016 X. All rights reserved.
//

#ifndef player_h
#define player_h

#include <iostream>
#include <vector>
//#include <string>
#include "character.h"
#include "dragon.h"
//#include "quest.h"

//class Archive;
class Quest;

class Player: public Character {
    
    //friend Archive;
    friend Quest;
    
private:
    std::vector<int> experience_needed_to_level_up;
    std::vector<bool> dragons_available; //some are at the quest, some aren't etc.
    int gold;
    int experience;
    
public:
    
    Player(const std::string &name_in, Gender gender_in);
    
    int get_gold();
    
    int get_experience();
    
    void level_up();
    
    void gain_experience(int exp_gained);
    
    void earn_gold(int gold_earned);
    
    void spend_gold(int gold_spent);
    
    void update_dragon_energies();
    
    void add_new_dragon(Dragon* new_dragon);
};

#endif /* player_h */
