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
@property int regionNo; //index
@property int questNo; //index

-(void) dragonGoesAt:(NSDate *) date_in to:(int) region_idx to:(int) quest_idx;

@end
