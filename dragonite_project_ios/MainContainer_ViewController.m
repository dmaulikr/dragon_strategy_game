//
//  MainContainer_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 23.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "MainContainer_ViewController.h"

enum clickableViewType {noView, goldView, gemView, dragonView};
enum boostType {ad, gold, experience, luck};

@interface MainContainer_ViewController ()

@end

@implementation MainContainer_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //check viewdidload gradient explanation to understand this
    self.topBoundary.backgroundColor = [UIColor colorWithRed:0.03 green:0.03 blue:0.03 alpha:1.0];
    
    /*self.viewToHide = [[UIView alloc] initWithFrame:self.view.bounds];
    self.viewToHide.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.viewToHide]; */
    
    self.gemLabel.textColor = [UIColor whiteColor];
    self.goldLabel.textColor = [UIColor whiteColor];
    self.dragonLabel.textColor = [UIColor whiteColor];
    
    
    //deal with progress view
    self.goldProgressView.progressTintColor = [UIColor colorWithRed:1.00 green:0.76 blue:0.03 alpha:1.0];
    self.goldProgressView.trackTintColor = [UIColor colorWithRed:0.60 green:0.55 blue:0.55 alpha:1.0];
    self.goldProgressView.alpha = 0.6;
    
    
    //set up child views
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.mapView = [storyboard instantiateViewControllerWithIdentifier:@"Map_ViewController"];
    self.baseView = [storyboard instantiateViewControllerWithIdentifier:@"Base_ViewController"];
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setBarContents];
    
    //Set map/base button image
    //[self.changeChildButton setImage:[UIImage imageNamed:@"baseButtonUp.png"] forState:UIControlStateNormal];
    
    //add tags to clickable views
    self.goldIconImageView.tag = goldView;
    self.goldProgressContainerView.tag = goldView;
    self.gemIconImageView.tag = gemView;
    self.gemLabel.tag = gemView;
    self.dragonIconImageView.tag = dragonView;
    self.dragonLabel.tag = dragonView;
    
    
    //add gestures
    UILongPressGestureRecognizer *longPressTopBar = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector (showExplanation:)];
    longPressTopBar.minimumPressDuration = 0.05;
    longPressTopBar.cancelsTouchesInView = NO;
    [self.topBoundary addGestureRecognizer:longPressTopBar];
    self.topBoundary.userInteractionEnabled = YES;
    
    //set animation dates
    self.lastResetButtonAnimationDate = [NSDate dateWithTimeIntervalSinceNow:-30];
    self.lastSettingsButtonAnimationDate = [NSDate date];
    
    //create the side notification center
    self.sideNotificationCenter = [[SideNotificationCenter alloc] initWithMaxNumberOfNotifications:5];
    self.sideNotificationCenter.startingColorComponents = [[NSArray alloc] initWithObjects:@0.08, @0.08, @0.08, @1.0, nil];
    self.sideNotificationCenter.endingColorComponents = [[NSArray alloc] initWithObjects:@0.08, @0.08, @0.08, @0.0, nil];
    self.sideNotificationCenter.notificationDuration = 10;
    self.sideNotificationCenter.viewToPresentOn = self.view;
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

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    //more adjustments on the notification center
    int notificationViewHeight = 25;
    self.sideNotificationCenter.spaceBetweenViews = 2;
    self.sideNotificationCenter.bottomCoordinate = CGPointMake(0, self.achievementButton.frame.origin.y - 5);
    self.sideNotificationCenter.viewSize = CGSizeMake(self.view.frame.size.width/2, notificationViewHeight);
    
    
    //adding the gradient here so that the bounds are ok, but we still add a background
    //color before so that the transition to the gradient is not very noticable.
    CAGradientLayer *topGradient = [CAGradientLayer layer];
    topGradient.frame = self.topBoundary.bounds;
    topGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.03 green:0.03 blue:0.03 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:0.35 green:0.34 blue:0.34 alpha:1.0] CGColor], nil];
    [self.topBoundary.layer insertSublayer:topGradient atIndex:0];
    
    [self addChildViewController:self.mapView];
    self.mapView.view.frame = CGRectMake(0, self.topBoundary.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.topBoundary.frame.size.height);
    [self.view addSubview:self.mapView.view];
    [self.mapView didMoveToParentViewController:self];
    
    //send map view to back so that the buttons will appear
    [self.view sendSubviewToBack:self.mapView.view];
    
    self.mainTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCheck) userInfo:nil repeats:YES ];
    self.mapView.timerInMainContainer = self.mainTimer; //set the timer for the map
    
    //[self animateSettingsButton];
    //[self.viewToHide removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.dragonLabel.text = [NSString stringWithFormat:@"%d/%d", [appDelegate.player numberOfDragonsAvailable], (int)[appDelegate.player.dragonList count]];
}

