//
//  path_and_skills.h
//  dragonite_project
//
//  Created by Utku Gürkan on 23.04.2016.
//  Copyright © 2016 X. All rights reserved.
//

#ifndef path_and_skills_h
#define path_and_skills_h

#include <iostream>
#include "dragon.h"

enum Stats_Type {strength, speed, intelligence, agility,
    endurance, capacity, team_work_skills, size};

enum Skill_Type {Base_Stats_Adder, Base_Stats_Multiplier};

class Dragon::Skill {
    
protected:
    std::string name;
    std::string explanation;
    Skill_Type type;
    
public:
    virtual void activate(Dragon *dragon) const = 0;    
};


//Abstract Class
//A Skill that affects base_stats of a Dragon
class Dragon::Base_Stats_Skill: public Dragon::Skill {
    
protected:
    std::vector<Stats_Type> affected_base_stats;
};

//A Skill that multiplies base_stats of a Dragon by certain rates and adds to effective_stats
class Dragon::Base_Stats_Multiplier: public Dragon::Base_Stats_Skill {
private:
    std::vector<double> effect_rates;
    
public:
    void activate(Dragon *dragon);
};

//A Skill that adds values to effective_stats of a Dragon
class Dragon::Base_Stats_Adder: public Dragon::Base_Stats_Skill {
private:
    std::vector<double> effect_values;
    
public:
    void activate(Dragon *dragon);
};

#endif /* path_and_skills_h */
