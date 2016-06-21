//
//  LoadingScreen_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "LoadingScreen_ViewController.h"

@interface LoadingScreen_ViewController ()

@end

@implementation LoadingScreen_ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.activityIndicator startAnimating];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Set region button coordinates for map view
    appDelegate.regionButtonCoordinates = [[NSArray alloc] initWithObjects:@50, @50, @250, @250, @450, @250, nil];
    
    
    //Set region infos
    appDelegate.regionList = [[NSMutableArray alloc] init];
    
    OCRegion *region = [[OCRegion alloc] initWithDistanceFromBase:200 withRegionNo:0];
    OCQuest *questPtr = [[OCQuest alloc] initWithDistanceFromBase:210 withDifficultyLevel:1 withRequiredDragonType:OCfire withDragonExperienceReward:5 atRegion:0 withIndex:0];
    [region.questList addObject:questPtr];
    OCQuest *questPtr2 = [[OCQuest alloc] initWithDistanceFromBase:500 withDifficultyLevel:10 withRequiredDragonType:OCwind withDragonExperienceReward:5 atRegion:0 withIndex:1];
    [region.questList addObject:questPtr2];
    
    //self.region.imageName = @"pokemon_dp_map.png";
    [region setImageInfoX:150 y:240 width:400 height:300];
    [region.questButtonCoordinates addObject:@30];
    [region.questButtonCoordinates addObject:@40];
    [region.questButtonCoordinates addObject:@70];
    [region.questButtonCoordinates addObject:@60];
    [appDelegate.regionList addObject:region];
    
    
    //Set achievements
    appDelegate.lastAchievementCheckDate = [NSDate date];
    OCAchievement *achievement1 = [[OCAchievement alloc] initWithTitle:@"7 Heads" withExplanation:@"Roar" withTag:0];
    OCAchievement *achievement2 = [[OCAchievement alloc] initWithTitle:@"5 Heads" withExplanation:@"Roar" withTag:1];
    appDelegate.achievementList = [[NSArray alloc] initWithObjects:achievement1, achievement2, nil];
    
    
    //Start timer
    NSTimer *mainTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCheck) userInfo:nil repeats:YES ];
    
    
    appDelegate.player = [[OCPlayer alloc] init];
    [appDelegate.player initPlayerWithName:@"Bob" withGender:OCCharactermale];
    
    OCDragon *dragon = [[OCDragon alloc] init];
    
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO];
    dragon.level = 3;
    dragon.name = @"Khalimus";
    dragon.experience = 50;
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCwind withStatsRange:4 ThatIsLegendary:NO];
    dragon.name = @"Zheltia";
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO];
    dragon.name = @"Jiekha";
    dragon.effectiveStats.strength = 500;
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO];
    dragon.name = @"Mumu";
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCwind withStatsRange:4 ThatIsLegendary:NO];
    dragon.name = @"Spitza";
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO];
    dragon.name = @"Ktaskia";
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCwind withStatsRange:4 ThatIsLegendary:NO];
    dragon.name = @"Uud";
    dragon.effectiveStats.strength = 100;
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    [self.activityIndicator stopAnimating];
    
}

- (void) viewDidAppear:(BOOL)animated {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    Map_ViewController *mapScene = [storyboard instantiateViewControllerWithIdentifier:@"Map_ViewController"];
    [self presentViewController:mapScene animated:YES completion:nil];
}

-(void) timerCheck {
    
    //quest end check
    for (OCDragon *dragon in appDelegate.player.dragonList) {
        if ( dragon.onQuest && ([[NSDate date] compare:dragon.questInfo.endDate] == NSOrderedDescending)) {
            OCRegion *region = [appDelegate.regionList objectAtIndex:dragon.questInfo.regionNo];
            OCQuest *quest = [region.questList objectAtIndex:dragon.questInfo.questNo];
            [quest finishQuest:dragon and:appDelegate.player];
        }
    }
    
    
    //dragon energy regen
    if (([[NSDate date] compare:[NSDate dateWithTimeInterval:60 sinceDate:appDelegate.player.lastEnergyUpdateDate]] == NSOrderedDescending)) {
        [appDelegate.player updateDragonEnergies];
    }
    
    
    //Work on this later!!!!!!
    
    //check for achievements every 5~ seconds
    if (([[NSDate date] compare:[NSDate dateWithTimeInterval:5 sinceDate:appDelegate.lastAchievementCheckDate]] == NSOrderedDescending)) {
        
        int unlockedAchievementCount = 0;
        OCAchievement *achievementUnlocked;
        for (OCAchievement *achievement in appDelegate.achievementList) {
            if (!achievement.unlocked && [achievement check:appDelegate.player] == YES) {
                achievement.unlocked = YES;
                ++unlockedAchievementCount;
                achievementUnlocked = achievement;
            }
        }
        if (unlockedAchievementCount == 1) {
            
            //Find the view controller on the top
            UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
            
            while (topController.presentedViewController) {
                topController = topController.presentedViewController;
            }
            
            
            self.achievementLabel = [[UILabel alloc] init];
            self.achievementLabel.frame = CGRectMake(0,  topController.view.frame.size.height*4/5, topController.view.frame.size.width, topController.view.frame.size.height*1/5);
            self.achievementLabel.backgroundColor = [UIColor yellowColor];
            self.achievementLabel.layer.borderColor = [UIColor orangeColor].CGColor;
            self.achievementLabel.layer.borderWidth = 2.0f;
            
            self.achievementLabel.text = [NSString stringWithFormat:@"You have unlocked %@", achievementUnlocked.title];
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.achievementLabel.attributedText];
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(18, text.length-18)];
            [self.achievementLabel setAttributedText: text];
            self.achievementLabel.textAlignment = NSTextAlignmentCenter;
            
            [topController.view addSubview:self.achievementLabel];
            NSTimer *achievementViewTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(closeAchievementNotification) userInfo:self.achievementLabel repeats:NO];

        }
        
        else if (unlockedAchievementCount > 1) {
            
            //Find the view controller on the top
            UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
            
            while (topController.presentedViewController) {
                topController = topController.presentedViewController;
            }
            
            
            self.achievementLabel = [[UILabel alloc] init];
            self.achievementLabel.frame = CGRectMake(0,  topController.view.frame.size.height*4/5, topController.view.frame.size.width, topController.view.frame.size.height*1/5);
            self.achievementLabel.backgroundColor = [UIColor yellowColor];
            self.achievementLabel.layer.borderColor = [UIColor orangeColor].CGColor;
            self.achievementLabel.layer.borderWidth = 2.0f;
            
            self.achievementLabel.text = [NSString stringWithFormat:@"You have unlocked %d new achievements", unlockedAchievementCount];
            self.achievementLabel.textAlignment = NSTextAlignmentCenter;
            
            [topController.view addSubview:self.achievementLabel];
            NSTimer *achievementViewTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(closeAchievementNotification) userInfo:self.achievementLabel repeats:NO];
        }
        
        //NSLog(@"checked for achievements");
        appDelegate.lastAchievementCheckDate = [NSDate date];
    }
    
    
    
    //NSLog(@"time...");
}

- (void)closeAchievementNotification {
    [self.achievementLabel removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
