//
//  OCDragonQuestInfo.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 30.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCDragonQuestInfo.h"

@implementation OCDragonQuestInfo

- (void)dragonGoesAt:(NSDate *)startDateIn toQuest:(int)questIndex atRegion:(int)regionIndex andComesBackAt:(NSDate *)endDateIn {
    self.startDate = [startDateIn copy];
    self.questNo = questIndex;
    self.regionNo = regionIndex;
    self.endDate = [endDateIn copy];
}

@end