//- (void)viewWillLayoutSubviews {
    
    /*[self addChildViewController:self.mapView];
    self.mapView.view.frame = CGRectMake(0, self.topBoundary.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.topBoundary.frame.size.height);
    [self.view addSubview:self.mapView.view];
    [self.mapView didMoveToParentViewController:self];
    
    //send map view to back so that the buttons will appear
    [self.view sendSubviewToBack:self.mapView.view];*/
    
    //Bring subviews to front
    /*[self.view bringSubviewToFront:self.changeChildButton];
    [self.view bringSubviewToFront:self.dragonsButton];
    [self.view bringSubviewToFront:self.resetButton];
    [self.view bringSubviewToFront:self.achievementButton];*/
//}

-(void) timerCheck {
    
    [self setBarContents];
    
    //fetch dragons and player
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Dragon"];
    self.savedDragons = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] initWithEntityName:@"Player"];
    self.savedPlayers = [[context executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
    
    NSFetchRequest *fetchRequest3 = [[NSFetchRequest alloc] initWithEntityName:@"Quest"];
    self.savedQuests = [[context executeFetchRequest:fetchRequest3 error:nil] mutableCopy];
    
    //quest end check
    for (OCDragon *dragon in appDelegate.player.dragonList) {
        if (dragon.onQuest && ([[NSDate date] compare:dragon.questInfo.endDate] == NSOrderedDescending)) {
            OCRegion *region = [appDelegate.regionList objectAtIndex:dragon.questInfo.regionNo];
            OCQuest *quest = [region.questList objectAtIndex:dragon.questInfo.questNo];
            [quest finishQuest:dragon and:appDelegate.player];
            
            //save dragon and player
            [self saveDragonAfterQuest:dragon];
            [self savePlayerAfterQuest:appDelegate.player];
            //well, we should probably save the quest too...
            [self saveQuestAfterQuest:quest];
            
            /*NSError *error = nil;
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            } */
            
            
            //TTEEEESSTTT--DELETE LATER
            //[[appDelegate.mythicalDragonList objectAtIndex:0] hasBeenDiscovered];
        }
    }
    
    
    //dragon energy regen
    if (([[NSDate date] compare:[NSDate dateWithTimeInterval:appDelegate.player.energyRegenTimeInterval sinceDate:appDelegate.player.lastEnergyUpdateDate]] == NSOrderedDescending)) {
        
        [appDelegate.player updateDragonEnergies];
        
        for (OCDragon *dragon in appDelegate.player.dragonList) {
            [self saveDragonAfterEnergyUpdate:dragon];
        }
        
        [self savePlayerAfterEnergyUpdate:appDelegate.player];
        
        NSLog(@"Updated dragon energies");
        
        /*NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }*/
    }
    
    
    //Work on this later!!!!!!
    
    //check for achievements every 5~ seconds
    if (([[NSDate date] compare:[NSDate dateWithTimeInterval:5 sinceDate:appDelegate.lastAchievementCheckDate]] == NSOrderedDescending)) {
        
        for (OCAchievement *achievement in appDelegate.achievementList) {
            if (!achievement.unlocked && [achievement check:appDelegate.player]) {
                achievement.unlocked = YES;
                [self.sideNotificationCenter addNewNotificationWithText:[achievement getNotificationText]];
            }
        }
        
        appDelegate.lastAchievementCheckDate = [NSDate date];
    }
    
    
    //boosts and bonuses
    BOOL boostGotDeactivated = NO;
    //adbonus
    if (appDelegate.player.adBonusIsActive == YES && ([[NSDate date] compare:appDelegate.player.adBonusEndDate] == NSOrderedDescending)) {
        appDelegate.player.adBonusIsActive = NO;
        boostGotDeactivated = YES;
    }
    
    if (appDelegate.player.goldBoostIsActive == YES && ([[NSDate date] compare:appDelegate.player.goldBoostEndDate] == NSOrderedDescending)) {
        appDelegate.player.goldBoostIsActive = NO;
        boostGotDeactivated = YES;
    }
    
    if (appDelegate.player.expBoostIsActive == YES && ([[NSDate date] compare:appDelegate.player.expBoostEndDate] == NSOrderedDescending)) {
        appDelegate.player.expBoostIsActive = NO;
        boostGotDeactivated = YES;
    }
    
    if (appDelegate.player.luckBoostIsActive == YES && ([[NSDate date] compare:appDelegate.player.luckBoostEndDate] == NSOrderedDescending)) {
        appDelegate.player.luckBoostIsActive = NO;
        boostGotDeactivated = YES;
    }
    
    if (boostGotDeactivated) {
        [self savePlayerAfterBoostCheck:appDelegate.player];
        
        /*NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }*/
    }
    
    
    //animations
    
    //reset button
    if (([[NSDate date] compare:[NSDate dateWithTimeInterval:10 sinceDate:self.lastResetButtonAnimationDate]] == NSOrderedDescending)) {
        self.lastResetButtonAnimationDate = [NSDate date];
        [self animateResetButton];
    }
    
    //settings button
    if (([[NSDate date] compare:[NSDate dateWithTimeInterval:15 sinceDate:self.lastSettingsButtonAnimationDate]] == NSOrderedDescending)) {
        self.lastSettingsButtonAnimationDate = [NSDate date];
        [self animateSettingsButton];
    }
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    //NSLog(@"time...");
    //sleep(2);
}



- (void)closeAchievementNotification {
    [self.achievementLabel removeFromSuperview];
}

- (IBAction)changeChildView:(id)sender {
    
    //To Base
    if (self.currentChildView == Map) {
        self.currentChildView = Base;
        [self.changeChildButton setImage:[UIImage imageNamed:@"mapButtonUp.png"] forState:UIControlStateNormal];
        
        [self.mapView willMoveToParentViewController:nil];
        [self.mapView.view removeFromSuperview];
        [self.mapView removeFromParentViewController];
        
        [self addChildViewController:self.baseView];
        self.baseView.view.frame = CGRectMake(0, self.topBoundary.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.topBoundary.frame.size.height);
        //self.baseView.view.frame = CGRectMake(10, 10, 500, 300);
        [self.view addSubview:self.baseView.view];
        [self.baseView didMoveToParentViewController:self];
    }
    
    //To Map
    else {
        self.currentChildView = Map;
        [self.changeChildButton setImage:[UIImage imageNamed:@"baseButtonUp.png"] forState:UIControlStateNormal];
        
        [self.baseView willMoveToParentViewController:nil];
        [self.baseView.view removeFromSuperview];
        [self.baseView removeFromParentViewController];
        
        [self addChildViewController:self.mapView];
        self.mapView.view.frame = CGRectMake(0, self.topBoundary.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.topBoundary.frame.size.height);
        [self.view addSubview:self.mapView.view];
        [self.mapView didMoveToParentViewController:self];
    }
    
    [self.view bringSubviewToFront:self.changeChildButton];
    [self.view bringSubviewToFront:self.dragonsButton];
    
}

- (IBAction)resetAction:(id)sender {
    NSLog(@"reset");
}

- (void)setBarContents {
    self.gemLabel.text = [NSString stringWithFormat:@"%d", appDelegate.player.gem];
    self.goldLabel.text = [NSString stringWithFormat:@"%d", appDelegate.player.gold];
    self.dragonLabel.text = [NSString stringWithFormat:@"%d/%d", [appDelegate.player numberOfDragonsAvailable], (int)[appDelegate.player.dragonList count] ];
    
    self.goldProgressView.progress = (float)appDelegate.player.gold/(float)appDelegate.player.maxGold;
}


//we need to invalidate the timer when we switch to the dragon list
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /*if ([[segue identifier] isEqualToString:@"ShowDragonList"])
    {
        [self.mainTimer invalidate];
    }*/
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)saveDragonAfterQuest:(OCDragon *) dragonToBeSaved {
    
    int i = 0;
    NSManagedObject *dragonData = [self.savedDragons objectAtIndex:i];
    while (![[dragonData valueForKey:@"name"] isEqualToString:dragonToBeSaved.name]) {
        i += 1;
        dragonData = [self.savedDragons objectAtIndex:i];
    }
    
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.availableStatPoints] forKey:@"availableStatPoints"];
    
    [dragonData setValue:[[NSNumber alloc] initWithDouble:dragonToBeSaved.energy] forKey:@"energy"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.experience] forKey:@"experience"];
    
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.level] forKey:@"level"];
    [dragonData setValue:[NSNumber numberWithBool:dragonToBeSaved.onQuest] forKey:@"onQuest"];
    
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.questsCompleted] forKey:@"questsCompleted"];
}

