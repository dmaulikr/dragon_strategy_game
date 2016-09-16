//
//  DragonList_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 7.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "DragonList_ViewController.h"

//enum tags {DragonView = -10, StatsView, SkillsView, QuestInfoLabel, QuestTimeLabel};

//we use view indices as tags now

@interface DragonList_ViewController ()

//@property int selectedDragonViewIndex;//the dragon view for which the stats and skills
//are being shown
@property int statsButtonIndex; //index in subview array
@property int informationContainerIndex;
@property int questContainerIndex;
//@property UIColor *backgroundColor;
@property NSArray *sortedDragonsArray; //sorted dragon array

@property int dragonViewHeight;
@property int extraViewHeight;
@property int viewWidth;
@property int spaceBetweenViews;

@property NSMutableArray *heighConstraintsForStatsViews;

@end

@implementation DragonList_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCheck) userInfo:nil repeats:YES ];
    
    //self.viewList = [[NSMutableArray alloc] init];
    
    
    //self.selectedDragonViewIndex = -1;
    
    self.heighConstraintsForStatsViews = [[NSMutableArray alloc] init];
    
    self.statsButtonIndex = 5;
    self.informationContainerIndex = 1;
    self.questContainerIndex = 4;
    //self.scrollView.backgroundColor = [UIColor colorWithRed:0.35 green:0.34 blue:0.33 alpha:1.0];
    
    
    UIImageView *backgroundImage =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundImage.image = [UIImage imageNamed:@"lotr_city.jpg"];
    [self.view addSubview:backgroundImage];
    
    
    UIView *backgroundFilter = [[UIView alloc] initWithFrame:backgroundImage.bounds];
    backgroundFilter.backgroundColor = [UIColor grayColor];
    backgroundFilter.alpha = 0.4;
    [self.view addSubview:backgroundFilter];
    [self.view sendSubviewToBack:backgroundFilter];
    [self.view sendSubviewToBack:backgroundImage];

    
    //self.scrollView.backgroundColor = [UIColor grayColor];
    
    
    //gradient for top bar
    CAGradientLayer *topGradient = [CAGradientLayer layer];
    topGradient.frame = self.topBoundary.bounds;
    topGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.69 green:0.17 blue:0.12 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:0.27 green:0.20 blue:0.20 alpha:1.0] CGColor], nil];
    [self.topBoundary.layer insertSublayer:topGradient atIndex:0];
    
    
    //Set background gradient
    /*CAGradientLayer *backgroundGradient = [CAGradientLayer layer];
    backgroundGradient.frame = self.view.bounds;
    backgroundGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:0.51 green:0.45 blue:0.45 alpha:1.0] CGColor], nil];
    backgroundGradient.startPoint = CGPointMake(0.0, 0.5);
    backgroundGradient.endPoint = CGPointMake(1.0, 0.5);
    [self.topBoundary.layer insertSublayer:backgroundGradient atIndex:0];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:self.scrollView]; */
    
    
    
    //we need this for "equal" distribution
    self.statToStartAddingExtraPoints = strength;
    
    self.longPressDuration = 0.7;
    
    //[self setDragonListScene];
    
    //create Back Button
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton addTarget:self
                                     action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 80, 20);
    self.backButton.center = self.view.center;
    [self.backButton setTitle:@"Back Button" forState:UIControlStateNormal];
    self.backButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backButton];
    
    //NSLog(@"hey");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    //set the view heights
    self.dragonViewHeight = self.view.frame.size.height/4; //adjust this
    self.extraViewHeight = self.dragonViewHeight;
    self.viewWidth = self.view.frame.size.width * 14 / 15;
    self.spaceBetweenViews = 5;
    
    [self setDragonListScene];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setDragonListScene {
    
    //sort the dragons
    self.sortedDragonsArray = [appDelegate.player.dragonList sortedArrayUsingSelector:@selector(compareAccordingToLevelAndFavorite:)];
    
    int viewOffset = (self.view.frame.size.width - self.viewWidth) / 2;
    
    for (int i = 0; i < [self.sortedDragonsArray count]; i += 1) {
        
        OCDragon *dragon = [self.sortedDragonsArray objectAtIndex:i];
        
        //create the dragon view
        UIView *dragonView = [[UIView alloc] init];
        dragonView.tag = i * 2;
        dragonView.translatesAutoresizingMaskIntoConstraints = NO;
        dragonView.backgroundColor = [UIColor blackColor];
        
        UIView *previousView;
        if (i != 0) {
            previousView = [self.scrollView.subviews lastObject];
        }
        
        [self.scrollView addSubview:dragonView];
        
        
        if (i == 0) {
            NSLayoutConstraint *leadingSpaceConstraint = [NSLayoutConstraint
                                                          constraintWithItem:dragonView attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:
                                                          NSLayoutAttributeLeading multiplier:1.0f constant:viewOffset];
            
            NSLayoutConstraint *topSpaceConstraint = [NSLayoutConstraint
                                                      constraintWithItem:dragonView attribute:NSLayoutAttributeTop
                                                      relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:
                                                      NSLayoutAttributeTop multiplier:1.0f constant:self.spaceBetweenViews];
            
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint
                                                   constraintWithItem:dragonView attribute:NSLayoutAttributeWidth
                                                   relatedBy:NSLayoutRelationEqual toItem:nil attribute:
                                                   NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.viewWidth-2*viewOffset];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint
                                                    constraintWithItem:dragonView attribute:NSLayoutAttributeHeight
                                                    relatedBy:NSLayoutRelationEqual toItem:nil attribute:
                                                    NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.dragonViewHeight];
            
            [self.scrollView addConstraints:@[leadingSpaceConstraint, topSpaceConstraint, widthConstraint, heightConstraint]];
        }
        
        
        else {
            
            NSLayoutConstraint *leadingSpaceConstraint = [NSLayoutConstraint
                                      constraintWithItem:dragonView attribute:NSLayoutAttributeLeading
                                      relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:
                                      NSLayoutAttributeLeading multiplier:1.0f constant:viewOffset];
            
            NSLayoutConstraint *topSpaceConstraint = [NSLayoutConstraint
                                  constraintWithItem:dragonView attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual toItem:previousView attribute:
                                  NSLayoutAttributeBottom multiplier:1.0f constant:self.spaceBetweenViews];
            
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint
                               constraintWithItem:dragonView attribute:NSLayoutAttributeWidth
                               relatedBy:NSLayoutRelationEqual toItem:nil attribute:
                               NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.viewWidth-2*viewOffset];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint
                                constraintWithItem:dragonView attribute:NSLayoutAttributeHeight
                                relatedBy:NSLayoutRelationEqual toItem:nil attribute:
                                NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.dragonViewHeight];
            [self.scrollView addConstraints:@[leadingSpaceConstraint, topSpaceConstraint, widthConstraint, heightConstraint]];
            
        }
        
        
        //add contents to the dragon view
        UIView *imageContainer = [[UIView alloc] init];
        imageContainer.frame = CGRectMake(0, 0, self.view.frame.size.width/6, self.dragonViewHeight);
        imageContainer.backgroundColor = [UIColor clearColor];
        [dragonView addSubview:imageContainer];
        
        
        //create imageview
        //do image size stuff for different screen sizes
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageContainer.frame.size.width, self.dragonViewHeight)];
        //double size = view.frame.size.height;
        imageView.image=[UIImage imageNamed:dragon.imageName];
        [imageContainer addSubview:imageView];
        imageView.center=imageContainer.center;
        
        
        //view that contains the name, type and level labels
        
        //don't forget to change the subview indices
        UIView *informationContainer = [[UIView alloc] initWithFrame:CGRectMake(imageContainer.frame.size.width, 0, self.view.frame.size.width/5, self.dragonViewHeight)];
        [dragonView addSubview:informationContainer];
        
        
        
        //create name label
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, informationContainer.frame.size.width, informationContainer.frame.size.height/3)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor whiteColor];
        [nameLabel setText:dragon.name];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.userInteractionEnabled = NO;
        [informationContainer addSubview:nameLabel];
        
        //create type label
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, informationContainer.frame.size.height/3, informationContainer.frame.size.width, informationContainer.frame.size.height/3)];
        [typeLabel setBackgroundColor:[UIColor clearColor]];
        typeLabel.textColor = [UIColor whiteColor];
        [typeLabel setText:[dragon typeText]];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [informationContainer addSubview:typeLabel];
        
        //create level label
        UILabel *lvlLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, informationContainer.frame.size.height*2/3, informationContainer.frame.size.width, informationContainer.frame.size.height/3)];
        [lvlLabel setBackgroundColor:[UIColor clearColor]];
        lvlLabel.textColor = [UIColor whiteColor];
        [lvlLabel setText:[NSString stringWithFormat:@"Level %d", dragon.level]];
        lvlLabel.textAlignment = NSTextAlignmentCenter;
        [informationContainer addSubview:lvlLabel];
        
        
        
        //experience progress view container
        UIView *experienceContainer = [[UIView alloc] initWithFrame:CGRectMake(informationContainer.frame.origin.x + informationContainer.frame.size.width, 0, self.view.frame.size.width/7, self.dragonViewHeight)];
        //experienceContainer.backgroundColor = [UIColor yellowColor];
        [dragonView addSubview:experienceContainer];
        
        
        UILabel *experienceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, experienceContainer.frame.size.width, experienceContainer.frame.size.height)];
        //experienceLabel.center = experienceContainer.center;
        [experienceLabel setBackgroundColor:[UIColor clearColor]];
        experienceLabel.textColor = [UIColor whiteColor];
        [experienceLabel setText:[NSString stringWithFormat:@"%d/%d", dragon.experience, [dragon experienceRequiredToLevelUp]]];
        experienceLabel.textAlignment = NSTextAlignmentCenter;
        [experienceContainer addSubview:experienceLabel];
        
        
        
        //energy progress view
        UIView *energyContainer = [[UIView alloc] initWithFrame:CGRectMake(experienceContainer.frame.origin.x + experienceContainer.frame.size.width, 0, self.view.frame.size.width/7, self.dragonViewHeight)];
        //energyContainer.backgroundColor = [UIColor redColor];
        [dragonView addSubview:energyContainer];
        
        
        UILabel *energyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, energyContainer.frame.size.width, energyContainer.frame.size.height)];
        //energyLabel.center = energyContainer.center;
        [energyLabel setBackgroundColor:[UIColor clearColor]];
        energyLabel.textColor = [UIColor whiteColor];
        [energyLabel setText:[NSString stringWithFormat:@"%f/%f", dragon.energy, [dragon maxEnergy]]];
        energyLabel.textAlignment = NSTextAlignmentCenter;
        [energyContainer addSubview:energyLabel];
        
        
        //view that contains quest info
        
        //don't forget to change the subview indices
        UIView *questContainer = [[UIView alloc] init];
        questContainer.frame = CGRectMake(energyContainer.frame.origin.x + energyContainer.frame.size.width, self.dragonViewHeight/3, self.view.frame.size.width/5, self.dragonViewHeight*2/3);
        
        [dragonView addSubview:questContainer];
        
        //create quest info label, (on quest or not?)
        UILabel *questInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, questContainer.frame.size.width, questContainer.frame.size.height/2)];
        [questInfoLabel setBackgroundColor:[UIColor clearColor]];
        questInfoLabel.textColor = [UIColor whiteColor];
        //questInfoLabel.tag = QuestInfoLabel;
        if (dragon.onQuest) {
            [questInfoLabel setText:@"On Quest"];
        }
        else [questInfoLabel setText:@"Not On Quest"];
        
        questInfoLabel.textAlignment = NSTextAlignmentCenter;
        [questContainer addSubview:questInfoLabel];
        
        
        //create quest time label
        UILabel *questTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, questContainer.frame.size.height/2, questContainer.frame.size.width, questContainer.frame.size.height/2)];
        [questTimeLabel setBackgroundColor:[UIColor clearColor]];
        questTimeLabel.textColor = [UIColor whiteColor];
        questTimeLabel.tag = i;
        questTimeLabel.textAlignment = NSTextAlignmentCenter;
        if (dragon.onQuest) {
            [self setQuestTimeLabel:questTimeLabel];
        }
        else questTimeLabel.hidden = YES;
        [questContainer addSubview:questTimeLabel];
        
        
        
        //create stats button
        UIButton *statsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [statsButton addTarget:self
                        action:@selector(showStats:) forControlEvents:UIControlEventTouchUpInside];
        statsButton.frame = CGRectMake(questContainer.frame.origin.x + (questContainer.frame.size.width - 80)/2, self.dragonViewHeight/9, 80, 20); //change size vals
        statsButton.tag = i;
        [statsButton setTitle:@"Stats" forState:UIControlStateNormal];
        statsButton.backgroundColor = [UIColor colorWithRed:0.35 green:0.34 blue:0.33 alpha:1.0];
        
        [dragonView addSubview:statsButton];
        
        
        //create hidden name button
        UIButton *nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nameButton addTarget:self
                       action:@selector(showDragonNameView:) forControlEvents:UIControlEventTouchUpInside];
        nameButton.frame = informationContainer.frame;
        nameButton.tag = i;
        nameButton.backgroundColor = [UIColor clearColor];
        //nameButton.hidden = YES;
        nameButton.enabled = YES;
        [dragonView addSubview:nameButton];
        
        
        //remove button
        UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [releaseButton addTarget:self
                         action:@selector(release:) forControlEvents:UIControlEventTouchUpInside];
        releaseButton.frame = CGRectMake(self.viewWidth-40, 15, 20, 20); //change size vals
        releaseButton.tag = i;
        [releaseButton setTitle:@"Release" forState:UIControlStateNormal];
        releaseButton.backgroundColor = [UIColor whiteColor];
        
        [dragonView addSubview:releaseButton];
        
        
        //stats view
        UIView *statsView = [[UIView alloc] initWithFrame:CGRectMake(viewOffset, 0, self.viewWidth, 0)];
        statsView.tag = 2 * i + 1;
        statsView.backgroundColor = [UIColor grayColor];
        statsView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.scrollView addSubview:statsView];
        
        
        NSLayoutConstraint *leadingSpaceConstraint = [NSLayoutConstraint
                                                      constraintWithItem:statsView attribute:NSLayoutAttributeLeading
                                                      relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:
                                                      NSLayoutAttributeLeading multiplier:1.0f constant:viewOffset];
        
        NSLayoutConstraint *topSpaceConstraint = [NSLayoutConstraint
                                                  constraintWithItem:statsView attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual toItem:dragonView attribute:
                                                  NSLayoutAttributeBottom multiplier:1.0f constant:0.f];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint
                                               constraintWithItem:statsView attribute:NSLayoutAttributeWidth
                                               relatedBy:NSLayoutRelationEqual toItem:nil attribute:
                                               NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.viewWidth-2*viewOffset];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint
                                                constraintWithItem:statsView attribute:NSLayoutAttributeHeight
                                                relatedBy:NSLayoutRelationEqual toItem:nil attribute:
                                                NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.f];
        [self.heighConstraintsForStatsViews addObject:heightConstraint];
        [self.scrollView addConstraints:@[leadingSpaceConstraint, topSpaceConstraint, widthConstraint, heightConstraint]];
        
        
    }//for
    
    //set contentsize
    self.scrollView.contentSize = CGSizeMake(0, (self.spaceBetweenViews + self.dragonViewHeight)*[self.sortedDragonsArray count]);
}


