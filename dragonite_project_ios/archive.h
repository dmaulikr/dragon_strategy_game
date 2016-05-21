//
//  archive.h
//  dragonite_project
//
//  Created by Utku Gürkan on 22.04.2016.
//  Copyright © 2016 X. All rights reserved.
//

#ifndef archive_h
#define archive_h

#include <iostream>
#include "dragon.h"
#include "player.h"
#include "region.h"
#include "quest.h"
#include "base.h"

//contains all the game data
class Archive {
    
    
    
    
    
public:
    
    //move back to privates
    std::vector<Region> regions;
    Player player;
    
    Archive(std::string player_name, Gender player_gender);
    
    //change this to whatever you need
    void set_up();
    
    
};

#endif /* archive_h */
