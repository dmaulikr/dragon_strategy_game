//
//  OCBuilding.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 5.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCPlayer.h"
#import "Formulas.h"

enum OCBuildingType {OCMainBuilding, OCDragonsDen, OCTreasury, OCFountain, OCSpring}; /*should be the same order as we insert buildings to the buildings array for the first time */

@interface OCBuilding : NSObject

@property NSString *name;
@property NSString *description; //why did I have to synthesize this manually?
//@property NSArray *levelDescriptions; //Full of strings, 0 lvl description...
//...could be the general building info
@property NSString *imageName;
@property int level; //building lvl
@property int maxLevelAllowed; //If we assume an endless game, ignore, not the same as
//current max building lvl
@property enum OCBuildingType type;

//variables to calculate upgrade costs
@property double priceConstant;
@property int levelOffset;


- (id)initWithName:(NSString *)nameIn withImageName:(NSString *)imageNameIn withType:(enum OCBuildingType)typeIn;
- (void)applyEffect:(OCPlayer *)player;
- (NSString *)getGeneralInformation;
- (NSString *)getCurrentLevelInformation;
- (NSString *)getNextLevelInformation;
- (int)upgradeCost;
- (void)reset;

@end
