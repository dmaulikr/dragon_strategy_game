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

/* list of tags and what they are

0 = complete x number of quests
1 = complete x number of different quests
 
 */

@interface OCAchievement : NSObject

@property NSString *title;
@property NSString *explanationMainBody;
@property BOOL unlocked;
//@property enum AchievementType type;
@property int tag;

@property BOOL isVisible;
@property int level;
@property int maxLevel;
//@property int helperVariableInt;
//@property double helperVariableDouble;
//@property NSString *explanationHelperString;

//@property OCAchievement *previousAchievement;
//@property OCAchievement *nextAchievement;
//@property int indexInList; //0 = bronze, 1 = silver, 2 = gold maybe?

- (id)initWithTitle:(NSString *)titleIn withExplanation:(NSString *)explanationIn withTag:(int) tagIn isVisible:(BOOL)visibleIn;
- (NSString *)getExplanation;
- (NSString *)getNotificationText;
- (BOOL)check:(OCPlayer *)player;
- (void)unlock;

@end
