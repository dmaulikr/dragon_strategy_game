//
//  quests.h
//  dragonite_project
//
//  Created by Utku Gürkan on 22.04.2016.
//  Copyright © 2016 X. All rights reserved.
//

#ifndef quests_h
#define quests_h

#include <iostream>

#include "dragon.h"
#include "player.h"


//Some of the quests probably require certain dragon jobs and numbers.
//maybe even specific requirements for each stat
struct Dragon_Requirement {
    Dragon_Type type;
    //int energy;
    int level;
};

struct Quest_Prize {
    std::vector<Dragon> award_dragons;
    int gold;
    int player_experience;
    int dragon_experience;
    
    Quest_Prize(std::vector<Dragon> award_dragons_in, int gold_in,
                int player_experience_in, int dragon_experience_in);
};

class Quest {
    std::vector<Dragon_Requirement> dragon_requirement_list; //it might be
    //tricky to check the requirements. we should probably show the requirements and available
    //dragons and the player should place the dragons he wants below each requirement

    Quest_Prize prize;
    std::string name;
    std::string quest_explanation;
    int distance_from_base;
    int difficulty;
    int required_player_level;
    int required_energy; //probably different for each dragon---nope nvm
    int required_gold;
    
    //int quest_state; //-1 = player hasn't tried, 0 = failed, 1 = yeayy :)!
    
    //bool repeatable; //can the player do this more than once?
    
    //we might add these later
    //bool daily; //daily quest?
    //bool weekly; //weekly quest?
    
public:
    
    Quest(std::string name_in, std::string explanation_in, int distance_from_base_in, int difficulty_in,
          int required_player_level_in, int required_energy_in, int required_gold_in, int prize_gold_in,
          int prize_player_experience_in, int prize_dragon_experience_in,
          std::vector<Dragon> award_dragons_in = std::vector<Dragon>() );
    
    void do_quest(std::vector<Dragon*> dragons, Player *player); //pointing at the indices of the player dragon vector?
    
};

#endif /* quests_h */
