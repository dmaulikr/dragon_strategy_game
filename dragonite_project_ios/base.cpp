#include "base.h"

void Base::add_new_building(Building_Type new_building_type) {
    switch (new_building_type) {
        case Training_Camp: {
            Building *new_building = new Building_Training_Camp;
            buildings.push_back(new_building);
            break;
        }
            
        default:
            break;
    }
}