- (void)saveDragonAfterEnergyUpdate:(OCDragon *) dragonToBeSaved {
    
    int i = 0;
    NSManagedObject *dragonData = [self.savedDragons objectAtIndex:i];
    while (![[dragonData valueForKey:@"name"] isEqualToString:dragonToBeSaved.name]) {
        i += 1;
        dragonData = [self.savedDragons objectAtIndex:i];
    }
    
    [dragonData setValue:[[NSNumber alloc] initWithDouble:dragonToBeSaved.energy] forKey:@"energy"];
}

- (void)savePlayerAfterQuest:(OCPlayer *) playerToBeSaved {
    
    NSManagedObject *playerData = [self.savedPlayers objectAtIndex:0];
    
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.gem] forKey:@"gem"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.gold] forKey:@"gold"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.highestQuestDifficultyAchievedInCurrentReset] forKey:@"highestQuestDifficultyAchievedInCurrentReset"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.numberOfDifferentQuestsCompleted] forKey:@"numberOfDifferentQuestsCompleted"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.totalNumberOfQuestsCompleted] forKey:@"totalNumberOfQuestsCompleted"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.numberOfDragonsFound] forKey:@"numberOfDragonsFound"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.numberOfMythicalDragonsDiscovered] forKey:@"numberOfMythicalDragonsDiscovered"];
    
}

