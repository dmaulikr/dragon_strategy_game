//
//  Achievement.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 17.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCPlayer.h"

//enum AchievementType{Quest};

@interface OCAchievement : NSObject

@property NSString *title;
@property NSString *explanation;
@property BOOL unlocked;
//@property enum AchievementType type;
@property int tag;


- (id)initWithTitle:(NSString *)title_in withExplanation:(NSString *)explanation_in withTag:(int) tag_in;
- (BOOL)check:(OCPlayer *)player;

@end
