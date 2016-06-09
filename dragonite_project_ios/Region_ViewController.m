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

//@property NSMutableArray *questList; //includes quest objects inside
@property NSMutableArray *buttonList;

@end

@implementation Region_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.questList = [[NSMutableArray alloc] init];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.buttonList = [[NSMutableArray alloc] init];
    
    self.questLengthTitle.hidden = YES;
    self.questLengthVal.hidden = YES;
    self.questSuccessChanceTitle.hidden = YES;
    self.questSuccessChanceVal.hidden = YES;
    self.dragonCapacityTitle.hidden = YES;
    self.dragonCapacityVal.hidden = YES;
    
    self.startQuestButton.enabled = NO;
    

    
    
    
    self.region = [[OCRegion alloc] initWithImageName:@"District 12" withDistanceFromBase:200 withRegionNo:0];
    OCQuest *questPtr = [[OCQuest alloc] initWithDistanceFromBase:210 withDifficultyLevel:1 withRequiredDragonType:OCfire withDragonExperienceReward:5 atRegion:0 withIndex:0];
    [self.region.questList addObject:questPtr];
    OCQuest *questPtr2 = [[OCQuest alloc] initWithDistanceFromBase:500 withDifficultyLevel:10 withRequiredDragonType:OCwind withDragonExperienceReward:5 atRegion:0 withIndex:1];
    [self.region.questList addObject:questPtr2];
    self.region.imageName = @"pokemon_dp_map.png";
    
    
    
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [temp addObject:@11];[temp addObject:@11]; [temp addObject:@30];[temp addObject:@23];
    
    self.regionImageView.userInteractionEnabled = YES;
    [self generateQuestButtons:temp];
    [[self.buttonList objectAtIndex:0] setBackgroundColor:[UIColor redColor]];
    [[self.buttonList objectAtIndex:1] setBackgroundColor:[UIColor redColor]];
    
    [self setImageViewAndQuestButtons];
    //[self.region placeButtonsOn:self.regionView];
    
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

//creates the buttons but doesn't add them to the view
-(void) generateQuestButtons:(NSMutableArray *) coordinates {
    
    for (unsigned int i = 0; i < [coordinates count]; i+=2) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(loadQuest:) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake([[coordinates objectAtIndex:i] doubleValue], [[coordinates objectAtIndex:i+1] doubleValue], 20, 20); //change size vals
        
        //To make buttons round. Check if works with images!
        button.layer.cornerRadius = button.bounds.size.width/2;
        button.tag = i/2;
        
        //[view addSubview:button];
        
        OCQuest *questPtr = [self.region.questList objectAtIndex:i/2];
        UIImage *buttonImage = [UIImage imageNamed:[questPtr questButtonImage]];
        [button setImage:buttonImage forState:UIControlStateNormal];
        
        [self.buttonList addObject:button];
    }
}

-(void) setImageViewAndQuestButtons {
    
    self.regionImageView.image = [UIImage imageNamed: self.region.imageName]; //might need to change this
    
    for (UIButton *button in self.buttonList) {
        /*[button addTarget:self
                   action:@selector(loadQuest) forControlEvents:UIControlEventTouchUpInside]; */
        [self.regionImageView addSubview:button];
    }
}

-(IBAction) loadQuest:(UIButton *) sender {
    
    //maybe prevent the user from pressing on the same quest and losing the selected dragon
    //or maybe disable the quest button until another one is pressed
    
    self.questLengthVal.text = @"";
    self.questSuccessChanceVal.text = @"";
    self.dragonCapacityVal.text = @"";
    self.startQuestButton.enabled = NO;
    
    if (self.selectedQuest == nil) {
        self.noQuestsSelectedTitle.hidden = YES;
        self.questLengthTitle.hidden = NO;
        self.questLengthVal.hidden = NO;
        self.questSuccessChanceTitle.hidden = NO;
        self.questSuccessChanceVal.hidden = NO;
        self.dragonCapacityTitle.hidden = NO;
        self.dragonCapacityVal.hidden = NO;
    }
    
    self.selectedQuest = [self.region.questList objectAtIndex:sender.tag];
    [self setScrollViewForQuest:self.selectedQuest];
    self.selectedDragon = nil;
    
    
    NSLog(@"QuestLoaded");
}

-(void) setScrollViewForQuest:(OCQuest *) quest {
    //clear contents of the scrollview
    [self.dragonScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //scrollView.pagingEnabled = YES;
    
    int buttonsAdded = 0;
    int dragonIndex = 0;
    
    for (OCDragon *dragon in appDelegate.player.dragonList) {
        if (!dragon.onQuest && dragon.type == quest.requiredType) {
            
            //create the hidden button
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self
                       action:@selector(selectDragon:) forControlEvents:UIControlEventTouchUpInside];
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

-(IBAction) selectDragon:(UIButton *) sender {
    
    self.selectedDragon = [appDelegate.player.dragonList objectAtIndex:sender.tag];
    
    self.questLengthVal.text = [NSString stringWithFormat:@"%d", [self.selectedDragon calculateLengthForQuestWithDifficulty:self.selectedQuest.difficultyLevel]];
    self.questSuccessChanceVal.text = [NSString stringWithFormat:@"%d%%", [self.selectedQuest successRate0To100:self.selectedDragon]];
    self.dragonCapacityVal.text = [NSString stringWithFormat:@"%d", [self.selectedDragon maxGoldThatCanBeCarried]];
    
    self.startQuestButton.enabled = YES;
    
    NSLog(@"%@ says sup", self.selectedDragon.name);
}


- (IBAction)startQuest:(id)sender {
}
@end