- (void)savePlayerAfterEnergyUpdate:(OCPlayer *) playerToBeSaved {
    NSManagedObject *playerData = [self.savedPlayers objectAtIndex:0];
    [playerData setValue:playerToBeSaved.lastEnergyUpdateDate forKey:@"lastEnergyUpdateDate"];
}

- (void)savePlayerAfterBoostCheck:(OCPlayer *) playerToBeSaved {
    NSManagedObject *playerData = [self.savedPlayers objectAtIndex:0];
    [playerToBeSaved setValue:[NSNumber numberWithBool:playerToBeSaved.adBonusIsActive] forKey:@"adBonusIsActive"];
    [playerToBeSaved setValue:[NSNumber numberWithBool:playerToBeSaved.goldBoostIsActive] forKey:@"goldBoostIsActive"];
    [playerToBeSaved setValue:[NSNumber numberWithBool:playerToBeSaved.expBoostIsActive] forKey:@"expBoostIsActive"];
    [playerToBeSaved setValue:[NSNumber numberWithBool:playerToBeSaved.luckBoostIsActive] forKey:@"luckBoostIsActive"];
}

- (void)saveQuestAfterQuest:(OCQuest *) questToBeSaved {
    
    //find the quest in core data
    NSManagedObject *questData;
    for (NSManagedObject *data in self.savedQuests) {
        int regionNo = [[data valueForKey:@"regionNo"] intValue];
        int questIndex = [[data valueForKey:@"index"] intValue];
        if (regionNo == questToBeSaved.regionNo && questIndex == questToBeSaved.index) {
            questData = data;
            break;
        }
    }
    
    [questData setValue:[[NSNumber alloc] initWithInt:questToBeSaved.counter] forKey:@"counter"];
    [questData setValue:questToBeSaved.lastCounterUpdate forKey:@"lastCounterUpdate"];
    [questData setValue:[[NSNumber alloc] initWithInt:questToBeSaved.numberOfDragonsCurrentlyOnThisQuest] forKey:@"numberOfDragonsCurrentlyOnThisQuest"];
    [questData setValue:[NSNumber numberWithBool:questToBeSaved.successfullyCompletedAtLeastOnce] forKey:@"successfullyCompletedAtLeastOnce"];
}

