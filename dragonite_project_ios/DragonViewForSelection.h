//
//  DragonViewForQuestSelection.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.07.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OCDragon.h"

enum viewType {AvailableForQuest, NotAvailableForQuest, AvailableForBuildingSpringEntry, NotAvailableForBuildingSpringEntry};

@interface DragonViewForSelection : NSObject

@property UIView *containerView;
@property UIView *filter; //need to add a filter depending on the state of the view
@property UILabel *nameLabel;
@property UILabel *levelLabel;
@property UIImageView *imageView;
@property UIButton *hiddenButton;
@property UILabel *labelOnFilter;
@property OCDragon *dragon;
@property int index; /*index inside array  that holds multiple instances of this class*/
@property UIColor *colorForNormalState;
@property UIColor *colorForSelectedState;
@property enum viewType type;
@property NSDate *whenTheCountDownEnds;

- (id)initWithFrame:(CGRect)frame inside:(UIView *)parentView forDragon:(OCDragon *)dragon withNormalStateColor:(UIColor *)colorForNormalState withSelectedStateColor:(UIColor *)colorForSelectedState withType:(enum viewType)typeIn withIndex:(int)indexIn;
- (void)select;
- (void)deselect;
- (void)setTextForFilterLabel:(NSString *) text;

@end
