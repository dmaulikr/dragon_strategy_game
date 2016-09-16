//
//  Region_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 2.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "Region_ViewController.h"

@interface Region_ViewController ()

//@property OCDragon *selectedDragon;
@property int selectedDragonIndex; //index in dragonsBeingShown
//@property UILabel *selectedDragonNameLabel;
@property OCQuest *selectedQuest;

//@property NSMutableArray *nameLabels;
//@property NSMutableArray *dragonsBeingShown;

//@property NSMutableArray *questList; //includes quest objects inside
@property NSMutableArray *questButtonList;

@property NSArray *sortedDragonsArray;
@property NSMutableArray *availableDragons;
@property NSMutableArray *nonAvailableDragons;//Dragons that can't go because of energy/endurance problems.
@property NSMutableArray *nonAvailabilityReason; /*0 = not enough max energy, 1 = not enough current energy but max is sufficient */
@property NSMutableArray *dragonButtons;

//colors here
@property UIColor *dragonButtonColorForNormalState;
@property UIColor *dragonButtonColorForSelectedState;

@property NSTimer *timer;

//@property NSMutableArray *savedQuests;

@end

@implementation Region_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //self.questList = [[NSMutableArray alloc] init];
    
    //self.nameLabels = [[NSMutableArray alloc] init];
    //self.dragonsBeingShown = [[NSMutableArray alloc] init];
    
    self.dragonButtonColorForNormalState = [UIColor colorWithRed:0.20 green:0.19 blue:0.19 alpha:1.0];
    self.dragonButtonColorForSelectedState = [UIColor colorWithRed:0.70 green:0.08 blue:0.08 alpha:1.0];
    
    //create arrays
    self.availableDragons = [[NSMutableArray alloc] init];
    self.nonAvailableDragons = [[NSMutableArray alloc] init];
    self.nonAvailabilityReason = [[NSMutableArray alloc] init];
    self.dragonButtons = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.20 green:0.19 blue:0.19 alpha:1.0];
    self.dragonScrollView.backgroundColor = [UIColor colorWithRed:0.30 green:0.28 blue:0.28 alpha:1.0];
    self.questInformationContainer.backgroundColor = [UIColor clearColor];
    [self.startQuestButton setBackgroundColor:[UIColor colorWithRed:0.70 green:0.08 blue:0.08 alpha:1.0]];
    [self.startQuestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    CAGradientLayer *topGradient = [CAGradientLayer layer];
    topGradient.frame = self.topBoundary.bounds;
    topGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.70 green:0.07 blue:0.07 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:0.28 green:0.19 blue:0.19 alpha:1.0] CGColor], nil];
    [self.topBoundary.layer insertSublayer:topGradient atIndex:0];
    
    self.questButtonList = [[NSMutableArray alloc] init];
    
    self.selectedDragonIndex = -1;
    
    self.questLengthTitle.alpha = 0.0;
    self.questLengthVal.alpha = 0.0;
    self.questSuccessChanceTitle.alpha = 0.0;
    self.questSuccessChanceVal.alpha = 0.0;
    self.dragonCapacityTitle.alpha = 0.0;
    self.dragonCapacityVal.alpha = 0.0;
    self.regionImageView.userInteractionEnabled = YES;
    
    //Button activity
    self.startQuestButton.enabled = NO;
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.startQuestButton.alpha = 0.6;
     }
                     completion:nil];
    

    self.region = [appDelegate.regionList objectAtIndex:self.regionIndex];
    OCQuest *explorationQuest = [self.region.questList objectAtIndex:0];
    
    //region has already been explored
    if ([self.region isExplored]) {
        [self generateQuestButtons:self.region.questButtonCoordinates];
        for (UIButton *button in self.questButtonList) {
            [button setBackgroundColor:[UIColor redColor]];
        }
    }
    
    
    //region is being explored
    else if (explorationQuest.numberOfDragonsCurrentlyOnThisQuest > 0) {
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topBoundary.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.topBoundary.frame.size.height)];
        
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.6;
        [self.view addSubview:maskView];
        
        
        UIView *labelContainer = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/3, self.view.frame.size.width/2, self.view.frame.size.height/7)];
        CAGradientLayer *alertGradient = [CAGradientLayer layer];
        alertGradient.frame = labelContainer.bounds;
        alertGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.70 green:0.07 blue:0.07 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:0.28 green:0.19 blue:0.19 alpha:1.0] CGColor], nil];
        [labelContainer.layer insertSublayer:alertGradient atIndex:0];
        [self.view addSubview:labelContainer];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelContainer.frame.size.width, labelContainer.frame.size.height)];
        [label setText:@"This region is being explored"];
        [label setTextColor:[UIColor whiteColor]];
        label.textAlignment = NSTextAlignmentCenter;
        [labelContainer addSubview:label];
    }
    
    else {
        self.selectedQuest = [self.region.questList objectAtIndex:0];
        [self.questInstructionLabel setText:@"Select dragon for exploration"];
        [self.startQuestButton setTitle:@"Explore Region" forState:UIControlStateNormal];
        self.questLengthTitle.alpha = 1.0;
        self.questLengthVal.alpha = 1.0;
    }
    
    
    [self setImageViewAndQuestButtons];
    //[self.region placeButtonsOn:self.regionView];
    
    //sort the dragons
    self.sortedDragonsArray = [appDelegate.player.dragonList sortedArrayUsingSelector:@selector(compareAccordingToLevelAndFavorite:)];
    
    
    //Set up NSNotificationCenter
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(selectDragon:)
            name:@"SelectedDragonForQuest"
                object:nil];
    
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

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    if (![self.region isExplored]) //Set the dragons
        [self setScrollViewForQuest:self.selectedQuest];
}

