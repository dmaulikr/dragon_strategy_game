//
//  OCBuilding.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 5.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCPlayer.h"

enum OCBuildingType {OCMainBuilding, OCDragonsDen, OCTreasury, OCFountain};

@interface OCBuilding : NSObject

@property NSString *name;
@property NSMutableArray *levelDescriptions; //Full of strings, 0 lvl description...
//...could be the general building info
@property NSString *imageName;
@property int level;
@property int maxLevelAllowed; //If we assume an endless game, ignore
@property enum OCBuildingType type;


-(void) applyEffect:(OCPlayer *) player;

@end