- (IBAction)showStats:(UIButton *)sender {
    
    //disappear
    if ([sender isSelected]) {
        [self closeOpenStatsView]; //sets selected to NO
    }
    
    //appear
    else {
        
        if (self.selectedStatsViewButton) {
            [self closeOpenStatsView];
        }
        
        [sender setSelected:YES];
        self.selectedStatsViewButton = sender;
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height + self.extraViewHeight);
        
        UIView *statsView = [self.scrollView.subviews objectAtIndex:(2 * sender.tag + 1)];
        NSLayoutConstraint *heightConstraint = [self.heighConstraintsForStatsViews objectAtIndex:sender.tag];
        
        //don't need this line if animation
        //heightConstraint.constant = self.extraViewHeight;
        
        //animatation for showing the stats view
        [self.view layoutIfNeeded];
        heightConstraint.constant = self.extraViewHeight;
        
        //if the view is for the last dragon, we need to scroll for
        //easier user experience
        if (sender.tag == [self.sortedDragonsArray count]-1) {
            CGPoint scrollPoint = self.scrollView.contentOffset;
            scrollPoint.y += self.extraViewHeight;
            [self.scrollView setContentOffset:scrollPoint animated:YES];
        }
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
         {
             [self.view layoutIfNeeded];
         }
                         completion:nil]; //add lines below to completion maybe?
        
        
        self.selectedDragon = [self.sortedDragonsArray objectAtIndex:sender.tag];
        self.maxAvailableStats = self.selectedDragon.availableStatPoints;
        
        [self setStatsViewContents:statsView];
        
    }
    
}

