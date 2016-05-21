//
//  building.h
//  dragonite_project
//
//  Created by Utku Gürkan on 24.04.2016.
//  Copyright © 2016 X. All rights reserved.
//

#ifndef building_h
#define building_h

#include "base.h"

class Base::Building {
    //unsigned int slot_number; //where in the base
    // (which index of the building vector)
    
    Building_Type type;
}

class Base::Dragons_Den{}; //Dragons' Den, how many dragons can you have
class Base::Building_Training_Camp{};
class Base::Fountain{}; //Increases energy regen, find a better name
class Base::Blacksmith{}; //Makes items that increase strength

#endif /* building_h */
