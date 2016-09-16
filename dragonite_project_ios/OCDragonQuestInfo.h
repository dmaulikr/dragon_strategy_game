//
//  OCDragonQuestInfo.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 30.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDragonQuestInfo : NSObject

@property NSDate *startDate;
@property NSDate *endDate;
@property int regionNo; //index
@property int questNo; //index

- (void)dragonGoesAt:(NSDate *)startDateIn toQuest:(int)questIndex atRegion:(int)regionIndex andComesBackAt:(NSDate *)endDateIn;

@end