- (void)closeOpenStatsView {
    
    UIView *statsView = [self.scrollView.subviews objectAtIndex:(2 * self.selectedStatsViewButton.tag + 1)];
    
    for (UIView *subview in statsView.subviews) {
        [subview removeFromSuperview];
    }
    
    NSLayoutConstraint *heightConstraint = [self.heighConstraintsForStatsViews objectAtIndex:self.selectedStatsViewButton.tag];
    //heightConstraint.constant = 0; //don't need if animation is on
    
    //animation for closing the stats view
    [self.view layoutIfNeeded];
    heightConstraint.constant = 0;
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         [self.view layoutIfNeeded];
     }
                     completion:nil];
    
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height - self.extraViewHeight);
                     } completion:^(BOOL finished) {
                     }
     ];
    
    

    [self.selectedStatsViewButton setSelected:NO];
    self.selectedStatsViewButton = nil;
}


- (IBAction)showDragonNameView:(UIButton *)sender {
    
    DragonName_ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DragonName_ViewController"];
    
    UIView *blackView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [blackView setBackgroundColor:[UIColor blackColor]];
    blackView.alpha = 0;
    [self.view addSubview:blackView];
    
    viewController.dragonIndex = sender.tag;
    [self addChildViewController:viewController];
    viewController.view.frame = self.view.frame;
    [self.view addSubview:viewController.view];
    viewController.view.alpha = 0;
    [viewController didMoveToParentViewController:self];
    
    viewController.dragonNameLabel = [[[sender superview].subviews objectAtIndex:self.informationContainerIndex].subviews objectAtIndex:0];
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         blackView.alpha = 0.5;
         viewController.view.alpha = 1;
     }
                     completion:nil];
    
    //NSLog(@"hey");
}