-(IBAction) showExplanation:(UILongPressGestureRecognizer*)gesture {
    //NSLog(@"hey");
    
    //cancel if necessary
    if (self.explanationView != nil && gesture.state != UIGestureRecognizerStateEnded) return;
    
    //disappear view if button released
    if (gesture.state != UIGestureRecognizerStateBegan && self.explanationView != nil) {
        //NSLog(@"ended");
        CGRect finalFrame = self.explanationView.frame;
        finalFrame.origin.y = self.view.frame.size.height;
        
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
             self.explanationView.frame = finalFrame;
         }
                         completion:^(BOOL finished) {
                             [self.explanationView removeFromSuperview];
                             self.explanationView = nil;
                         }];
        
        
    }
    
    //show view
    else if (gesture.state == UIGestureRecognizerStateBegan && self.explanationView == nil) {
        
        //find view type
        UIView* view = gesture.view;
        CGPoint loc = [gesture locationInView:view];
        enum clickableViewType viewType;
        if (loc.x < self.goldProgressContainerView.frame.origin.x + self.goldProgressContainerView.frame.size.width)
            viewType = goldView;
        else if (loc.x > self.gemIconImageView.frame.origin.x && loc.x < self.gemIconImageView.frame.origin.x + self.gemIconImageView.frame.size.width)
            viewType = gemView;
        else if (loc.x > self.dragonIconImageView.frame.origin.x && loc.x < self.dragonIconImageView.frame.origin.x + self.dragonIconImageView.frame.size.width)
            viewType = dragonView;
        else return;
        
        
        //UIView* touchedView = [view hitTest:loc withEvent:nil];
        
        int viewHeight = 60;
        int viewWidth = self.dragonsButton.frame.origin.x - (self.changeChildButton.frame.origin.x + self.changeChildButton.frame.size.width) - 10;
        
        CGRect initialFrame = CGRectMake(self.changeChildButton.frame.origin.x + self.changeChildButton.frame.size.width + 5, self.view.frame.size.height, viewWidth, viewHeight);
        
        self.explanationView = [[UIView alloc] initWithFrame:initialFrame];
        self.explanationView.tag = viewType;
        self.explanationView.backgroundColor = [UIColor blackColor];
        self.explanationView.layer.cornerRadius = 5;
        self.explanationView.layer.masksToBounds = YES;
        
        UILabel *explanationText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
        explanationText.textColor = [UIColor whiteColor];
        switch (viewType) {
            case goldView: {
                explanationText.text = @"gold icon";
                break;
            }
            case gemView: {
                explanationText.text = @"gem icon";
                break;
            }
            case dragonView: {
                explanationText.text = @"dragon icon";
                break;
            }
            default:
                break;
        }
        
        
        [self.explanationView addSubview:explanationText];
        [self.view addSubview:self.explanationView];
        
        CGRect newFrame = self.explanationView.frame;
        newFrame.origin.y -= viewHeight;
        
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
         {
             self.explanationView.frame = newFrame;
         }
                         completion:nil];
    }
}


