//
//  dragons.h
//  dragonite_project
//
//  Created by Utku Gürkan on 22.04.2016.
//  Copyright © 2016 X. All rights reserved.
//

#ifndef dragons_h
#define dragons_h

#include <iostream>
#include <utility>
#include <vector>
//#include <string>

//#include "path_and_skill.h"

class Archive;

enum Gender {female, male};
enum Dragon_Type {fire, water, wind, earth, other};

class Dragon_Stats {
public:
    
    double strength;
    double speed; //run forrest run
    double endurance;
    double capacity;

    Dragon_Stats(double strength_in, double speed_in, double endurance_in, double capacity_in);
    
    //Copy Constructor
    Dragon_Stats(const Dragon_Stats &stats_in);
    
    void operator+=(const Dragon_Stats &stats_in);
};

//Main Dragon class
class Dragon {
 
    friend Archive;
    
private:
    
    //Class and struct declerations
    /*struct Level_info {
        int experience_needed_to_level_up;
        Dragon_Stats stats_gained;
        
        Level_info(int experience_in, double strength_in,
                   double speed_in, double endurance_in, double capacity_in);
        
    }; */
    
protected:
    class Skill;
    //friend Skill;
    class Base_Stats_Skill;
    //friend Base_Stats_Skill;
    class Base_Stats_Multiplier;
    friend Base_Stats_Multiplier;
    class Base_Stats_Adder;
    friend Base_Stats_Adder;
    
    static std::vector<std::vector<Skill>> speed_path;
    static std::vector<std::vector<Skill>> strength_path;
    static std::vector<std::vector<Skill>> endurance_path;
    
    static std::vector<int> experience_needed_to_level_up; //holds the experience needed to level up at each level
    
    
    //contains the index of the highest level skill unlocked for each path.
    
    //should initialize to 0 when not lazy
    //*2194*094091*23875*1870398741023 (note to self)
    
    std::vector<int> skills_unlocked;
    
    Dragon_Stats initial_stats;
    Dragon_Stats base_stats;
    Dragon_Stats effective_stats;
    
    std::string name;
    double energy; //tiredness level.
    Dragon_Type type; //what's the type of the dragon
    Gender gender; //0 = female, 1 = male
    int level;
    int experience;
    int available_stat_points;
    int available_skill_points;
    int quests_completed; //number of quests completed by the dragon
    
    bool legendary;
    bool mythical;

    
public:
    
    //add energy and available_points to the constructors
    
    Dragon(const std::string &name_in, Dragon_Type type_in, Gender gender_in, double strength_in, double speed_in, double endurance_in, double capacity_in, int level_in = 1, int quests_completed_in = 0, bool legendary_in = false, bool mythical_in = false);
    
    Dragon(const std::string &name_in, Dragon_Type type_in, Gender gender_in, int level_in = 1, int quests_completed_in = 0, bool legendary_in = false, bool mythical_in = false);
    
    //Member functions
    void improve_stats(const Dragon_Stats &stats_gained);
    
    void level_up();
    
    void gain_experience(int exp_gained);
    
    void spend_energy(double energy_spent);
    
    void increase_energy(double energy_gained);
    
    double get_energy();

};


//God dragon. Only for testing purposes
class Dranxia: public Dragon {
    Dranxia(Gender gender_in, int level_in = 1);
};

#endif /* dragons_h */
