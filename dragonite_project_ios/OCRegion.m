//
//  OCRegion.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 31.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCRegion.h"

@implementation OCRegion

-(void) generateQuestButtons:(NSMutableArray *) coordinates {
    
    for (unsigned int i = 0; i < [coordinates count]; i+=2) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        //[button setTitle:@"Show View" forState:UIControlStateNormal];
        
        button.frame = CGRectMake([[coordinates objectAtIndex:i] doubleValue], [[coordinates objectAtIndex:i+1] doubleValue], 160.0, 40.0); //change size vals
        
        //[view addSubview:button];
    }
}

-(void) setView:(UIView *) view {
    
}

@end
