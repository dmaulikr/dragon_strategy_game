#include "quest.h"

Quest_Prize::Quest_Prize(std::vector<Dragon> award_dragons_in, int gold_in,
                         int player_experience_in, int dragon_experience_in)
:award_dragons{award_dragons_in}, gold{gold_in}, player_experience{player_experience_in}, dragon_experience{dragon_experience_in} {}

Quest::Quest(std::string name_in, std::string explanation_in, int distance_from_base_in, int difficulty_in,
             int required_player_level_in, int required_energy_in, int required_gold_in, int prize_gold_in,
             int prize_player_experience_in, int prize_dragon_experience_in,
             std::vector<Dragon> award_dragons_in)
: name{name_in}, quest_explanation{explanation_in}, distance_from_base{distance_from_base_in}, difficulty{difficulty_in},
required_player_level{required_player_level_in}, required_energy{required_energy_in}, required_gold{required_gold_in},
prize(award_dragons_in, prize_gold_in, prize_player_experience_in, prize_dragon_experience_in) {}


void Quest::do_quest(std::vector<Dragon*> dragons, Player *player) {
    
    if (/*figure out if success or not*/ 0) {
        
    }
    
    else {
        player->gold += prize.gold;
        player->experience += prize.player_experience;
        for (unsigned int i = 0; i < dragons.size(); ++i) {
            dragons[i]->gain_experience(prize.dragon_experience);
            dragons[i]->spend_energy(required_energy);
        }
    }
    
    
    
}