//
//  DragonViewForQuestSelection.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.07.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "DragonViewForSelection.h"

@implementation DragonViewForSelection

- (id)initWithFrame:(CGRect)frame inside:(UIView *)parentView forDragon:(OCDragon *)dragon withNormalStateColor:(UIColor *)colorForNormalState withSelectedStateColor:(UIColor *)colorForSelectedState withType:(enum viewType)typeIn withIndex:(int)indexIn {
    
    self = [super init];
    if (self) {
        
        //set the values
        self.colorForNormalState = colorForNormalState;
        self.colorForSelectedState = colorForSelectedState;
        self.type = typeIn;
        self.index = indexIn;
        self.dragon = dragon;
        
        self.containerView = [[UIView alloc] initWithFrame:frame];
        self.containerView.backgroundColor = colorForNormalState;
        
        //set the imageview
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height*4/5)];
        [self.containerView addSubview:self.imageView];
        self.imageView.image = [UIImage imageNamed:dragon.imageName]; //you need to do this after adding subview
        
        //create lvl label
        self.levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/5)];
        [self.levelLabel setBackgroundColor:[UIColor clearColor]];
        [self.levelLabel setText:[NSString stringWithFormat:@"%d", dragon.level]];
        self.levelLabel.textAlignment = NSTextAlignmentRight;
        [self.containerView addSubview:self.levelLabel];
        
        //create name label
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height*4/5, frame.size.width, frame.size.height/5)];
        [self.nameLabel setBackgroundColor:[UIColor clearColor]];
        [self.nameLabel setText:dragon.name];
        [self.nameLabel setTextColor:[UIColor whiteColor]];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.containerView addSubview:self.nameLabel];
        
        //create the hidden button
        if (typeIn == AvailableForQuest ||
            typeIn == AvailableForBuildingSpringEntry) {
            self.hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.hiddenButton addTarget:self
                                  action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
            self.hiddenButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            //self.hiddenButton.frame = CGRectMake(0, 0, 20, 20);
            [self.containerView addSubview:self.hiddenButton];
        }
        
        
        if (typeIn == NotAvailableForQuest) {
            //create the filter
            self.filter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            self.filter.backgroundColor = [UIColor blackColor];
            self.filter.alpha = 0.6;
            [self.containerView addSubview:self.filter];
            
            //add the label
            self.labelOnFilter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [self.labelOnFilter setBackgroundColor:[UIColor clearColor]];
            [self.labelOnFilter setText:@""];
            [self.labelOnFilter setTextColor:[UIColor whiteColor]];
            self.labelOnFilter.numberOfLines = 2;
            self.labelOnFilter.lineBreakMode = NSLineBreakByWordWrapping;
            self.labelOnFilter.textAlignment = NSTextAlignmentCenter;
            [self.containerView addSubview:self.labelOnFilter];

        }
        
        [parentView addSubview:self.containerView];
        
    }
    return self;
}

- (void)select {
    self.containerView.backgroundColor = self.colorForSelectedState;
    NSString *notificationText;
    switch (self.type) {
        case AvailableForQuest: {
            notificationText = @"SelectedDragonForQuest";
            break;
        }
          
        case AvailableForBuildingSpringEntry: {
            notificationText = @"SelectedDragonForBuildingSpring";
            break;
        }
            
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:notificationText
     object:[NSNumber numberWithInt:self.index]];
}

- (void)deselect {
    self.containerView.backgroundColor = self.colorForNormalState;
}

- (void)setTextForFilterLabel:(NSString *) text {
    self.labelOnFilter.text = text;
}

@end
