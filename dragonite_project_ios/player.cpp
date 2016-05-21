#include "player.h"


Player::Player(const std::string &name_in, Gender gender_in)
: Character{name_in, gender_in, 1}, gold{0}, experience{0} {}

int Player::get_gold() {
    return gold;
}

int Player::get_experience() {
    return experience;
}

void Player::level_up() {
    experience -= experience_needed_to_level_up[level];
    ++level;
}

void Player::gain_experience(int exp_gained) {
    experience += exp_gained;
    if (experience >= experience_needed_to_level_up[level])
        level_up();
}

void Player::earn_gold(int gold_earned) {
    gold += gold_earned;
}

void Player::spend_gold(int gold_spent) {
    gold -= gold_spent;
}

void Player::update_dragon_energies() {
    for (unsigned int i = 0; i < dragons.size(); ++i) {
        if (dragons[i]->get_energy() < 100) dragons[i]->increase_energy(1); //change the number if needed
    }
}

void Player::add_new_dragon(Dragon* new_dragon) {
    dragons.push_back(new_dragon);
}

