//
//  OCBuilding.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 5.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCBuilding.h"

@implementation OCBuilding

@synthesize description;

- (id)initWithName:(NSString *)nameIn withImageName:(NSString *)imageNameIn withType:(enum OCBuildingType)typeIn {
    self = [super init];
    if (self) {
        self.name = nameIn;
        self.imageName = imageNameIn;
        self.type = typeIn;
        self.level = 1;
        
        //self.description = [[NSString alloc] init];
    }
    return self;
}



- (void)applyEffect:(OCPlayer *)player {
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

- (NSString *)getGeneralInformation {
    return self.description;
}

- (NSString *)getCurrentLevelInformation {
    if (self.type == OCMainBuilding) {
        return [NSString stringWithFormat:@"max building level:%d", self.level];
    }
    else if (self.type == OCDragonsDen) {
        return [NSString stringWithFormat:@"number of dragons allowed:%d",
                [Formulas dragonsDenDragonCapacityForLevel:self.level]];
    }
    else if (self.type == OCTreasury) {
        return [NSString stringWithFormat:@"gold limit:%d",
                [Formulas treasuryGoldCapacityForLevel:self.level]];
    }
    else if (self.type == OCFountain) {
        
    }
    else if (self.type == OCSpring) {
        
    }
    
    return @"error";
}

- (NSString *)getNextLevelInformation {
    if (self.type == OCMainBuilding) {
        return [NSString stringWithFormat:@"max building level:%d", self.level+1];
    }
    else if (self.type == OCDragonsDen) {
        return [NSString stringWithFormat:@"number of dragons allowed:%d",
                [Formulas dragonsDenDragonCapacityForLevel:self.level+1]];
    }
    else if (self.type == OCTreasury) {
        return [NSString stringWithFormat:@"gold limit:%d",
                [Formulas treasuryGoldCapacityForLevel:self.level+1]];
    }
    else if (self.type == OCFountain) {
        
    }
    else if (self.type == OCSpring) {
        
    }
    
    return @"error";
}

- (int)upgradeCost {
    return self.priceConstant * 6.0 * 42.0 * pow(1.7, self.levelOffset);
}

/*- (void)reset {
    self.level = 1;
    [self applyEffect:<#(OCPlayer *)#>]
}*/

@end
