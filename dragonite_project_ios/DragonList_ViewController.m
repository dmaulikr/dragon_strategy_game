//
//  DragonList_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 7.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "DragonList_ViewController.h"

enum tags {DragonView = 1, StatsView, SkillsView, QuestInfoLabel, QuestTimeLabel};

@interface DragonList_ViewController ()

//@property int selectedDragonViewIndex;//the dragon view for which the stats and skills
//are being shown
@property int statsButtonIndex; //index in subview array
@property int questInfoLabelIndex;
@property int questTimeLabelIndex;

@end

@implementation DragonList_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCheck) userInfo:nil repeats:YES ];
    
    [self setDragonListScene];
    //self.selectedDragonViewIndex = -1;
    
    self.statsButtonIndex = 9;
    self.questInfoLabelIndex = 4;
    self.questTimeLabelIndex = 5;
    NSLog(@"ghj");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height);
} */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)setDragonListScene {
    
    int viewHeight = 100; //adjust this
    int dragonCount = 0;
    //self.scrollView.contentSize = CGSizeMake(0, (viewHeight+6.0f) * [appDelegate.player.dragonList count]);
    
    for (OCDragon *dragon in appDelegate.player.dragonList) {
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, viewHeight);
        //view.backgroundColor = [UIColor yellowColor];
        view.layer.borderColor = [UIColor yellowColor].CGColor;
        view.layer.borderWidth = 3.0f;
        view.tag = DragonView;
        
        [view.heightAnchor constraintEqualToConstant:viewHeight].active = true;
        [view.widthAnchor constraintEqualToConstant:self.stackView.frame.size.width].active = true;
        
        //create imageview
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, view.frame.size.height*4/5)];
        //double size = view.frame.size.height;
        imageView.image=[UIImage imageNamed:@"dragon_sample.jpg"];
        [view addSubview:imageView];
        
        
        //create name label
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, 120, 20)];
        [nameLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        nameLabel.textColor = [UIColor whiteColor];
        [nameLabel setText:dragon.name];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:nameLabel];
        
        //create type label
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 40, 120, 20)];
        [typeLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        typeLabel.textColor = [UIColor whiteColor];
        [typeLabel setText:[dragon typeText]];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:typeLabel];
        
        //create level label
        UILabel *lvlLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 70, 120, 20)];
        [lvlLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        lvlLabel.textColor = [UIColor whiteColor];
        [lvlLabel setText:[NSString stringWithFormat:@"Level %d", dragon.level]];
        lvlLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lvlLabel];
        
        //create quest info label, (on quest or not?)
        UILabel *questInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 10, 120, 20)];
        [questInfoLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        questInfoLabel.textColor = [UIColor whiteColor];
        questInfoLabel.tag = QuestInfoLabel;
        if (dragon.onQuest) {
            [questInfoLabel setText:@"On Quest"];
        }
        else [questInfoLabel setText:@"Not On Quest"];
        
        questInfoLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:questInfoLabel];
        
        
        //create quest time label
        UILabel *questTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 40, 120, 20)];
        [questTimeLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        questTimeLabel.textColor = [UIColor whiteColor];
        questTimeLabel.tag = dragonCount;
        questTimeLabel.textAlignment = NSTextAlignmentCenter;
        if (dragon.onQuest) {
            [self setQuestTimeLabel:questTimeLabel];
        }
        else questTimeLabel.hidden = YES;
        [view addSubview:questTimeLabel];
        
        //create experience progress view and the title label
        UIProgressView *progressView = [[UIProgressView alloc] init];
        
        //check these two lines
        progressView.frame = CGRectMake(280,70,200,50);
        //[progressView setTransform:CGAffineTransformMakeScale(2.0f, 10.0f)];
        
        
        progressView.progress = (float)dragon.experience /
        (float)dragon.experienceRequiredToLevelUp;
        progressView.progressTintColor = [UIColor redColor];
        progressView.trackTintColor = [UIColor blueColor];
        [view addSubview:progressView];
        
        UILabel *expTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 70, 30, 20)];
        [expTitleLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        expTitleLabel.textColor = [UIColor whiteColor];
        [expTitleLabel setText:@"Exp"];
        expTitleLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:expTitleLabel];
        
        //create experience val label
        //change the width to fit the big numbers
        UILabel *expValLabel = [[UILabel alloc]initWithFrame:CGRectMake(600, 70, 130, 20)];
        [expValLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        expValLabel.textColor = [UIColor whiteColor];
        [expValLabel setText:[NSString stringWithFormat:@"%d/%d", dragon.experience, dragon.experienceRequiredToLevelUp]];
        expValLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:expValLabel];
        
        
        //create stats button
        UIButton *statsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [statsButton addTarget:self
                   action:@selector(showStats:) forControlEvents:UIControlEventTouchUpInside];
        statsButton.frame = CGRectMake(500, 10, 80, 20); //change size vals
        statsButton.tag = dragonCount;
        [statsButton setTitle:@"Stats" forState:UIControlStateNormal];
        statsButton.backgroundColor = [UIColor blueColor];
        
        [view addSubview:statsButton];
        
        //create skill button
        UIButton *skillButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [skillButton addTarget:self
                        action:@selector(showSkills:) forControlEvents:UIControlEventTouchUpInside];
        skillButton.frame = CGRectMake(600, 10, 80, 20); //change size vals
        skillButton.tag = dragonCount;
        [skillButton setTitle:@"Skill" forState:UIControlStateNormal];
        skillButton.backgroundColor = [UIColor blueColor];
        
        [view addSubview:skillButton];
        
        
        
        [self.stackView addArrangedSubview:view];
        
        
        
        
        //UIView * firstView = self.stackView.arrangedSubviews[0];
        //firstView.hidden = YES;
        
        
        dragonCount += 1;
    }//for
    
    //figure out the constraint stuff and replace the contentsize line below
    
    
    self.scrollView.contentSize = CGSizeMake(0, (viewHeight+6) * dragonCount);
    /*self.extraActiveViews = [[NSMutableArray alloc]init];
    for (int i = 0; i < dragonCount*2; ++i) {
        [self.extraActiveViews addObject:@NO];
    } */
    
}


