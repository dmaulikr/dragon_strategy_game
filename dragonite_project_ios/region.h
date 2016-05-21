//
//  maps.h
//  dragonite_project
//
//  Created by Utku Gürkan on 22.04.2016.
//  Copyright © 2016 X. All rights reserved.
//

#ifndef maps_h
#define maps_h

#include <iostream>
#include <vector>
#include "quest.h"

class Region {
private:
    std::vector<Quest> quest_list;
    std::string name;
    
public:
    
    Region(std::string name_in);
    
    void add_quest(Quest quest_in);
    
    Quest *get_quest(int i);
};

#endif /* maps_h */
