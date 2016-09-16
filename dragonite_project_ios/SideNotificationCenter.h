//
//  SideNotificationCenter.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 18.07.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SideNotificationView.h"

@interface SideNotificationCenter : NSObject

@property NSMutableArray *notificationViews;
@property int maxNumberOfNotifications;
@property NSArray *startingColorComponents; //Red, blue, green, alpha
@property NSArray *endingColorComponents;

@property int spaceBetweenViews;
@property CGSize viewSize;
@property CGPoint bottomCoordinate; //top point of the bottom notification
@property NSTimeInterval notificationDuration;

- (id)initWithMaxNumberOfNotifications:(int)number;
- (void)deleteNotificationAtIndex:(int)deletionIndex;
- (void)addNewNotificationWithText:(NSString *)text;

//Added later
@property UIView *viewToPresentOn;

@end
