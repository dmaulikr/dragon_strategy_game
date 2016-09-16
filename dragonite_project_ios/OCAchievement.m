//
//  Achievement.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 17.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCAchievement.h"

@implementation OCAchievement

- (id)initWithTitle:(NSString *)titleIn withExplanation:(NSString *)explanationIn withTag:(int)tagIn isVisible:(BOOL)visibleIn {
    self = [super init];
    if (self) {
        self.title = titleIn;
        self.explanationMainBody = explanationIn;
        self.unlocked = NO;
        self.tag = tagIn;
        self.isVisible = visibleIn;
    }
    return self;
}

- (NSString *)getNotificationText {
    return [NSString stringWithFormat:@"You have unlocked %@", self.title];
}

- (BOOL)check:(OCPlayer *)player {
    
    BOOL progressMade = NO;
    switch (self.tag) {
        
        //total number of quests completed
        case 0: {
            int requiredQuestTotal = 2 * self.level; //Formula
            while (player.totalNumberOfQuestsCompleted >= requiredQuestTotal) {
                progressMade = YES;
                self.level += 1;
                requiredQuestTotal = 2 * self.level; //Formula
            }
            break;
        }
        //number of different quests completed
        case 1: {
            int requiredQuestTotal = 2 * self.level; //Formula
            while (player.numberOfDifferentQuestsCompleted >= requiredQuestTotal) {
                progressMade = YES;
                self.level += 1;
                requiredQuestTotal = 2 * self.level; //Formula
            }
            break;
        }
            
        //total number of (regular) dragons found
        case 2: {
            int requiredDragonTotal = 2 * self.level; //Formula
            while (player.numberOfDragonsFound >= requiredDragonTotal) {
                progressMade = YES;
                self.level += 1;
                requiredDragonTotal = 2 * self.level; //Formula
            }
            break;
        }
            
        //total number of mythical dragons discovered
        case 3: {
            int requiredDragonTotal = 2 * self.level; //Formula
            while (player.numberOfMythicalDragonsDiscovered >= requiredDragonTotal) {
                progressMade = YES;
                self.level += 1;
                requiredDragonTotal = 2 * self.level; //Formula
            }
            break;
        }
           
        default:
            break;
    }
    
    return progressMade;
}

- (void)unlock {
    
}

@end
