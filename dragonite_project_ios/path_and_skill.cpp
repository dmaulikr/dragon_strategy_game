#include "path_and_skill.h"

//#include <iostream>
//#include "dragons.h"

void Base_Stats_Multiplier::activate(Dragon *dragon) {
    for (unsigned int i = 0; i < effect_rates.size(); ++i) {
        switch (affected_base_stats[i]) {
                
            case strength: {
                dragon->effective_stats.strength += dragon->base_stats.strength * effect_rates[i];
                break;
            }
                
            case speed: {
                dragon->effective_stats.speed += dragon->base_stats.speed * effect_rates[i];
                break;
            }
                
            case endurance: {
                dragon->effective_stats.endurance += dragon->base_stats.endurance * effect_rates[i];
                break;
            }
                
            case capacity: {
                dragon->effective_stats.capacity += dragon->base_stats.capacity * effect_rates[i];
                break;
            }
                
            default: {
                std::cerr << "Unrecognized stats type detected in Base_Stats_Multiplier-activate" << '\n';
                exit(1);
            }
                
        }//switch
    }//for
}


void Base_Stats_Adder::activate(Dragon *dragon) {
    for (unsigned int i = 0; i < effect_values.size(); ++i) {
        switch (affected_base_stats[i]) {
                
            case strength: {
                dragon->effective_stats.strength += effect_values[i];
                break;
            }
                
            case speed: {
                dragon->effective_stats.speed += effect_values[i];
                break;
            }
                
            case endurance: {
                dragon->effective_stats.endurance += effect_values[i];
                break;
            }
                
            case capacity: {
                dragon->effective_stats.capacity += effect_values[i];
                break;
            }
                
            default: {
                std::cerr << "Unrecognized stats type detected in Base_Stats_Adder-activate" << '\n';
                exit(1);
            }
                
        }//switch
    }//for
}

