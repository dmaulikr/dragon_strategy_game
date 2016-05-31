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

int Dragon::get_level() {
    return level;
}


double Dragon::get_initial_strength() {
    return initial_stats.strength;
}

double Dragon::get_initial_speed() {
    return initial_stats.speed;
}

double Dragon::get_initial_endurance() {
    return initial_stats.endurance;
}

double Dragon::get_initial_capacity() {
    return initial_stats.capacity;
}


double Dragon::get_base_strength() {
    return base_stats.strength;
}

double Dragon::get_base_speed() {
    return base_stats.speed;
}

double Dragon::get_base_endurance() {
    return base_stats.endurance;
}

double Dragon::get_base_capacity() {
    return base_stats.capacity;
}


double Dragon::get_effective_strength() {
    return effective_stats.strength;
}

double Dragon::get_effective_speed() {
    return effective_stats.speed;
}

double Dragon::get_effective_endurance() {
    return effective_stats.endurance;
}

double Dragon::get_effective_capacity() {
    return effective_stats.capacity;
}


void Dragon::set_initial_strength(double val) {
    initial_stats.strength = val;
}

void Dragon::set_initial_speed(double val) {
    initial_stats.speed = val;
}

void Dragon::set_initial_endurance(double val) {
    initial_stats.endurance = val;
}

void Dragon::set_initial_capacity(double val) {
    initial_stats.capacity = val;
}


void Dragon::set_base_strength(double val) {
    base_stats.strength = val;
}

void Dragon::set_base_speed(double val) {
    base_stats.speed = val;
}

void Dragon::set_base_endurance(double val) {
    base_stats.endurance = val;
}

void Dragon::set_base_capacity(double val) {
    base_stats.capacity = val;
}


void Dragon::set_effective_strength(double val) {
    effective_stats.strength = val;
}

void Dragon::set_effective_speed(double val) {
    effective_stats.speed = val;
}

void Dragon::set_effective_endurance(double val) {
    effective_stats.endurance = val;
}

void Dragon::set_effective_capacity(double val) {
    effective_stats.capacity = val;
}


void Dragon::set_initial_stats(double strength_in, double speed_in, double endurance_in, double capacity_in) {
    initial_stats.strength = strength_in;
    initial_stats.speed = speed_in;
    initial_stats.endurance = endurance_in;
    initial_stats.capacity = capacity_in;
}

void Dragon::set_base_stats(double strength_in, double speed_in, double endurance_in, double capacity_in) {
    base_stats.strength = strength_in;
    base_stats.speed = speed_in;
    base_stats.endurance = endurance_in;
    base_stats.capacity = capacity_in;
}

int Dragon::max_gold_that_can_be_carried() {
    //Fix this
    return 0;
}