- (void)setQuestTimeLabel:(UILabel *)label {
    label.text = [self stringFromTimeInterval:[[self.sortedDragonsArray objectAtIndex:label.tag] remainingQuestTime]];
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
    for (int i = 0; i < ([self.sortedDragonsArray count] * 2); i += 2) {
        //even indices are dragonViews
        UIView *view = [self.scrollView.subviews objectAtIndex:i];
        
        OCDragon *dragon = [self.sortedDragonsArray objectAtIndex:i/2];
        //[self.sortedDragonsArray objectAtIndex:[view.subviews objectAtIndex:self.statsButtonIndex].tag];
        if (dragon.onQuest) {
            [[[view.subviews objectAtIndex:self.questContainerIndex].subviews objectAtIndex:0] setText:@"On Quest"];
            [self setQuestTimeLabel:[[view.subviews objectAtIndex:self.questContainerIndex].subviews objectAtIndex:1]];
        }
        else {
            [[[view.subviews objectAtIndex:self.questContainerIndex].subviews objectAtIndex:0] setText:@"Not On Quest"];
            [[view.subviews objectAtIndex:self.questContainerIndex].subviews objectAtIndex:1].hidden = YES;
        }
        
        
    }
    
    //NSLog(@"time2");
    
}

- (void)setStatsViewContents:(UIView *)statsView {
    
    self.remainingAvailableStats = self.maxAvailableStats;

    //strength
    self.strengthPlus = [UIButton buttonWithType:UIButtonTypeCustom];
    /*[self.strengthPlus addTarget:self
                          action:@selector(increaseStats:) forControlEvents:UIControlEventTouchUpInside];*/
    self.strengthPlus.frame = CGRectMake(25, 20, 10, 10);
    self.strengthPlus.tag = strength;
    [self.strengthPlus setTitle:@"+" forState:UIControlStateNormal];
    self.strengthPlus.backgroundColor = [UIColor clearColor];
    [statsView addSubview:self.strengthPlus];
    
    self.currentStrengthLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 20, 100, 20)];
    [self.currentStrengthLabel setBackgroundColor:[UIColor clearColor]];
    self.currentStrengthLabel.textColor = [UIColor whiteColor];
    self.currentStrengthLabel.textAlignment = NSTextAlignmentCenter;
    self.currentStrengthLabel.text = [NSString stringWithFormat:@"%d", self.selectedDragon.baseStats.strength];
    [statsView addSubview:self.currentStrengthLabel];
    
    self.adjustedStrengthLabel = [[UILabel alloc]initWithFrame:CGRectMake(155, 20, 60, 20)];
    [self.adjustedStrengthLabel setBackgroundColor:[UIColor clearColor]];
    self.adjustedStrengthLabel.textColor = [UIColor whiteColor];
    self.adjustedStrengthLabel.textAlignment = NSTextAlignmentCenter;
    self.adjustedStrengthLabel.text = [NSString stringWithFormat:@" "];
    [statsView addSubview:self.adjustedStrengthLabel];
    
    self.strengthMinus = [UIButton buttonWithType:UIButtonTypeCustom];
    /*[self.strengthMinus addTarget:self
                           action:@selector(decreaseStats:) forControlEvents:UIControlEventTouchUpInside];*/
    self.strengthMinus.frame = CGRectMake(215, 20, 10, 10);
    self.strengthMinus.tag = strength;
    [self.strengthMinus setTitle:@"-" forState:UIControlStateNormal];
    self.strengthMinus.backgroundColor = [UIColor clearColor];
    [statsView addSubview:self.strengthMinus];
    
    //Taps
    UITapGestureRecognizer *singeTapStrengthPlus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (increaseStats:)];
    [self.strengthPlus addGestureRecognizer:singeTapStrengthPlus];
    
    UITapGestureRecognizer *singeTapStrengthMinus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (decreaseStats:)];
    [self.strengthMinus addGestureRecognizer:singeTapStrengthMinus];
    
    
    //hold downs--they give all the remaining available stats to the corresponding stat
    UILongPressGestureRecognizer *longPressStrengthPlus = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector (increaseStatsToMax:)];
    longPressStrengthPlus.cancelsTouchesInView = NO;
    longPressStrengthPlus.minimumPressDuration = self.longPressDuration;
    [self.strengthPlus addGestureRecognizer:longPressStrengthPlus];
    
    UILongPressGestureRecognizer *longPressStrengthMinus = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector (decreaseStatsToMin:)];
    longPressStrengthMinus.cancelsTouchesInView = NO;
    longPressStrengthMinus.minimumPressDuration = self.longPressDuration;
    [self.strengthMinus addGestureRecognizer:longPressStrengthMinus];
    
    //gesture priority
    [singeTapStrengthPlus requireGestureRecognizerToFail:longPressStrengthPlus];
    [singeTapStrengthMinus requireGestureRecognizerToFail:longPressStrengthMinus];
    
    
    //speed
    self.speedPlus = [UIButton buttonWithType:UIButtonTypeCustom];
    /*[self.speedPlus addTarget:self
                          action:@selector(increaseStats:) forControlEvents:UIControlEventTouchUpInside]; */
    self.speedPlus.frame = CGRectMake(25, 40, 10, 10);
    self.speedPlus.tag = speed;
    [self.speedPlus setTitle:@"+" forState:UIControlStateNormal];
    self.speedPlus.backgroundColor = [UIColor clearColor];
    [statsView addSubview:self.speedPlus];
    
    self.currentSpeedLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 40, 100, 20)];
    [self.currentSpeedLabel setBackgroundColor:[UIColor clearColor]];
    self.currentSpeedLabel.textColor = [UIColor whiteColor];
    self.currentSpeedLabel.textAlignment = NSTextAlignmentCenter;
    self.currentSpeedLabel.text = [NSString stringWithFormat:@"%d", self.selectedDragon.baseStats.speed];
    [statsView addSubview:self.currentSpeedLabel];
    
    self.adjustedSpeedLabel = [[UILabel alloc]initWithFrame:CGRectMake(155, 40, 60, 20)];
    [self.adjustedSpeedLabel setBackgroundColor:[UIColor clearColor]];
    self.adjustedSpeedLabel.textColor = [UIColor whiteColor];
    self.adjustedSpeedLabel.textAlignment = NSTextAlignmentCenter;
    self.adjustedSpeedLabel.text = [NSString stringWithFormat:@" "];
    [statsView addSubview:self.adjustedSpeedLabel];
    
    self.speedMinus = [UIButton buttonWithType:UIButtonTypeCustom];
    /*[self.speedMinus addTarget:self
                           action:@selector(decreaseStats:) forControlEvents:UIControlEventTouchUpInside];*/
    self.speedMinus.frame = CGRectMake(215, 40, 10, 10);
    self.speedMinus.tag = speed;
    [self.speedMinus setTitle:@"-" forState:UIControlStateNormal];
    self.speedMinus.backgroundColor = [UIColor clearColor];
    [statsView addSubview:self.speedMinus];
    
    //Taps
    UITapGestureRecognizer *singeTapSpeedPlus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (increaseStats:)];
    [self.speedPlus addGestureRecognizer:singeTapSpeedPlus];
    
    UITapGestureRecognizer *singeTapSpeedMinus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (decreaseStats:)];
    [self.speedMinus addGestureRecognizer:singeTapSpeedMinus];
    
    //hold downs--they give all the remaining available stats to the corresponding stat
    UILongPressGestureRecognizer *longPressSpeedPlus = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector (increaseStatsToMax:)];
    longPressSpeedPlus.cancelsTouchesInView = NO;
    longPressSpeedPlus.minimumPressDuration = self.longPressDuration;
    [self.speedPlus addGestureRecognizer:longPressSpeedPlus];
    
    UILongPressGestureRecognizer *longPressSpeedMinus = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector (decreaseStatsToMin:)];
    longPressSpeedMinus.cancelsTouchesInView = NO;
    longPressSpeedMinus.minimumPressDuration = self.longPressDuration;
    [self.speedMinus addGestureRecognizer:longPressSpeedMinus];
    
    //gesture priority
    [singeTapSpeedPlus requireGestureRecognizerToFail:longPressSpeedPlus];
    [singeTapSpeedMinus requireGestureRecognizerToFail:longPressSpeedMinus];
    
    
    //endurance
    self.endurancePlus = [UIButton buttonWithType:UIButtonTypeCustom];
    /*[self.endurancePlus addTarget:self
                          action:@selector(increaseStats:) forControlEvents:UIControlEventTouchUpInside];*/
    self.endurancePlus.frame = CGRectMake(25, 60, 10, 10);
    self.endurancePlus.tag = endurance;
    [self.endurancePlus setTitle:@"+" forState:UIControlStateNormal];
    self.endurancePlus.backgroundColor = [UIColor clearColor];
    [statsView addSubview:self.endurancePlus];
    
    self.currentEnduranceLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 60, 100, 20)];
    [self.currentEnduranceLabel setBackgroundColor:[UIColor clearColor]];
    self.currentEnduranceLabel.textColor = [UIColor whiteColor];
    self.currentEnduranceLabel.textAlignment = NSTextAlignmentCenter;
    self.currentEnduranceLabel.text = [NSString stringWithFormat:@"%d", self.selectedDragon.baseStats.endurance];
    [statsView addSubview:self.currentEnduranceLabel];
    
    self.adjustedEnduranceLabel = [[UILabel alloc]initWithFrame:CGRectMake(155, 60, 60, 20)];
    [self.adjustedEnduranceLabel setBackgroundColor:[UIColor clearColor]];
    self.adjustedEnduranceLabel.textColor = [UIColor whiteColor];
    self.adjustedEnduranceLabel.textAlignment = NSTextAlignmentCenter;
    self.adjustedEnduranceLabel.text = [NSString stringWithFormat:@" "];
    [statsView addSubview:self.adjustedEnduranceLabel];
    
    self.enduranceMinus = [UIButton buttonWithType:UIButtonTypeCustom];
    /*[self.enduranceMinus addTarget:self
                           action:@selector(decreaseStats:) forControlEvents:UIControlEventTouchUpInside];*/
    self.enduranceMinus.frame = CGRectMake(215, 60, 10, 10);
    self.enduranceMinus.tag = endurance;
    [self.enduranceMinus setTitle:@"-" forState:UIControlStateNormal];
    self.enduranceMinus.backgroundColor = [UIColor clearColor];
    [statsView addSubview:self.enduranceMinus];
    
    //Taps
    UITapGestureRecognizer *singeTapEndurancePlus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (increaseStats:)];
    [self.endurancePlus addGestureRecognizer:singeTapEndurancePlus];
    
    UITapGestureRecognizer *singeTapEnduranceMinus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (decreaseStats:)];
    [self.enduranceMinus addGestureRecognizer:singeTapEnduranceMinus];
    
    //hold downs--they give all the remaining available stats to the corresponding stat
    UILongPressGestureRecognizer *longPressEndurancePlus = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector (increaseStatsToMax:)];
    longPressEndurancePlus.cancelsTouchesInView = NO;
    longPressEndurancePlus.minimumPressDuration = self.longPressDuration;
    [self.endurancePlus addGestureRecognizer:longPressEndurancePlus];
    
    UILongPressGestureRecognizer *longPressEnduranceMinus = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector (decreaseStatsToMin:)];
    longPressEnduranceMinus.cancelsTouchesInView = NO;
    longPressEnduranceMinus.minimumPressDuration = self.longPressDuration;
    [self.enduranceMinus addGestureRecognizer:longPressEnduranceMinus];
    
    //gesture priority
    [singeTapEndurancePlus requireGestureRecognizerToFail:longPressEndurancePlus];
    [singeTapEnduranceMinus requireGestureRecognizerToFail:longPressEnduranceMinus];
    
    
    
    self.availableStatsLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 60, 250, 20)];
    [self.availableStatsLabel setBackgroundColor:[UIColor clearColor]];
    self.availableStatsLabel.textColor = [UIColor whiteColor];
    self.availableStatsLabel.textAlignment = NSTextAlignmentCenter;
    self.availableStatsLabel.text = [NSString stringWithFormat:@"Available Points:%d ", self.maxAvailableStats];
    [statsView addSubview:self.availableStatsLabel];
    
    self.distributeEquallyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.distributeEquallyButton addTarget:self
                         action:@selector(distributePointsEqually) forControlEvents:UIControlEventTouchUpInside];
    self.distributeEquallyButton.frame = CGRectMake(450, 20, 150, 20);
    [self.distributeEquallyButton setTitle:@"Distribute Points Equally" forState:UIControlStateNormal];
    self.distributeEquallyButton.backgroundColor = [UIColor clearColor];
    [statsView addSubview:self.distributeEquallyButton];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saveButton addTarget:self
                                     action:@selector(savePoints) forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.frame = CGRectMake(450, 40, 150, 20);
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    self.saveButton.backgroundColor = [UIColor clearColor];
    [statsView addSubview:self.saveButton];
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clearButton addTarget:self
                           action:@selector(clearPoints) forControlEvents:UIControlEventTouchUpInside];
    self.clearButton.frame = CGRectMake(450, 60, 150, 20);
    [self.clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    self.clearButton.backgroundColor = [UIColor clearColor];
    [statsView addSubview:self.clearButton];
    
    
    if (self.maxAvailableStats == 0) {
        self.strengthPlus.enabled = NO;
        self.strengthMinus.enabled = NO;
        self.speedPlus.enabled = NO;
        self.speedMinus.enabled = NO;
        self.endurancePlus.enabled = NO;
        self.enduranceMinus.enabled = NO;
    }
    
    else {
        self.strengthMinus.enabled = NO;
        self.speedMinus.enabled = NO;
        self.enduranceMinus.enabled = NO;
    }
    
}

