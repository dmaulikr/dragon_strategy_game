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

-(void) dragonGoesAt:(NSDate *) start_date_in toQuest:(int) quest_idx atRegion:(int) region_idx andComesBackAt:(NSDate *) end_date_in;

@end
