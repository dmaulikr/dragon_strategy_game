//
//  mythicalDragonCell.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.08.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "mythicalDragonCell.h"

@implementation mythicalDragonCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor yellowColor];
        
        /*self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.imageView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_imageView);
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_imageView]|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
    */}
    return self;
}

@end