- (IBAction)increaseStats:(UITapGestureRecognizer*)gesture {
    enum statTypes statType = gesture.view.tag;
    if (statType == strength) {
        self.strengthIncrement += 1;
        self.adjustedStrengthLabel.text = [NSString stringWithFormat:@"+ %d", self.strengthIncrement];
        self.strengthMinus.enabled = YES;
    }
    else if (statType == speed) {
        self.speedIncrement += 1;
        self.adjustedSpeedLabel.text = [NSString stringWithFormat:@"+ %d", self.speedIncrement];
        self.speedMinus.enabled = YES;
    }
    
    else if (statType == endurance) {
        self.enduranceIncrement += 1;
        self.adjustedEnduranceLabel.text = [NSString stringWithFormat:@"+ %d", self.enduranceIncrement];
        self.enduranceMinus.enabled = YES;
    }
    
    else NSLog(@"Error in increase Stats--types");
    
    self.remainingAvailableStats -= 1;
    self.availableStatsLabel.text = [NSString stringWithFormat:@"Available Points:%d", self.remainingAvailableStats];
    
    if (self.remainingAvailableStats == 0) {
        self.strengthPlus.enabled = NO;
        self.speedPlus.enabled = NO;
        self.endurancePlus.enabled = NO;
    }
}