//creates the buttons but doesn't add them to the view
-(void) generateQuestButtons:(NSMutableArray *) coordinates {
    
    for (unsigned int i = 0; i < [coordinates count]; i+=2) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(loadQuest:) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake([[coordinates objectAtIndex:i] doubleValue], [[coordinates objectAtIndex:i+1] doubleValue], 40, 40); //change size vals
        
        //To make buttons round. Check if works with images!
        button.layer.cornerRadius = button.bounds.size.width/2;
        button.tag = i/2 + 1; //quest at index 0 is the exploration
        
        //[view addSubview:button];
        
        OCQuest *quest = [self.region.questList objectAtIndex:i/2];
        
        if (quest.requiredType == OCfire) {
            UIImage *buttonImage = [UIImage imageNamed:@"fireTypeQuestButtonUp"];
            [button setImage:buttonImage forState:UIControlStateNormal];
        }
        
        else if (quest.requiredType == OCwater) {
            UIImage *buttonImage = [UIImage imageNamed:@"waterTypeQuestButtonUp"];
            [button setImage:buttonImage forState:UIControlStateNormal];
        }
        
        else if (quest.requiredType == OCwind) {
            UIImage *buttonImage = [UIImage imageNamed:@"windTypeQuestButtonUp"];
            [button setImage:buttonImage forState:UIControlStateNormal];
        }
        
        
        
        [self.questButtonList addObject:button];
    }
    
    
}

-(void) setImageViewAndQuestButtons {
    
    self.regionImageView.image = [UIImage imageNamed: @"main_map.png"]; //might need to change this
    self.regionImageView.backgroundColor = [UIColor blueColor];
    //self.regionImageView.contentMode = UIViewContentModeCenter;
    //self.regionImageView.clipsToBounds = YES;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self.regionImageView.image CGImage], CGRectMake(self.region.imageOrigin.x, self.region.imageOrigin.y, self.region.imageSize.width, self.region.imageSize.height));
    UIImage *cropimage = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    self.regionImageView.image = cropimage;
    
    for (UIButton *button in self.questButtonList) {
        /*[button addTarget:self
                   action:@selector(loadQuest) forControlEvents:UIControlEventTouchUpInside]; */
        [self.regionImageView addSubview:button];
    }
}

-(IBAction) loadQuest:(UIButton *) sender {
    
    //maybe prevent the user from pressing on the same quest and losing the selected dragon
    //or maybe disable the quest button until another one is pressed
    
    
    
    //stop the timer
    [self.timer invalidate];
    
    self.questLengthVal.text = @"";
    self.questSuccessChanceVal.text = @"";
    self.dragonCapacityVal.text = @"";
    
    self.startQuestButton.enabled = NO;
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.startQuestButton.alpha = 0.6;
         
     }
                     completion:nil];

    
    //self.questInstructionLabel.alpha = 0.0;
    [self.questInstructionLabel setText:@"No dragons selected"];
    //self.questInstructionLabel.alpha = 1.0;
    
    if (self.selectedQuest == nil) {
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
         {
             self.questLengthTitle.alpha = 1.0;
             self.questSuccessChanceTitle.alpha = 1.0;
             self.dragonCapacityTitle.alpha = 1.0;
         }
                         completion:nil];
        
        self.questLengthVal.alpha = 1.0;
        self.questSuccessChanceVal.alpha = 1.0;
        self.dragonCapacityVal.alpha = 1.0;
    }
    
    self.selectedQuest = [self.region.questList objectAtIndex:sender.tag];
    [self setScrollViewForQuest:self.selectedQuest];
    self.selectedDragonIndex = -1;
    
    
    //start the timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCheck) userInfo:nil repeats:YES ];
    
    NSLog(@"QuestLoaded");
}