-(IBAction) showStats:(UIButton *) sender {
    
    int viewHeight = 100;
    int viewIndex = 0;
    while ([self.stackView.arrangedSubviews objectAtIndex:viewIndex] != sender.superview)
        ++viewIndex;
    
    if ([sender isSelected]) {
        
        
        
        UIView *view = [self.stackView.arrangedSubviews objectAtIndex:viewIndex+1];
        [self.stackView removeArrangedSubview:view];
        //view.hidden = YES;
        [view removeFromSuperview];
        [sender setSelected:NO];
        
    }
    
    else {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, viewHeight);
        //view.backgroundColor = [UIColor yellowColor];
        view.layer.borderColor = [UIColor yellowColor].CGColor;
        view.layer.borderWidth = 3.0f;
        view.tag = StatsView;
        
        [view.heightAnchor constraintEqualToConstant:viewHeight].active = true;
        [view.widthAnchor constraintEqualToConstant:self.stackView.frame.size.width].active = true;
        
        //create title label
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 40, 20)];
        [titleLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        [titleLabel setText:@"Stats"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:titleLabel];
        
        [self.stackView insertArrangedSubview:view atIndex:viewIndex+1];
        [sender setSelected:YES];
    }
    
}

-(IBAction) showSkills:(UIButton *) sender {
    
    UIButton *statsButton = sender.superview.subviews[self.statsButtonIndex];
    NSString *h = statsButton.titleLabel.text;
    int viewHeight = 100;
    int viewIndex = 0;
    while ([self.stackView.arrangedSubviews objectAtIndex:viewIndex] != sender.superview)
        ++viewIndex;
    
    if ([sender isSelected]) {
        
        UIView *view;
        if ([statsButton isSelected]) {
            view = [self.stackView.arrangedSubviews objectAtIndex:viewIndex+2];
        }
        else {
            view = [self.stackView.arrangedSubviews objectAtIndex:viewIndex+1];
        }
        
        [self.stackView removeArrangedSubview:view];
        [view removeFromSuperview];
        [sender setSelected:NO];
        
    }
    
    else {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, viewHeight);
        //view.backgroundColor = [UIColor yellowColor];
        view.layer.borderColor = [UIColor yellowColor].CGColor;
        view.layer.borderWidth = 3.0f;
        view.tag = SkillsView;
        
        [view.heightAnchor constraintEqualToConstant:viewHeight].active = true;
        [view.widthAnchor constraintEqualToConstant:self.stackView.frame.size.width].active = true;
        
        //create title label
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 40, 20)];
        [titleLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        [titleLabel setText:@"Skills"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:titleLabel];
        
        //if stat view is on
        if ([statsButton isSelected]) {
            [self.stackView insertArrangedSubview:view atIndex:viewIndex+2];
        }
        else [self.stackView insertArrangedSubview:view atIndex:viewIndex+1];
        [sender setSelected:YES];
        
        
    }
    
}


- (void)setQuestTimeLabel:(UILabel *)label {
    label.text = [self stringFromTimeInterval:[[appDelegate.player.dragonList objectAtIndex:label.tag] remainingQuestTime]];
    label.hidden = NO;
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval {
    NSInteger time = (NSInteger)timeInterval;
    NSInteger seconds = time % 60;
    NSInteger minutes = (time / 60) % 60;
    NSInteger hours = (time / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}


- (void)timerCheck {
    for (UIView *view in self.stackView.arrangedSubviews) {
        if (view.tag == DragonView) {
            OCDragon *dragon = [appDelegate.player.dragonList objectAtIndex:[view.subviews objectAtIndex:9].tag];
            if (dragon.onQuest) {
                [[view.subviews objectAtIndex:self.questInfoLabelIndex] setText:@"On Quest"];
                [self setQuestTimeLabel:[view.subviews objectAtIndex:self.questTimeLabelIndex]];
            }
            else {
                [[view.subviews objectAtIndex:self.questInfoLabelIndex] setText:@"Not On Quest"];
                [view.subviews objectAtIndex:self.questTimeLabelIndex].hidden = YES;
            }
            
        }
    }
}

@end