- (IBAction)decreaseStats:(UITapGestureRecognizer*)gesture {
    enum statTypes statType = gesture.view.tag;
    if (statType == strength) {
        self.strengthIncrement -= 1;
        if (self.strengthIncrement == 0) self.adjustedStrengthLabel.text = [NSString stringWithFormat:@" "];
        else self.adjustedStrengthLabel.text = [NSString stringWithFormat:@"+ %d", self.strengthIncrement];
    }
    else if (statType == speed) {
        self.speedIncrement -= 1;
        if (self.speedIncrement == 0) self.adjustedSpeedLabel.text = [NSString stringWithFormat:@" "];
        else self.adjustedSpeedLabel.text = [NSString stringWithFormat:@"+ %d", self.speedIncrement];
    }
    
    else if (statType == endurance) {
        self.enduranceIncrement -= 1;
        if (self.enduranceIncrement == 0) self.adjustedEnduranceLabel.text = [NSString stringWithFormat:@" "];
        else self.adjustedEnduranceLabel.text = [NSString stringWithFormat:@"+ %d", self.enduranceIncrement];
    }
    
    else NSLog(@"Error in increase Stats--types");
    
    self.remainingAvailableStats += 1;
    self.availableStatsLabel.text = [NSString stringWithFormat:@"Available Points:%d", self.remainingAvailableStats];
    
    self.strengthPlus.enabled = YES;
    self.speedPlus.enabled = YES;
    self.endurancePlus.enabled = YES;
    
    if (self.remainingAvailableStats == self.maxAvailableStats) {
        self.strengthMinus.enabled = NO;
        self.speedMinus.enabled = NO;
        self.enduranceMinus.enabled = NO;
    }
}

