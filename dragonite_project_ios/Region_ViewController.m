//
//  Region_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 2.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "Region_ViewController.h"

@interface Region_ViewController ()

@end

@implementation Region_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    OCPlayer *player = [[OCPlayer alloc] init];
    [player initPlayerWithName:@"Bob" withGender:OCCharactermale];
    
    OCDragon *dragon = [[OCDragon alloc] init];
    
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.level = 3;
    dragon.name = @"Khalimus";
    [player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Zheltia";
    [player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Jiekha";
    [player addNewDragon:dragon];
    dragon = nil;
    
    
    
    
    self.region = [[OCRegion alloc] initWithImageName:@"District 12" withDistanceFromBase:200 withRegionNo:0];
    OCQuest *questPtr = [[OCQuest alloc] initWithDistanceFromBase:210 withDifficultyLevel:1 withRequiredDragonType:OCfire withDragonExperienceReward:5 atRegion:0 withIndex:0];
    [self.region.questList addObject:questPtr];
    self.region.imageName = @"pokemon_dp_map.png";
    
    self.regionImageView.userInteractionEnabled = YES;
    
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [temp addObject:@11];[temp addObject:@11];
    [self.region generateQuestButtons:temp];
    [[self.region.buttonList objectAtIndex:0] setBackgroundColor:[UIColor redColor]];
    
    [self.region setImageView:self.regionImageView];
    //[self.region placeButtonsOn:self.regionView];
    
    [questPtr setScrollView:self.dragonScrollView forDragons:player.dragonList];
    
    
    
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
