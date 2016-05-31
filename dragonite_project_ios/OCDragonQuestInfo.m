//
//  OCDragonQuestInfo.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 30.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCDragonQuestInfo.h"

@implementation OCDragonQuestInfo

-(void) dragonGoesAt:(NSDate *) start_date_in toQuest:(int) quest_idx atRegion:(int) region_idx andComesBackAt:(NSDate *) end_date_in {
    self.startDate = [start_date_in copy];
    self.questNo = quest_idx;
    self.regionNo = region_idx;
    self.endDate = [end_date_in copy];
}

@end