- (IBAction)increaseStatsToMax:(UILongPressGestureRecognizer*)gesture {
    
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        enum statTypes statType = gesture.view.tag;
        if (statType == strength) {
            self.strengthIncrement += self.remainingAvailableStats;
            self.adjustedStrengthLabel.text = [NSString stringWithFormat:@"+ %d", self.strengthIncrement];
            self.strengthMinus.enabled = YES;
        }
        else if (statType == speed) {
            self.speedIncrement += self.remainingAvailableStats;
            self.adjustedSpeedLabel.text = [NSString stringWithFormat:@"+ %d", self.speedIncrement];
            self.speedMinus.enabled = YES;
        }
        
        else if (statType == endurance) {
            self.enduranceIncrement += self.remainingAvailableStats;
            self.adjustedEnduranceLabel.text = [NSString stringWithFormat:@"+ %d", self.enduranceIncrement];
            self.enduranceMinus.enabled = YES;
        }
        
        else NSLog(@"Error in increase Stats--types");
        
        self.remainingAvailableStats = 0;
        self.availableStatsLabel.text = [NSString stringWithFormat:@"Available Points:%d", self.remainingAvailableStats];
        
        self.strengthPlus.enabled = NO;
        self.speedPlus.enabled = NO;
        self.endurancePlus.enabled = NO;
    }
}

- (IBAction)decreaseStatsToMin:(UILongPressGestureRecognizer*)gesture {
    
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        enum statTypes statType = gesture.view.tag;
        if (statType == strength) {
            self.remainingAvailableStats += self.strengthIncrement;
            self.strengthIncrement = 0;
            self.adjustedStrengthLabel.text = [NSString stringWithFormat:@" "];
            self.strengthMinus.enabled = NO;
        }
        else if (statType == speed) {
            self.remainingAvailableStats += self.speedIncrement;
            self.speedIncrement = 0;
            self.adjustedSpeedLabel.text = [NSString stringWithFormat:@" "];
            self.speedMinus.enabled = NO;
        }
        
        else if (statType == endurance) {
            self.remainingAvailableStats += self.enduranceIncrement;
            self.enduranceIncrement = 0;
            self.adjustedEnduranceLabel.text = [NSString stringWithFormat:@" "];
            self.enduranceMinus.enabled = NO;
        }
        
        else NSLog(@"Error in increase Stats--types");
        
        self.availableStatsLabel.text = [NSString stringWithFormat:@"Available Points:%d", self.remainingAvailableStats];
        
        self.strengthPlus.enabled = YES;
        self.speedPlus.enabled = YES;
        self.endurancePlus.enabled = YES;
    }
}


