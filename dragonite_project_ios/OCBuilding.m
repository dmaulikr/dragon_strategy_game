//
//  OCBuilding.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 5.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCBuilding.h"

@implementation OCBuilding


-(void) applyEffect:(OCPlayer *) player {
    if (self.type == OCMainBuilding) {
        player.maxBuildingLevel = self.level;
    }
    else if (self.type == OCDragonsDen) {
        
    }
    else if (self.type == OCTreasury) {
        
    }
    else if (self.type == OCFountain) {
        
    }
    else if (self.type == OCSpring) {
        
    }
    
    //...
}

@end