- (void)animateResetButton {
    int originalBottomDistance = self.resetButtonBottomConstraint.constant;
    int originalButtonHeight = self.resetButton.frame.size.height;
    int maxJumpHeight = self.view.frame.size.height / 3;
    
    [self.view layoutIfNeeded];
    //first shrink
    self.resetButtonHeightConstraint.constant = -originalButtonHeight/2;
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^
     {
         [self.view layoutIfNeeded];
     }
        completion:^(BOOL finished) {
            
            //expand before the first jump
            self.resetButtonHeightConstraint.constant = +originalButtonHeight/3;
            [UIView animateWithDuration:0.10 delay:0.3 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                [self.view layoutIfNeeded];
            }
            completion:^(BOOL finished) {
                                              
                //fly button flyy
                self.resetButtonBottomConstraint.constant += maxJumpHeight;
                [UIView animateWithDuration:0.20 delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                    [self.view layoutIfNeeded];
                }
                completion:^(BOOL finished) {
                            
                    //come back to original size and shift the bottom up a little to balance
                    self.resetButtonBottomConstraint.constant += self.resetButtonHeightConstraint.constant;
                    self.resetButtonHeightConstraint.constant = 0;
                    [UIView animateWithDuration:0.20 delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                        [self.view layoutIfNeeded];
                    }
                    completion:^(BOOL finished) {
                                                 
                        //expand as you drop to half
                        self.resetButtonHeightConstraint.constant = +originalButtonHeight/3;
                        self.resetButtonBottomConstraint.constant -= maxJumpHeight / 2;
                        [UIView animateWithDuration:0.10 delay:0.10 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                            [self.view layoutIfNeeded];
                        }
                        completion:^(BOOL finished) {
                                            
                            //fall down completely
                            self.resetButtonBottomConstraint.constant = originalBottomDistance;
                            [UIView animateWithDuration:0.10 delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                                [self.view layoutIfNeeded];
                            }
                            completion:^(BOOL finished) {
                                
                                //SECOND JUMP STUFF STARTS HERE
                                
                                //shrink before the second jump
                                self.resetButtonHeightConstraint.constant = -originalButtonHeight/2;
                                [UIView animateWithDuration:0.20 delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                                     [self.view layoutIfNeeded];
                                }
                                completion:^(BOOL finished) {
                                    
                                    //expand before the second jump
                                    self.resetButtonHeightConstraint.constant = +originalButtonHeight/3;
                                    [UIView animateWithDuration:0.07 delay:0.3 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                                        [self.view layoutIfNeeded];
                                    }
                                    completion:^(BOOL finished) {
                                        
                                        //fly for the second time
                                        self.resetButtonBottomConstraint.constant += maxJumpHeight / 2;
                                        [UIView animateWithDuration:0.10 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^ {
                                            [self.view layoutIfNeeded];
                                        }
                                        completion:^(BOOL finished) {
                                                             
                                            //come back to original size and shift the bottom up a little to balance
                                            self.resetButtonBottomConstraint.constant += self.resetButtonHeightConstraint.constant;
                                            self.resetButtonHeightConstraint.constant = 0;
                                            [UIView animateWithDuration:0.20 delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                                                [self.view layoutIfNeeded];
                                            }
                                            completion:^(BOOL finished) {
                                                                                  
                                                //expand as you drop to half (1/4 of the max height)
                                                self.resetButtonHeightConstraint.constant = +originalButtonHeight/3;
                                                self.resetButtonBottomConstraint.constant -= maxJumpHeight / 4;
                                                [UIView animateWithDuration:0.05 delay:0.10 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                                                    [self.view layoutIfNeeded];
                                                }
                                                completion:^(BOOL finished) {
                                                                                                       
                                                    //fall down completely
                                                    self.resetButtonBottomConstraint.constant = originalBottomDistance;
                                                    [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                                                        [self.view layoutIfNeeded];
                                                    }
                                                    completion:^(BOOL finished) {
                                                        //shrink again
                                                        self.resetButtonHeightConstraint.constant = -originalButtonHeight/2;
                                                        [UIView animateWithDuration:0.20 delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                                                            [self.view layoutIfNeeded];
                                                        }
                                                        completion:^(BOOL finished) {
                                                                             
                                                            //expand for the last time
                                                            self.resetButtonHeightConstraint.constant = +originalButtonHeight/3;
                                                            [UIView animateWithDuration:0.15 delay:0.20 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                                                                [self.view layoutIfNeeded];
                                                            }
                                                            completion:^(BOOL finished) {
                                                                //shrink back and DONE :)!
                                                                self.resetButtonHeightConstraint.constant = 0;
                                                                [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^ {
                                                                    [self.view layoutIfNeeded];
                                                                }
                                                                completion:nil
                                                                ];
                                                            }];
                                                        }];
                                                    }];
                                                }];
                                            }];
                                        }];
                                    }];
                                }];
                            }];
                        }];
                    }];
                }];
            }];
        }];
}

