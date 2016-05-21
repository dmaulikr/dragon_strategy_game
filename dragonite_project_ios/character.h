//
//  character.h
//  dragonite_project
//
//  Created by Utku Gürkan on 23.04.2016.
//  Copyright © 2016 X. All rights reserved.
//

#ifndef character_h
#define character_h

#include <iostream>
#include <vector>
//#include <string>
#include "dragon.h"

class Character {
    
protected:
    std::vector<Dragon*> dragons;
    std::string name;
    int level;
    
    Gender gender; //if we want to have a picture for the player, we might use this
    // 0 female, 1 male
    
    
public:
    
    Character(){}
    
    Character(const std::string &name_in, Gender gender_in, int level_in)
    : name{name_in}, gender{gender_in}, level{level_in} {}
    
    std::string get_name();
    
    int get_level();
};

#endif /* character_h */
