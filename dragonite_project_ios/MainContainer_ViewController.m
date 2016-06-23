//
//  MainContainer_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 23.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "MainContainer_ViewController.h"

@interface MainContainer_ViewController ()

@end

@implementation MainContainer_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.mapView = [storyboard instantiateViewControllerWithIdentifier:@"Map_ViewController"];
    self.baseView = [storyboard instantiateViewControllerWithIdentifier:@"Base_ViewController"];
    
    
    [self addChildViewController:self.mapView];
    self.mapView.view.frame = CGRectMake(0, self.topBoundaryImage.frame.size.height, self.view.frame.size.width, self.bottomBoundaryImage.frame.origin.y - self.topBoundaryImage.frame.size.height);
    [self.view addSubview:self.mapView.view];
    
    [self.mapView didMoveToParentViewController:self];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setBarContents];
    
    [self.view bringSubviewToFront:self.bottomBoundaryImage];
    [self.view bringSubviewToFront:self.currentChildViewLabel];
    [self.view bringSubviewToFront:self.changeChildButton];
    [self.view bringSubviewToFront:self.dragonsButton];
    
    
    
    NSTimer *mainTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCheck) userInfo:nil repeats:YES ];
    
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

- (void)viewWillAppear:(BOOL)animated {
    self.dragonLabel.text = [NSString stringWithFormat:@"%d/%d", [appDelegate.player numberOfDragonsAvailable], (int)[appDelegate.player.dragonList count] ];
}

-(void) timerCheck {
    
    [self setBarContents];
    
    //quest end check
    for (OCDragon *dragon in appDelegate.player.dragonList) {
        if ( dragon.onQuest && ([[NSDate date] compare:dragon.questInfo.endDate] == NSOrderedDescending)) {
            OCRegion *region = [appDelegate.regionList objectAtIndex:dragon.questInfo.regionNo];
            OCQuest *quest = [region.questList objectAtIndex:dragon.questInfo.questNo];
            [quest finishQuest:dragon and:appDelegate.player];
            
            //TTEEEESSTTT--DELETE LATER
            //[[appDelegate.mythicalDragonList objectAtIndex:0] hasBeenDiscovered];
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
            self.achievementLabel.frame = CGRectMake(0, topController.view.frame.size.height*4/5, topController.view.frame.size.width, topController.view.frame.size.height*1/5);
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
    
    
    
    NSLog(@"time...");
}

- (void)closeAchievementNotification {
    [self.achievementLabel removeFromSuperview];
}

- (IBAction)changeChildView:(id)sender {
    
    //To Base
    if (self.currentChildView == Map) {
        self.currentChildView = Base;
        [self.changeChildButton setTitle:@"Map" forState:UIControlStateNormal];
        self.currentChildViewLabel.text = @"Base";
        
        [self.mapView willMoveToParentViewController:nil];
        [self.mapView.view removeFromSuperview];
        [self.mapView removeFromParentViewController];
        
        [self addChildViewController:self.baseView];
        self.baseView.view.frame = CGRectMake(0, self.topBoundaryImage.frame.size.height, self.view.frame.size.width, self.bottomBoundaryImage.frame.origin.y - self.topBoundaryImage.frame.size.height);
        [self.view addSubview:self.baseView.view];
    }
    
    //To Map
    else {
        self.currentChildView = Map;
        [self.changeChildButton setTitle:@"Base" forState:UIControlStateNormal];
        self.currentChildViewLabel.text = @"Leisbh'ur";
        
        [self.baseView willMoveToParentViewController:nil];
        [self.baseView.view removeFromSuperview];
        [self.baseView removeFromParentViewController];
        
        [self addChildViewController:self.mapView];
        self.mapView.view.frame = CGRectMake(0, self.topBoundaryImage.frame.size.height, self.view.frame.size.width, self.bottomBoundaryImage.frame.origin.y - self.topBoundaryImage.frame.size.height);
        [self.view addSubview:self.mapView.view];
    }
}

- (void)setBarContents {
    self.gemLabel.text = [NSString stringWithFormat:@"%d", appDelegate.player.gem];
    self.goldLabel.text = [NSString stringWithFormat:@"%d", appDelegate.player.gold];
    self.dragonLabel.text = [NSString stringWithFormat:@"%d/%d", [appDelegate.player numberOfDragonsAvailable], (int)[appDelegate.player.dragonList count] ];
}


@end
