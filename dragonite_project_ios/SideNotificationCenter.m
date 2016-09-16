//
//  SideNotificationCenter.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 18.07.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "SideNotificationCenter.h"


@implementation SideNotificationCenter {
    int currentNumberOfNotifications;
}

- (id)initWithMaxNumberOfNotifications:(int)number {
    self = [super init];
    if (self)
    {
        self.maxNumberOfNotifications = number;
        currentNumberOfNotifications = 0;
        self.notificationViews = [[NSMutableArray alloc] init];
        
        
        //Set up NSNotificationCenter
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDeleteNotification:)
                                                     name:@"DeleteNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveAddNotification:)
                                                     name:@"AddNotification"
                                                   object:nil];
    }
    return self;
}

- (void) receiveDeleteNotification:(NSNotification *) notification {
    SideNotificationCenter *notificationToDelete = [notification object];
    for (int i = 0; i < [self.notificationViews count]; i += 1) {
        if (notificationToDelete == [self.notificationViews objectAtIndex:i]) {
            [self deleteNotificationAtIndex:i];
            break;
        }
    }
    
}

- (void) receiveAddNotification:(NSNotification *) notification {
    NSString *text = [notification object];
    [self addNewNotificationWithText:text];
}

- (void)deleteNotificationAtIndex:(int)deletionIndex {
    
    //delete the notification at deletionIndex
    [[self.notificationViews objectAtIndex:deletionIndex] disappear];
    
    for (int i = deletionIndex; i < currentNumberOfNotifications-1; ++i) {
        
        //move objects in the array
        [self.notificationViews replaceObjectAtIndex:i withObject:[self.notificationViews objectAtIndex:i+1]];
        [self.notificationViews replaceObjectAtIndex:i withObject:[self.notificationViews objectAtIndex:i+1]];
        
        //move down the notificationViews on the screen
        SideNotificationView *notification = [self.notificationViews objectAtIndex:i];
        CGRect newFrame = notification.view.frame;
        newFrame.origin.y += (self.spaceBetweenViews + self.viewSize.height);
        [notification changeToFrame:newFrame];
         
         /*CGRectMake(self.bottomCoordinate.x, (self.bottomCoordinate.y - (self.viewSize.height * (deletionIndex+1)) - self.spaceBetweenViews * deletionIndex), self.viewSize.width, self.viewSize.height)];*/
    }
    
    currentNumberOfNotifications -= 1;
}

- (void)addNewNotificationWithText:(NSString *)text {
    
    //if the center is full, delete the bottom most view
    if (currentNumberOfNotifications == self.maxNumberOfNotifications) {
        SideNotificationView *viewToDelete = [self.notificationViews objectAtIndex:0];
        [viewToDelete deleteNotificationAction];
        //[self deleteNotificationAtIndex:0];
    }
    
    SideNotificationView *newNotification = [[SideNotificationView alloc] initWithFrame:CGRectMake(self.bottomCoordinate.x, (self.bottomCoordinate.y - (self.viewSize.height * (currentNumberOfNotifications+1)) - self.spaceBetweenViews * currentNumberOfNotifications), self.viewSize.width, self.viewSize.height) onView:self.viewToPresentOn withText:text withStartingColor:self.startingColorComponents withEndColor:self.endingColorComponents withDuration:self.notificationDuration];
    
    //if the array doesn't have enough objects in it
    if ([self.notificationViews count] <= currentNumberOfNotifications)
        [self.notificationViews addObject:newNotification];
    else [self.notificationViews replaceObjectAtIndex:currentNumberOfNotifications withObject:newNotification];
    
    currentNumberOfNotifications += 1;
    
}

@end
