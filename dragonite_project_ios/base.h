//
//  base.h
//  dragonite_project
//
//  Created by Utku Gürkan on 24.04.2016.
//  Copyright © 2016 X. All rights reserved.
//

#ifndef base_h
#define base_h

//#include <iostream>
#include <utility>
#include <vector>

enum Building_Type {Dragons_Den, Training_Camp}; //assign building types index numbers so
//that we can use them to look up; start from 0

class Base {
    
    class Building {};
    class Building_Training_Camp: public Building {};
    
    class Building_Info{}; //to let user what each building does
    //and show an image and stuff
    
    static std::vector<Building_Info> building_info_list;
    
    /*oook so, we probably don't wanna have more than one
     buildings of certain types, but we do wanna have multiple
     of some types. Seems like the easiest solution is have
     two vectors; one contains how many buildings in total
     allowed per base level, the other one contains how many of certain type is allowed for each level. (0 allowed for
     some types initially)
     
     */
    
    static std::vector<int> max_number_of_buildings_allowed_for_each_level;
    
    //An unordered map would be easier but memory is probably important.
    static std::vector<std::vector<int>> certain_types_of_buildings_allowed_for_each_level;
    
    
    std::vector<Building*> buildings;
    
    std::pair<int, int> coordinates; //where on the map;
    //do we even want a visual map?
    
    int level;
    //int located_map_number;
    //bool used; //is based being used/conquered or whatever?
    
public:
    void add_new_building(Building_Type new_building_type);
    
};

#endif /* base_h */
