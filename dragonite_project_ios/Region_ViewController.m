//
//  Region_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 2.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "Region_ViewController.h"

@interface Region_ViewController ()

@property OCDragon *selectedDragon;
@property OCQuest *selectedQuest;

@end

@implementation Region_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.player = [[OCPlayer alloc] init];
    [self.player initPlayerWithName:@"Bob" withGender:OCCharactermale];
    
    OCDragon *dragon = [[OCDragon alloc] init];
    
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.level = 3;
    dragon.name = @"Khalimus";
    [self.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Zheltia";
    [self.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Jiekha";
    [self.player addNewDragon:dragon];
    dragon = nil;
    
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Mumu";
    [self.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Spitza";
    [self.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Ktaskia";
    [self.player addNewDragon:dragon];
    dragon = nil;
    
    dragon = [[OCDragon alloc] init];
    [dragon initNewDragonOfType:OCfire withStatsRange:4 ThatIsLegendary:NO isMythical:NO];
    dragon.name = @"Uud";
    [self.player addNewDragon:dragon];
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
    
    [self setImageViewAndQuestButtons];
    //[self.region placeButtonsOn:self.regionView];
    
    [self setScrollViewForQuest:questPtr];
    
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

-(void) setImageViewAndQuestButtons {
    
    self.regionImageView.image = [UIImage imageNamed: self.region.imageName]; //might need to change this
    
    for (UIButton *button in self.region.buttonList) {
        [button addTarget:self
                   action:@selector(loadQuest) forControlEvents:UIControlEventTouchUpInside];
        [self.regionImageView addSubview:button];
    }
}

-(void) loadQuest {
    NSLog(@"QuestLoaded");
}

-(void) setScrollViewForQuest:(OCQuest *) quest {
    //clear contents of the scrollview
    [self.dragonScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //scrollView.pagingEnabled = YES;
    
    int buttonsAdded = 0;
    int dragonIndex = 0;
    
    for (OCDragon *dragon in self.player.dragonList) {
        if (!dragon.onQuest && dragon.type == quest.requiredType) {
            
            //create the hidden button
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self
                       action:@selector(selectDragon) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(buttonsAdded*160, 0, 160, self.dragonScrollView.frame.size.height); //change size vals
            button.tag = dragonIndex;
            
            if (buttonsAdded %2 == 0) [button setBackgroundColor:[UIColor blueColor]];
            else [button setBackgroundColor:[UIColor redColor]];
            
            [self.dragonScrollView addSubview:button];
            
            //create imageview
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(buttonsAdded*160, 0, 160, self.dragonScrollView.frame.size.height*4/5)];
            imageView.image=[UIImage imageNamed:@"dragon_sample.jpg"];
            [self.dragonScrollView addSubview:imageView];
            
            //create lvl label
            UILabel *lvlLabel = [[UILabel alloc]initWithFrame:CGRectMake(buttonsAdded*160+120, 0, 40, self.dragonScrollView.frame.size.height*1/5)];
            [lvlLabel setBackgroundColor:[UIColor clearColor]];
            [lvlLabel setText:[NSString stringWithFormat:@"%d", dragon.level]];
            lvlLabel.textAlignment = NSTextAlignmentCenter;
            [self.dragonScrollView addSubview:lvlLabel];
            //[LvlLabel release];
            
            //create name label
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(buttonsAdded*160, self.dragonScrollView.frame.size.height*4/5, 160, self.dragonScrollView.frame.size.height/5)];
            [nameLabel setBackgroundColor:[UIColor clearColor]];
            [nameLabel setText:dragon.name];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [self.dragonScrollView addSubview:nameLabel];
            //[LvlLabel release];
            
            buttonsAdded += 1;
        }
        
        self.dragonScrollView.contentSize = CGSizeMake(160*buttonsAdded, self.dragonScrollView.frame.size.height);
        //[scrollView setContentOffset:CGPointMake(160,0)];
        
        dragonIndex += 1;
    }
    
    
}

-(void) selectDragon {
    
    //self.selectedDragon = [self.player.dragonList objectAtIndex:sender.tag];
    
    NSLog(@"Dragon says sup");
}


@end
