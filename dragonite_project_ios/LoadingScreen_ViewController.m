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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.mainTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCheck) userInfo:nil repeats:YES ];
    
    
    appDelegate.player = [[OCPlayer alloc] init];
    [appDelegate.player initPlayerWithName:@"Bob" withGender:OCCharactermale];
    
    OCDragon *dragon = [[OCDragon alloc] init];
    
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.level = 3;
    dragon.name = @"Khalimus";
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCwind withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Zheltia";
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Jiekha";
    dragon.effectiveStats.strength = 500;
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Mumu";
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCwind withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Spitza";
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Ktaskia";
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCwind withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Uud";
    dragon.effectiveStats.strength = 100;
    [appDelegate.player addNewDragon:dragon];
    dragon = nil;
    
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
    
    NSLog(@"time...");
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
