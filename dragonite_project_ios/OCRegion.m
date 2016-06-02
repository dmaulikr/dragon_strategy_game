//
//  OCRegion.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 31.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCRegion.h"

@implementation OCRegion

-(id) initWithImageName:(NSString *) region_image_in withDistanceFromBase:(int) distance_in withRegionNo:(int) region_idx {
    
    self = [super init];
    if (self)
    {
        self.imageName = region_image_in;
        self.distanceFromBase = distance_in;
        self.regionNumber = region_idx;
        self.explored = NO;
        
        self.questList = [[NSMutableArray alloc] init];
        self.buttonList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) generateQuestButtons:(NSMutableArray *) coordinates {
    
    for (unsigned int i = 0; i < [coordinates count]; i+=2) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(loadQuest) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake([[coordinates objectAtIndex:i] doubleValue], [[coordinates objectAtIndex:i+1] doubleValue], 20, 20); //change size vals
        
        //To make buttons round. Check if works with images!
        button.layer.cornerRadius = button.bounds.size.width/2;
        
        //[view addSubview:button];
        
        OCQuest *questPtr = [self.questList objectAtIndex:i/2];
        UIImage *buttonImage = [UIImage imageNamed:[questPtr questButtonImage]];
        [button setImage:buttonImage forState:UIControlStateNormal];
        
        [self.buttonList addObject:button];
    }
}

-(void) loadQuest {
    NSLog(@"heyy");
}

-(void) setImageView:(UIImageView *) imageView {
    imageView.image = [UIImage imageNamed: self.imageName]; //might need to change this
    
    for (UIButton *button in self.buttonList) {
        [imageView addSubview:button];
    }
}

-(void) placeButtonsOn:(UIView *) view {
    for (UIButton *button in self.buttonList) {
        [view addSubview:button];
    }
}

@end
