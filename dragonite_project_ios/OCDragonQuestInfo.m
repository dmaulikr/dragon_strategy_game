//
//  OCDragonQuestInfo.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 30.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCDragonQuestInfo.h"

@implementation OCDragonQuestInfo

-(void) dragonGoesAt:(NSDate *) date_in to:(int) region_idx to:(int) quest_idx {
    self.startDate = [date_in copy];
    self.regionNo = region_idx;
    self.questNo = quest_idx;
}

@end