- (IBAction)distributePointsEqually {
    int numberOfPoints = self.maxAvailableStats / 3;
    int remainder = self.maxAvailableStats % 3;
    
    self.strengthIncrement = numberOfPoints;
    self.speedIncrement = numberOfPoints;
    self.enduranceIncrement = numberOfPoints;
    
    enum statTypes initialType = self.statToStartAddingExtraPoints;
    
    while (remainder > 0) {
        if (self.statToStartAddingExtraPoints == strength) {
            self.strengthIncrement += 1;
            self.statToStartAddingExtraPoints = speed;
        }
        else if (self.statToStartAddingExtraPoints == speed) {
            self.speedIncrement += 1;
            self.statToStartAddingExtraPoints = endurance;
        }
        else if (self.statToStartAddingExtraPoints == endurance) {
            self.enduranceIncrement += 1;
            self.statToStartAddingExtraPoints = strength;
        }
        else NSLog(@"Error in distribute points equally--type");
        
        remainder -= 1;
    }
    
    if (initialType == strength) self.statToStartAddingExtraPoints = speed;
    else if (initialType == speed) self.statToStartAddingExtraPoints = endurance;
    else if (initialType == endurance) self.statToStartAddingExtraPoints = strength;
    else NSLog(@"Error in distribute points equally--initial stat recovery");
    
    self.remainingAvailableStats = 0;
    self.availableStatsLabel.text = [NSString stringWithFormat:@"Available Points:%d", self.remainingAvailableStats];
    
    self.strengthPlus.enabled = NO;
    self.speedPlus.enabled = NO;
    self.endurancePlus.enabled = NO;
    
    self.strengthMinus.enabled = YES;
    self.speedMinus.enabled = YES;
    self.enduranceMinus.enabled = YES;
    
    if (self.strengthIncrement == 0) self.adjustedStrengthLabel.text = [NSString stringWithFormat:@" "];
    else self.adjustedStrengthLabel.text = [NSString stringWithFormat:@"+ %d", self.strengthIncrement];
    if (self.speedIncrement == 0) self.adjustedSpeedLabel.text = [NSString stringWithFormat:@" "];
    else self.adjustedSpeedLabel.text = [NSString stringWithFormat:@"+ %d", self.speedIncrement];
    if (self.enduranceIncrement == 0) self.adjustedEnduranceLabel.text = [NSString stringWithFormat:@" "];
    else self.adjustedEnduranceLabel.text = [NSString stringWithFormat:@"+ %d", self.enduranceIncrement];
    
}

- (IBAction)savePoints {
    self.selectedDragon.baseStats.strength += self.strengthIncrement;
    self.selectedDragon.baseStats.speed += self.speedIncrement;
    self.selectedDragon.baseStats.endurance += self.enduranceIncrement;
    self.selectedDragon.availableStatPoints = self.remainingAvailableStats;
    
    
    //Save dragon
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Dragon"];
    NSMutableArray *savedDragons = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    int i = 0;
    NSManagedObject *dragonData = [savedDragons objectAtIndex:i];
    while (![[dragonData valueForKey:@"name"] isEqualToString:self.selectedDragon.name]) {
        i += 1;
        dragonData = [savedDragons objectAtIndex:i];
    }
    
    
    //set the quest data
    
    //save dragon and quest
    
    [dragonData setValue:[[NSNumber alloc] initWithInt:self.selectedDragon.baseStats.strength] forKey:@"baseStrength"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:self.selectedDragon.baseStats.speed] forKey:@"baseSpeed"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:self.selectedDragon.baseStats.endurance] forKey:@"baseEndurance"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:self.selectedDragon.availableStatPoints] forKey:@"availableStatPoints"];
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

    //calculate dragon's effective stats again
    [self.selectedDragon calculateEffectiveStats];
    
    
    [self closeOpenStatsView];
    
}

- (IBAction)clearPoints {
    self.adjustedStrengthLabel.text = [NSString stringWithFormat:@" "];
    self.adjustedSpeedLabel.text = [NSString stringWithFormat:@" "];
    self.adjustedEnduranceLabel.text = [NSString stringWithFormat:@" "];
    
    self.strengthIncrement = 0;
    self.speedIncrement = 0;
    self.enduranceIncrement = 0;
    
    self.remainingAvailableStats = self.maxAvailableStats;
    self.availableStatsLabel.text = [NSString stringWithFormat:@"Available Points:%d", self.remainingAvailableStats];
    
    self.strengthPlus.enabled = YES;
    self.speedPlus.enabled = YES;
    self.endurancePlus.enabled = YES;
    
    self.strengthMinus.enabled = NO;
    self.speedMinus.enabled = NO;
    self.enduranceMinus.enabled = NO;
    
    self.statToStartAddingExtraPoints = strength;
    
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)release:(UIButton *)sender {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator startAnimating];
    OCDragon *dragonToRelease = [self.sortedDragonsArray objectAtIndex:sender.tag];
    [appDelegate.player.dragonList removeObject:dragonToRelease];
    
    //delete dragon from core data
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Dragon"];
    NSMutableArray *savedDragons = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    int i = 0;
    NSManagedObject *dragonData = [savedDragons objectAtIndex:i];
    while (![[dragonData valueForKey:@"name"] isEqualToString:dragonToRelease.name]) {
        i += 1;
        dragonData = [savedDragons objectAtIndex:i];
    }
    [context deleteObject:dragonData];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    for (UIView *subview in self.scrollView.subviews) {
        [subview removeFromSuperview];
    }
    //NSLog(@"subview count: %d", [self.scrollView.subviews count]);
    
    //get ready for a refresh
    self.selectedStatsViewButton = nil;
    [self.heighConstraintsForStatsViews removeAllObjects];
    [self setDragonListScene];
    [activityIndicator stopAnimating];
    //[self.view setNeedsDisplay];
}

- (IBAction)goBack {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