- (void)animateSettingsButton {
    int originalWidth = self.settingsButton.frame.size.width;
    [self.view layoutIfNeeded];
    //expand
    self.settingsButtonHeightConstraint.constant = originalWidth / 4;
    [UIView animateWithDuration:0.20 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^ {
         [self.view layoutIfNeeded];
     }
                     completion:^(BOOL finished) {
                         CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                         animation.fromValue = [NSNumber numberWithFloat:0.0f];
                         animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
                         animation.duration = 0.4f;
                         animation.repeatCount = 1;
                         animation.removedOnCompletion = YES;
                         [self.settingsButton.layer addAnimation:animation forKey:@"SpinAnimation"];
                         
                         [self.view layoutIfNeeded];
                         //shrink
                         self.settingsButtonHeightConstraint.constant = 0;
                         [UIView animateWithDuration:0.20 delay:0.7 options:UIViewAnimationOptionCurveLinear animations:^
                          {
                              [self.view layoutIfNeeded];
                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
    
    
    
}

- (void)reset {
    [appDelegate.player reset];
    
    for (OCBuilding *building in appDelegate.buildingList) {
        if (building.type != OCDragonsDen && building.type != OCMainBuilding) {
            building.level = 1;
            [building applyEffect:appDelegate.player];
        }
    }
}

- (void)activateBoostOfType:(enum boostType) boostType {
    
    switch (boostType) {
        case ad: {
            
            if(!appDelegate.player.adBonusIsActive) {
                appDelegate.player.adBonusIsActive = YES;
                appDelegate.player.adBonusEndDate = [NSDate dateWithTimeIntervalSinceNow:10800];
            }
            
            else
                appDelegate.player.adBonusEndDate = [NSDate dateWithTimeInterval:10800 sinceDate:appDelegate.player.adBonusEndDate];
            
            NSLog(@"Remaining ad boost duration:%f", [appDelegate.player.adBonusEndDate timeIntervalSinceNow]);
            
            break;
        }
    
        case gold: {
           
            appDelegate.player.goldBoostIsActive = YES;
            appDelegate.player.goldBoostEndDate = [NSDate dateWithTimeIntervalSinceNow:10800];
            
            NSLog(@"Remaining gold boost duration:%f", [appDelegate.player.goldBoostEndDate timeIntervalSinceNow]);
            
            break;
        }
            
        case experience: {
            
            appDelegate.player.expBoostIsActive = YES;
            appDelegate.player.expBoostEndDate = [NSDate dateWithTimeIntervalSinceNow:10800];
            
            NSLog(@"Remaining exp boost duration:%f", [appDelegate.player.expBoostEndDate timeIntervalSinceNow]);
            
            break;
        }
            
        case luck: {
            
            appDelegate.player.luckBoostIsActive = YES;
            appDelegate.player.luckBoostEndDate = [NSDate dateWithTimeIntervalSinceNow:10800];
            
            NSLog(@"Remaining luck boost duration:%f", [appDelegate.player.luckBoostEndDate timeIntervalSinceNow]);
            
            break;
        }
            
        default:
            break;
    }
}

@end
