#include "archive.h"

Archive::Archive(std::string player_name, Gender player_gender)
: player(player_name, player_gender) {}

void Archive::set_up() {
    
    Dragon::experience_needed_to_level_up.emplace_back(100);
    
    regions.emplace_back("Region_1");
    regions[0].add_quest(Quest("Quest_1", "Gotta start somewhere", 50, 1, 1, 10, 0, 10, 20, 20));
}