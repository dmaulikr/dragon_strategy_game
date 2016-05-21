#include <cstdlib>
#include "dragon.h"


std::vector<int> Dragon::experience_needed_to_level_up;
//Also add derived dragons' static variables after you deal with Skill

//                              Dragon_Stats

Dragon_Stats::Dragon_Stats(double strength_in, double speed_in, double endurance_in, double capacity_in)
: strength{strength_in}, speed{speed_in}, endurance{endurance_in}, capacity{capacity_in} {}

Dragon_Stats::Dragon_Stats(const Dragon_Stats &stats_in)
: strength{stats_in.strength}, speed{stats_in.speed},
endurance{stats_in.endurance}, capacity{stats_in.capacity} {}

void Dragon_Stats::operator+=(const Dragon_Stats &stats_in) {
    strength += stats_in.strength;
    speed += stats_in.speed;
    endurance += stats_in.endurance;
    capacity += stats_in.capacity;
}


//                                  Dragon

Dragon::Dragon(const std::string &name_in, Dragon_Type type_in, Gender gender_in, double strength_in, double speed_in, double endurance_in, double capacity_in, int level_in, int quests_completed_in, bool legendary_in, bool mythical_in)
: name{name_in}, type{type_in}, level{level_in}, experience{0}, available_stat_points{0}, quests_completed{quests_completed_in}, energy{100},
gender{gender_in}, legendary{legendary_in}, mythical{mythical_in},
initial_stats(strength_in, speed_in, endurance_in, capacity_in),
base_stats(initial_stats), effective_stats(initial_stats) {}


Dragon::Dragon(const std::string &name_in, Dragon_Type type_in, Gender gender_in, int level_in, int quests_completed_in, bool legendary_in, bool mythical_in)
: name{name_in}, type{type_in}, level{level_in}, experience{0}, available_stat_points{0}, quests_completed{quests_completed_in}, energy{100},
gender{gender_in}, legendary{legendary_in}, mythical{mythical_in},
initial_stats(rand() % 4 + 4, rand() % 4 + 4, rand() % 4 + 4, rand() % 4 + 4),
base_stats(initial_stats), effective_stats(initial_stats) {}

void Dragon::improve_stats(const Dragon_Stats &stats_gained) {
    base_stats += stats_gained; //Implement this operator
    
    //call a function here to calculate the efficient stats
}

void Dragon::level_up() {
    experience -= experience_needed_to_level_up[level-1];
    //improve_stats(experience_needed_to_level_up[level-1].stats_gained);
    ++level;
}

void Dragon::gain_experience(int exp_gained) {
    experience += exp_gained;
    if (experience >= experience_needed_to_level_up[level-1])
        level_up();
}


void Dragon::spend_energy(double energy_spent) {
    energy -= energy_spent;
    if (energy < 0) energy = 0;
}


void Dragon::increase_energy(double energy_gained) {
    energy += energy_gained;
}

double Dragon::get_energy() {
    return energy;
}