-(void) setScrollViewForQuest:(OCQuest *) quest {
    //clear contents of the scrollview
    [self.dragonScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.availableDragons removeAllObjects];
    [self.nonAvailableDragons removeAllObjects];
    [self.nonAvailabilityReason removeAllObjects];
    [self.dragonButtons removeAllObjects];
    
    self.selectedDragonIndex = -1;
    int buttonsAdded = 0;
    
    int buttonWidth = self.dragonScrollView.frame.size.height/9*16;
    int imageBorder = 1;
    
    for (OCDragon *dragon in appDelegate.player.dragonList) {
        if (!dragon.onQuest && dragon.type == quest.requiredType) {
            
            //not enough max energy
            if ([dragon maxEnergy] < [self.selectedQuest calculateEnergyRequirement]) {
                [self.nonAvailableDragons addObject:dragon];
                [self.nonAvailabilityReason addObject:@0];
            }
            
            //not enough current energy
            else if (dragon.energy < [self.selectedQuest calculateEnergyRequirement]) {
                [self.nonAvailableDragons addObject:dragon];
                [self.nonAvailabilityReason addObject:@1];
            }
            
            //is available
            else {
                [self.availableDragons addObject:dragon];
            }
        }
    }
    
    for (OCDragon *dragon in self.availableDragons) {
        DragonViewForSelection *button = [[DragonViewForSelection alloc] initWithFrame:CGRectMake(buttonsAdded*buttonWidth, 0, buttonWidth, self.dragonScrollView.frame.size.height) inside:self.dragonScrollView forDragon:dragon withNormalStateColor:self.dragonButtonColorForNormalState withSelectedStateColor:self.dragonButtonColorForSelectedState withType:AvailableForQuest withIndex:buttonsAdded];
        
        [self.dragonButtons addObject:button];
        
        buttonsAdded += 1;
    }
    
    int counter = 0;
    for (OCDragon *dragon in self.nonAvailableDragons) {
        DragonViewForSelection *button = [[DragonViewForSelection alloc] initWithFrame:CGRectMake(buttonsAdded*buttonWidth, 0, buttonWidth, self.dragonScrollView.frame.size.height) inside:self.dragonScrollView forDragon:dragon withNormalStateColor:self.dragonButtonColorForNormalState withSelectedStateColor:self.dragonButtonColorForSelectedState withType:NotAvailableForQuest withIndex:counter];
        //not enough max energy
        if ([[self.nonAvailabilityReason objectAtIndex:counter]intValue] == 0) {
            [button setTextForFilterLabel:@"Need more endurance"];
        }
        //not enough current energy
        else {
            button.whenTheCountDownEnds = [self calculateWhenTheDragonWillHaveEnoughEnergy:dragon];
        }
        
        [self.dragonButtons addObject:button];
        
        buttonsAdded += 1;
        counter += 1;
    }
    
 
    self.dragonScrollView.contentSize = CGSizeMake(buttonWidth*buttonsAdded, self.dragonScrollView.frame.size.height);
}

- (void)selectDragon:(NSNotification *) notification {
    
    //hide the title label
    [self.questInstructionLabel setText:@"Ready to fly"];
    
    
    if (self.selectedDragonIndex != -1) {
        DragonViewForSelection *previouslySelectedButton = [self.dragonButtons objectAtIndex:self.selectedDragonIndex];
        [previouslySelectedButton deselect];
    }
    
    self.selectedDragonIndex = [notification.object intValue];
    
    DragonViewForSelection *selectedButton = [self.dragonButtons objectAtIndex:self.selectedDragonIndex];
    
    OCDragon *selectedDragon = selectedButton.dragon;
    
    //check this line
    self.questLengthVal.text = [self stringFromTimeInterval:[selectedDragon calculateLengthForQuestWithDifficulty:self.selectedQuest.difficultyLevel isExploration:(self.selectedQuest.index == 0)]];
    self.questSuccessChanceVal.text = [NSString stringWithFormat:@"%d%%", [self.selectedQuest successRate0To100:selectedDragon]];
    self.dragonCapacityVal.text = [NSString stringWithFormat:@"%d", [self.selectedQuest calculateGoldRewardEstimate]];
    
    self.startQuestButton.enabled = YES;
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.startQuestButton.alpha = 1.0;
     }
                     completion:nil];
    
    NSLog(@"%@ says sup", selectedDragon.name);
}


