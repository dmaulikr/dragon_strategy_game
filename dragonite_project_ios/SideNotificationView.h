//
//  SideNotificationView.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 18.07.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideNotificationView : NSObject

@property UIView *view;
@property UILabel *label;
@property CAGradientLayer *gradient;
@property NSTimer *timer;

- (id)initWithFrame:(CGRect)frame onView:(UIView *)viewToPresentOn withText:(NSString *)text withStartingColor:(NSArray *)startingColorList withEndColor:(NSArray *)endingColorList withDuration:(NSTimeInterval)duration;
- (void)changeToFrame:(CGRect)frame;
- (void)disappear;
- (void)deleteNotificationAction; //starts the deletion process for this view

@end
