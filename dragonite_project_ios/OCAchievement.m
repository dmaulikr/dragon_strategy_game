//
//  Achievement.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 17.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCAchievement.h"

@implementation OCAchievement

- (id)initWithTitle:(NSString *)title_in withExplanation:(NSString *)explanation_in withTag:(int) tag_in {
    
    self = [super init];
    if (self)
    {
        self.title = title_in;
        self.explanation = explanation_in;
        self.unlocked = NO;
        self.tag = tag_in;
    }
    return self;
}

- (BOOL)check:(OCPlayer *)player {
    switch (self.tag) {
            
        case 0: {
            if ([player.dragonList count] >= 7) {
                
                return YES;
            }
            break;
        }
        case 1: {
            if ([player.dragonList count] >= 5) {
                
                return YES;
            }
            break;
        }
        default:
            break;
    }
    
    return NO;
}

@end