- (IBAction)startQuest:(id)sender {
    //choose the correct dragon
    DragonViewForSelection *selectedButton = [self.dragonButtons objectAtIndex:self.selectedDragonIndex];
    [selectedButton select];
    
    OCDragon *selectedDragon = selectedButton.dragon;
    
    //set the dragon data to save later
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Dragon"];
    NSMutableArray *savedDragons = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] initWithEntityName:@"Quest"];
    NSMutableArray *savedQuests = [[context executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
    
    int i = 0;
    NSManagedObject *dragonData = [savedDragons objectAtIndex:i];
    while (![[dragonData valueForKey:@"name"] isEqualToString:selectedDragon.name]) {
        i += 1;
        dragonData = [savedDragons objectAtIndex:i];
    }
    
    //set quest data to save later
    NSManagedObject *questData;
    for (NSManagedObject *data in savedQuests) {
        int regionNo = [[data valueForKey:@"regionNo"] intValue];
        int questIndex = [[data valueForKey:@"index"] intValue];
        if (regionNo == self.selectedQuest.regionNo && questIndex == self.selectedQuest.index) {
            questData = data;
            break;
        }
    }
    
    //send dragon to quest
    [selectedDragon goToQuestNumber:self.selectedQuest.index atRegion:self.selectedQuest.regionNo withDifficultyLevel:self.selectedQuest.difficultyLevel];
    
    self.selectedQuest.numberOfDragonsCurrentlyOnThisQuest += 1;
    
    //save dragon and quest
    
    [dragonData setValue:[NSNumber numberWithBool:selectedDragon.onQuest] forKey:@"onQuest"];
    [dragonData setValue:selectedDragon.questInfo.endDate forKey:@"questEndDate"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:selectedDragon.questInfo.questNo] forKey:@"questNo"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:selectedDragon.questInfo.regionNo] forKey:@"questRegionNo"];
    [dragonData setValue:selectedDragon.questInfo.startDate forKey:@"questStartDate"];
    
    
    [questData setValue:[[NSNumber alloc] initWithInt:self.selectedQuest.counter] forKey:@"counter"];
    [questData setValue:self.selectedQuest.lastCounterUpdate forKey:@"lastCounterUpdate"];
    [questData setValue:[[NSNumber alloc] initWithInt:self.selectedQuest.numberOfDragonsCurrentlyOnThisQuest] forKey:@"numberOfDragonsCurrentlyOnThisQuest"];
    [questData setValue:[NSNumber numberWithBool:self.selectedQuest.successfullyCompletedAtLeastOnce] forKey:@"successfullyCompletedAtLeastOnce"];
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
         
    [self setScrollViewForQuest:self.selectedQuest];
    self.selectedDragonIndex = -1;
    
    // if user starts exploring the region, go back to map
    if (self.selectedQuest.index == 0) [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)backButton:(id)sender {
    [self.timer invalidate];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval {
    NSInteger time = (NSInteger)timeInterval;
    NSInteger seconds = time % 60;
    NSInteger minutes = (time / 60) % 60;
    NSInteger hours = (time / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

//core data stuff
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

//for the dragons who don't have enough energy, this function updates how long until they do
- (void)timerCheck {
    int offsetCount = [self.availableDragons count];
    for (int i = 0; i < [self.nonAvailabilityReason count]; i += 1) {
        int reason = [[self.nonAvailabilityReason objectAtIndex:i] intValue];
        if (reason == 1) {
            DragonViewForSelection *button = [self.dragonButtons objectAtIndex:(offsetCount+i)];
            OCDragon *dragon = [self.nonAvailableDragons objectAtIndex:i];
            NSTimeInterval secondsNeededToGetReady = [button.whenTheCountDownEnds timeIntervalSinceDate:[NSDate date]];
            
            NSString *text;
            
            //add shortcuts for user experience later
            if (secondsNeededToGetReady <= 0) {
                /*if (self.selectedDragonIndex = -1) {
                    
                } */
                
                text = @"Ready!\nRefresh";
            }
            
            else {
                text = [NSString stringWithFormat:@"Ready In\n%@", [self stringFromTimeInterval:secondsNeededToGetReady]];
            }
            [button setTextForFilterLabel:text];
        }
    }
}

- (NSDate *)calculateWhenTheDragonWillHaveEnoughEnergy:(OCDragon *)dragon{
    int howMuchMoreEnergyTheDragonNeeds = [self.selectedQuest calculateEnergyRequirement] - dragon.energy;
    NSDate *nextEnergyUpdate = [NSDate dateWithTimeInterval:60 sinceDate:appDelegate.player.lastEnergyUpdateDate];
    NSTimeInterval timeNeeded = [nextEnergyUpdate timeIntervalSinceDate:[NSDate date]];
    timeNeeded += 60 * (howMuchMoreEnergyTheDragonNeeds-1);
    return [NSDate dateWithTimeInterval:timeNeeded sinceDate:[NSDate date]];
}

@end
