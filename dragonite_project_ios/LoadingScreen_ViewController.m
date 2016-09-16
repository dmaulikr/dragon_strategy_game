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
    
    //reload saved dragons to the array
    self.managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Dragon"];
    self.savedDragons = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    //reload saved player to the array
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] initWithEntityName:@"Player"];
    self.savedPlayers = [[self.managedObjectContext executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
    
    //reload quests
    NSFetchRequest *fetchRequest3 = [[NSFetchRequest alloc] initWithEntityName:@"Quest"];
    self.savedQuests = [[self.managedObjectContext executeFetchRequest:fetchRequest3 error:nil] mutableCopy];
    
    //reload buildings
    NSFetchRequest *fetchRequest4 = [[NSFetchRequest alloc] initWithEntityName:@"Building"];
    self.savedBuildings = [[self.managedObjectContext executeFetchRequest:fetchRequest4 error:nil] mutableCopy];

    
    //[self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    [self.activityIndicator startAnimating];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Set region button coordinates for map view
    appDelegate.regionButtonCoordinates = [[NSArray alloc] initWithObjects:@1000, @650,/* @250, @250, @450, @250,*/ nil];
    
    
    //Set region infos
    appDelegate.regionList = [[NSMutableArray alloc] init];
    
    OCRegion *region = [[OCRegion alloc] initWithRegionNo:0];
    OCQuest *questPtr0 = [[OCQuest alloc] initWithDifficultyLevel:1 withRequiredDragonType:OCwind atRegion:0 withIndex:0];
    [region.questList addObject:questPtr0];
    OCQuest *questPtr1 = [[OCQuest alloc] initWithDifficultyLevel:1 withRequiredDragonType:OCwind atRegion:0 withIndex:1];
    [region.questList addObject:questPtr1];
    OCQuest *questPtr2 = [[OCQuest alloc] initWithDifficultyLevel:2 withRequiredDragonType:OCwind atRegion:0 withIndex:2];
    [region.questList addObject:questPtr2];
    OCQuest *questPtr3 = [[OCQuest alloc] initWithDifficultyLevel:3 withRequiredDragonType:OCwind atRegion:0 withIndex:3];
    [region.questList addObject:questPtr3];
    OCQuest *questPtr4 = [[OCQuest alloc] initWithDifficultyLevel:4 withRequiredDragonType:OCwind atRegion:0 withIndex:4];
    [region.questList addObject:questPtr4];
    OCQuest *questPtr5 = [[OCQuest alloc] initWithDifficultyLevel:5 withRequiredDragonType:OCwind atRegion:0 withIndex:5];
    [region.questList addObject:questPtr5];
    
    //self.region.imageName = @"pokemon_dp_map.png";
    [region setImageInfoX:150 y:240 width:400 height:300];
    [region.questButtonCoordinates addObject:@20];
    [region.questButtonCoordinates addObject:@20];
    [region.questButtonCoordinates addObject:@70];
    [region.questButtonCoordinates addObject:@70];
    [region.questButtonCoordinates addObject:@120];
    [region.questButtonCoordinates addObject:@120];
    [region.questButtonCoordinates addObject:@170];
    [region.questButtonCoordinates addObject:@170];
    [region.questButtonCoordinates addObject:@220];
    [region.questButtonCoordinates addObject:@170];
    [appDelegate.regionList addObject:region];
    
    
    
    //Set buildings
    //must be the same order as the one in the building enum
    OCBuilding *mainBuilding = [[OCBuilding alloc] initWithName:@"Main Building" withImageName:@"mainBuilding.png" withType:OCMainBuilding];
    OCBuilding *dragonsDen = [[OCBuilding alloc] initWithName:@"Dragons' Den" withImageName:@"dragonsDen.png" withType:OCDragonsDen];
    OCBuilding *treasury = [[OCBuilding alloc] initWithName:@"Treasury" withImageName:@"treasury.png" withType:OCTreasury];
    OCBuilding *fountain = [[OCBuilding alloc] initWithName:@"The Fountain" withImageName:@"fountain.png" withType:OCFountain];
    OCBuilding *spring = [[OCBuilding alloc] initWithName:@"Spring" withImageName:@"spring.png" withType:OCSpring];
    
    //for testing
    /*mainBuilding.level = 5;
    dragonsDen.level = 3;
    treasury.level = 4;
    fountain.level = 2;
    spring.level = 1;*/
    
    appDelegate.buildingList = [[NSArray alloc] initWithObjects:mainBuilding, dragonsDen, treasury, fountain, spring, nil];
    
    
    //Set achievements
    appDelegate.lastAchievementCheckDate = [NSDate date];
    OCAchievement *achievement1 = [[OCAchievement alloc] initWithTitle:@"7 Heads" withExplanation:@"Roar" withTag:0 isVisible:YES];
    OCAchievement *achievement2 = [[OCAchievement alloc] initWithTitle:@"5 Heads" withExplanation:@"Roar" withTag:1 isVisible:YES];
    OCAchievement *achievement3 = [[OCAchievement alloc] initWithTitle:@"5 Heads" withExplanation:@"Roar" withTag:1 isVisible:YES];
    OCAchievement *achievement4 = [[OCAchievement alloc] initWithTitle:@"5 Heads" withExplanation:@"Roar" withTag:1 isVisible:YES];
    OCAchievement *achievement5 = [[OCAchievement alloc] initWithTitle:@"5 Heads" withExplanation:@"Roar" withTag:1 isVisible:YES];
     appDelegate.achievementList = [[NSArray alloc] initWithObjects:achievement1, achievement2, achievement3, achievement4, achievement5, nil];
    
    //Set mythical dragons
    OCMythicalDragon *myth1 = [[OCMythicalDragon alloc] initWithName:@"Slifer" withTitle:@"the sky dragon" withImage:@"slifer.jpg"];
    appDelegate.mythicalDragonList = [[NSArray alloc] initWithObjects:myth1, nil];
    
    
    //if not launched before
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        
        appDelegate.player = [[OCPlayer alloc] initPlayer];
        OCDragon *starterDragon = [[OCDragon alloc] init];

        //Create the starter dragon
        [starterDragon initNewDragonOfType:OCwind withStatsRange:4 ThatIsLegendary:NO];
        starterDragon.imageName = @"dragon_sample.jpg";
        starterDragon.level = 1;
        
        starterDragon.initialStats.strength = 1;
        starterDragon.initialStats.speed = 1;
        starterDragon.initialStats.endurance = 1;
        
        starterDragon.baseStats.strength = 1;
        starterDragon.baseStats.speed = 1;
        starterDragon.baseStats.endurance = 1;
        
        //starterDragon.availableStatPoints = 302;
        starterDragon.energy = 1;
        starterDragon.name = @"Wind";
        starterDragon.experience = 0;
        starterDragon.isGod = YES;
        [appDelegate.player addNewDragon:starterDragon];
        //starterDragon = nil;
        
        //Save the starter dragon
        [self saveDragonForTheFirstTime:starterDragon];
        
        
        //just for test
        OCDragon *dragon2 = [[OCDragon alloc] init];
        [dragon2 initNewDragonOfType:OCwind withStatsRange:4 ThatIsLegendary:NO];
        dragon2.imageName = @"dragon_sample.jpg";
        dragon2.level = 1;
        
        dragon2.initialStats.strength = 1;
        dragon2.initialStats.speed = 1;
        dragon2.initialStats.endurance = 1;
        
        dragon2.baseStats.strength = 1;
        dragon2.baseStats.speed = 1;
        dragon2.baseStats.endurance = 1;
        
        dragon2.energy = 1;
        dragon2.name = @"Fire";
        dragon2.experience = 0;
        dragon2.isGod = YES;
        [appDelegate.player addNewDragon:dragon2];
        [self saveDragonForTheFirstTime:dragon2];
        
        OCDragon *dragon3 = [[OCDragon alloc] init];
        [dragon3 initNewDragonOfType:OCwind withStatsRange:4 ThatIsLegendary:NO];
        dragon3.imageName = @"dragon_sample.jpg";
        dragon3.level = 1;
        
        dragon3.initialStats.strength = 1;
        dragon3.initialStats.speed = 1;
        dragon3.initialStats.endurance = 1;
        
        dragon3.baseStats.strength = 1;
        dragon3.baseStats.speed = 1;
        dragon3.baseStats.endurance = 1;
        
        dragon3.energy = 1;
        dragon3.name = @"Water";
        dragon3.experience = 0;
        dragon3.isGod = YES;
        [appDelegate.player addNewDragon:dragon3];
        [self saveDragonForTheFirstTime:dragon3];
        
        ///////////////////////////
        
        //set the dragon pointer to nil
        starterDragon = nil;
        
        //set player
        //change some of these later
        //Write an apply building effects part after setting the player stuff
        
        appDelegate.player.energyRegenPerMinute = 1;
        appDelegate.player.maxBuildingLevel = 1;
        appDelegate.player.maxGold = 500;
        appDelegate.player.maxDragonCount = 3;
        appDelegate.player.gold = 0;
        appDelegate.player.gem = 0;
        appDelegate.player.numberOfResets = 0;
        appDelegate.player.lastEnergyUpdateDate = [NSDate date];
        appDelegate.player.numberOfDifferentQuestsCompleted = 0;
        appDelegate.player.highestQuestDifficultyAchievedInCurrentReset = 0;
        appDelegate.player.highestQuestDifficultyAchievedInPreviousReset = 0;
        
        //set up the counter reset date
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *todaysDate;
        NSTimeInterval interval;
        [cal rangeOfUnit:NSDayCalendarUnit startDate:&todaysDate interval:&interval forDate:now];
        appDelegate.player.nextCounterResetDate = [todaysDate dateByAddingTimeInterval:interval];
        
        //set energy update time interval
        appDelegate.player.energyRegenTimeInterval = 60;
        
        [self savePlayerForTheFirstTime:appDelegate.player];
        
        
        //save the quests
        for (OCRegion *region in appDelegate.regionList) {
            for (OCQuest *quest in region.questList) {
                [self saveQuestForTheFirstTime:quest];
            }
        }
        
        //save buildings
        for (OCBuilding *building in appDelegate.buildingList) {
            [self saveBuildingForTheFirstTime:building];
        }
        
    }//if not launched before
    
    else { //if launched before
        
        appDelegate.player = [[OCPlayer alloc] initPlayer];
        NSManagedObject *playerData = [self.savedPlayers objectAtIndex:0];
        [self loadPlayer:appDelegate.player withData:playerData];
        
        for (int i = 0; i < [self.savedDragons count]; ++i) {
            
            NSManagedObject *dragonData = [self.savedDragons objectAtIndex:i]; //the one in core data
            OCDragon *newDragon = [[OCDragon alloc] initDragon];
            
            [self loadDragon:newDragon withData:dragonData];
            
            [appDelegate.player.dragonList addObject:newDragon];
        }
        
        
        //load quests
        for (int i = 0; i < [self.savedQuests count]; ++i) {
            NSManagedObject *questData = [self.savedQuests objectAtIndex:i]; //the one in core data
            int regionNo = [[questData valueForKey:@"regionNo"] intValue];
            int index = [[questData valueForKey:@"index"] intValue];
            OCRegion *region = [appDelegate.regionList objectAtIndex:regionNo];
            OCQuest *quest = [region.questList objectAtIndex:index];
            [self loadQuest:quest withData:questData];
        }
        
        //load buildings and apply their effects
        //first set the dragon energy update time interval
        appDelegate.player.energyRegenTimeInterval = 60;
        for (int i = 0; i < [appDelegate.buildingList count]; i+=1) {
            NSManagedObject *buildingData = [self.savedBuildings objectAtIndex:i];
            OCBuilding *building = [appDelegate.buildingList objectAtIndex:i];
            [self loadBuilding:building withData:buildingData];
            
            [building applyEffect:appDelegate.player];
        }
        
        
    } //if launched before
    
    //calculate dragons' effective stats
    for (OCDragon *dragon in appDelegate.player.dragonList) {
        [dragon calculateEffectiveStats];
    }
    
    
    
    //again, if launched before
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        
        //we resolve finished quests, energy updates and quest counters here
        NSMutableArray *tempDragonsOnQuest = [[NSMutableArray alloc] init];
        for (OCDragon *dragon in appDelegate.player.dragonList) {
            if (dragon.onQuest && ([dragon.questInfo.endDate compare:[NSDate date]] == NSOrderedAscending) )
                [tempDragonsOnQuest addObject:dragon];
        }
        
        NSArray *sortedDragonsOnQuest = [tempDragonsOnQuest sortedArrayUsingSelector:@selector(compareAccordingToQuestEndDate:)];
        
        for (OCDragon *dragon in sortedDragonsOnQuest) {
            
            //update dragon energies until this point
            [self completeDragonEnergyUpdatesUntil:dragon.questInfo.endDate];
            
            //quest counter
            if ([dragon.questInfo.endDate compare:appDelegate.player.nextCounterResetDate] == NSOrderedDescending) {
                
                //reset quest counters
                [appDelegate resetQuestCounters];
                
                //set the next date to reset counters
                appDelegate.player.nextCounterResetDate = [NSDate dateWithTimeInterval:86400 sinceDate:appDelegate.player.nextCounterResetDate];
            }
            
            OCRegion *region = [appDelegate.regionList objectAtIndex:dragon.questInfo.regionNo];
            OCQuest *quest = [region.questList objectAtIndex:dragon.questInfo.questNo];
            [quest finishQuest:dragon and:appDelegate.player];
            
            [self saveDragonAfterQuest:dragon];
            [self saveQuestAfterQuest:quest];
            [self savePlayerAfterQuest:appDelegate.player];
        }
        
        //Do the remaining dragon energy updates
        [self completeDragonEnergyUpdatesUntil:[NSDate date]];
        
        
        tempDragonsOnQuest = nil;
        sortedDragonsOnQuest = nil;
        
        //all the important quest counter resets are done at this point, just reset it
        //this part also runs during the first ever launch, so
        //you might want to take it out of the player first time creation part---maybe not
        //since you set the bool variable for the first launch up there
        NSDate *now = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *todaysDate;
        NSTimeInterval interval;
        [cal rangeOfUnit:NSDayCalendarUnit startDate:&todaysDate interval:&interval forDate:now];
        appDelegate.player.nextCounterResetDate = [todaysDate dateByAddingTimeInterval:interval];
        [self savePlayerAfterCounterReset:appDelegate.player];

    } //if launched before--2nd if
    
    else {
        //the game has launched
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    
    [self.activityIndicator stopAnimating];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    MainContainer_ViewController *containerScene = [storyboard instantiateViewControllerWithIdentifier:@"MainContainer_ViewController"];
    [self presentViewController:containerScene animated:YES completion:nil];
    
    containerScene.currentChildView = Map;
    
    //TEST--DELETE LATER
    //[[appDelegate.mythicalDragonList objectAtIndex:0] hasBeenDiscovered];
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

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)saveDragonForTheFirstTime:(OCDragon *) dragonToBeSaved {
    //NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *dragonData = [NSEntityDescription insertNewObjectForEntityForName:@"Dragon" inManagedObjectContext:self.managedObjectContext];
    
    [dragonData setValue:dragonToBeSaved.imageName forKey:@"imageName"];
    
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.availableStatPoints] forKey:@"availableStatPoints"];
    
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.baseStats.endurance] forKey:@"baseEndurance"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.baseStats.speed] forKey:@"baseSpeed"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.baseStats.strength] forKey:@"baseStrength"];
    
    /*[dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.effectiveStats.endurance] forKey:@"effectiveEndurance"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.effectiveStats.speed] forKey:@"effectiveSpeed"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.effectiveStats.strength] forKey:@"effectiveStrength"];*/
    
    [dragonData setValue:[[NSNumber alloc] initWithDouble:dragonToBeSaved.energy] forKey:@"energy"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.experience] forKey:@"experience"];
    
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.initialStats.endurance] forKey:@"initialEndurance"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.initialStats.speed] forKey:@"initialSpeed"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.initialStats.strength] forKey:@"initialStrength"];
    
    [dragonData setValue:[NSNumber numberWithBool:dragonToBeSaved.isFavorite] forKey:@"isFavorite"];
    [dragonData setValue:[NSNumber numberWithBool:dragonToBeSaved.isGod] forKey:@"isGod"];
    [dragonData setValue:[NSNumber numberWithBool:dragonToBeSaved.isLegendary] forKey:@"isLegendary"];
    [dragonData setValue:[NSNumber numberWithBool:dragonToBeSaved.isResting] forKey:@"isResting"];
    
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.level] forKey:@"level"];
    [dragonData setValue:dragonToBeSaved.name forKey:@"name"];
    [dragonData setValue:[NSNumber numberWithBool:dragonToBeSaved.onQuest] forKey:@"onQuest"];
    
    [dragonData setValue:dragonToBeSaved.questInfo.endDate forKey:@"questEndDate"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.questInfo.questNo] forKey:@"questNo"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.questInfo.regionNo] forKey:@"questRegionNo"];
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.questsCompleted] forKey:@"questsCompleted"];
    [dragonData setValue:dragonToBeSaved.questInfo.startDate forKey:@"questStartDate"];
    
    [dragonData setValue:[[NSNumber alloc] initWithInt:dragonToBeSaved.type] forKey:@"type"];
}

- (void)loadDragon:(OCDragon *) newDragon withData:(NSManagedObject *) dragonData {
    
    newDragon.imageName = [dragonData valueForKey:@"imageName"];
    
    newDragon.availableStatPoints = [[dragonData valueForKey:@"availableStatPoints"] intValue];
    newDragon.baseStats.endurance = [[dragonData valueForKey:@"baseEndurance"] intValue];
    newDragon.baseStats.speed = [[dragonData valueForKey:@"baseSpeed"] intValue];
    newDragon.baseStats.strength = [[dragonData valueForKey:@"baseStrength"] intValue];
    //newDragon.effectiveStats.endurance = [[dragonData valueForKey:@"effectiveEndurance"] intValue];
    //newDragon.effectiveStats.speed = [[dragonData valueForKey:@"effectiveSpeed"] intValue];
    //newDragon.effectiveStats.strength = [[dragonData valueForKey:@"effectiveStrength"] intValue];
    newDragon.energy = [[dragonData valueForKey:@"energy"] doubleValue];
    newDragon.experience = [[dragonData valueForKey:@"experience"] intValue];
    newDragon.initialStats.endurance = [[dragonData valueForKey:@"initialEndurance"] intValue];
    newDragon.initialStats.speed = [[dragonData valueForKey:@"initialSpeed"] intValue];
    newDragon.initialStats.strength = [[dragonData valueForKey:@"initialStrength"] intValue];
    
    newDragon.isFavorite = [[dragonData valueForKey:@"isFavorite"] boolValue];
    newDragon.isGod = [[dragonData valueForKey:@"isGod"] boolValue];
    newDragon.isLegendary = [[dragonData valueForKey:@"isLegendary"] boolValue];
    newDragon.isResting = [[dragonData valueForKey:@"isResting"] boolValue];
    
    newDragon.level = [[dragonData valueForKey:@"level"] intValue];
    newDragon.name = [dragonData valueForKey:@"name"];
    
    newDragon.onQuest = [[dragonData valueForKey:@"onQuest"] boolValue];
    newDragon.questInfo.endDate = [dragonData valueForKey:@"questEndDate"];
    newDragon.questInfo.questNo = [[dragonData valueForKey:@"questNo"] intValue];
    newDragon.questInfo.regionNo = [[dragonData valueForKey:@"questRegionNo"] intValue];
    newDragon.questsCompleted = [[dragonData valueForKey:@"questsCompleted"] intValue];
    newDragon.questInfo.startDate = [dragonData valueForKey:@"questStartDate"];
    
    newDragon.type = [[dragonData valueForKey:@"type"] intValue];
}

- (void)savePlayerForTheFirstTime:(OCPlayer *) playerToBeSaved {
    //NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *playerData = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.managedObjectContext];
    
    [playerData setValue:[[NSNumber alloc] initWithDouble:playerToBeSaved.energyRegenPerMinute] forKey:@"energyRegenPerMinute"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.gem] forKey:@"gem"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.gold] forKey:@"gold"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.highestQuestDifficultyAchievedInCurrentReset] forKey:@"highestQuestDifficultyAchievedInCurrentReset"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.highestQuestDifficultyAchievedInPreviousReset] forKey:@"highestQuestDifficultyAchievedInPreviousReset"];
    
    [playerData setValue:playerToBeSaved.lastEnergyUpdateDate forKey:@"lastEnergyUpdateDate"];
    
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.maxBuildingLevel] forKey:@"maxBuildingLevel"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.maxDragonCount] forKey:@"maxDragonCount"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.maxGold] forKey:@"maxGold"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.numberOfDifferentQuestsCompleted] forKey:@"numberOfDifferentQuestsCompleted"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.numberOfResets] forKey:@"numberOfResets"];
    
    [playerData setValue:playerToBeSaved.nextCounterResetDate forKey:@"nextCounterResetDate"];
    
    //[playerData setValue:playerToBeSaved.energyRegenTimeInterval forKey:@"energyRegenTimeInterval"];alrheaalwıhfalw
}

- (void)loadPlayer:(OCPlayer *) newPlayer withData:(NSManagedObject *) playerData {
    newPlayer.energyRegenPerMinute = [[playerData valueForKey:@"energyRegenPerMinute"] doubleValue];
    newPlayer.gem = [[playerData valueForKey:@"gem"] intValue];
    newPlayer.gold = [[playerData valueForKey:@"gold"] intValue];
    newPlayer.highestQuestDifficultyAchievedInCurrentReset = [[playerData valueForKey:@"highestQuestDifficultyAchievedInCurrentReset"] intValue];
    newPlayer.highestQuestDifficultyAchievedInPreviousReset = [[playerData valueForKey:@"highestQuestDifficultyAchievedInPreviousReset"] intValue];
    newPlayer.lastEnergyUpdateDate = [playerData valueForKey:@"lastEnergyUpdateDate"];
    newPlayer.maxBuildingLevel = [[playerData valueForKey:@"maxBuildingLevel"] intValue];
    newPlayer.maxDragonCount = [[playerData valueForKey:@"maxDragonCount"] intValue];
    newPlayer.maxGold = [[playerData valueForKey:@"maxGold"] intValue];
    newPlayer.numberOfDifferentQuestsCompleted = [[playerData valueForKey:@"numberOfDifferentQuestsCompleted"] intValue];
    newPlayer.numberOfResets = [[playerData valueForKey:@"numberOfResets"] intValue];
    
    newPlayer.nextCounterResetDate = [playerData valueForKey:@"nextCounterResetDate"];
}

- (void)saveQuestForTheFirstTime:(OCQuest *) questToBeSaved {
    //NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *questData = [NSEntityDescription insertNewObjectForEntityForName:@"Quest" inManagedObjectContext:self.managedObjectContext];
    
    [questData setValue:[[NSNumber alloc] initWithInt:questToBeSaved.counter] forKey:@"counter"];
    [questData setValue:questToBeSaved.lastCounterUpdate forKey:@"lastCounterUpdate"];
    [questData setValue:[[NSNumber alloc] initWithInt:questToBeSaved.numberOfDragonsCurrentlyOnThisQuest] forKey:@"numberOfDragonsCurrentlyOnThisQuest"];
    [questData setValue:[NSNumber numberWithBool:questToBeSaved.successfullyCompletedAtLeastOnce] forKey:@"successfullyCompletedAtLeastOnce"];
    
    //we need these to identify
    [questData setValue:[[NSNumber alloc] initWithInt:questToBeSaved.regionNo] forKey:@"regionNo"];
    [questData setValue:[[NSNumber alloc] initWithInt:questToBeSaved.index] forKey:@"index"];
}

- (void)loadQuest:(OCQuest *) newQuest withData:(NSManagedObject *) questData {
    newQuest.counter = [[questData valueForKey:@"counter"] intValue];
    newQuest.lastCounterUpdate = [questData valueForKey:@"lastCounterUpdate"];
    newQuest.numberOfDragonsCurrentlyOnThisQuest = [[questData valueForKey:@"numberOfDragonsCurrentlyOnThisQuest"] intValue];
    newQuest.successfullyCompletedAtLeastOnce = [[questData valueForKey:@"successfullyCompletedAtLeastOnce"] boolValue];
}

- (void)saveBuildingForTheFirstTime:(OCBuilding *) buildingToBeSaved {
    //NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *buildingData = [NSEntityDescription insertNewObjectForEntityForName:@"Building" inManagedObjectContext:self.managedObjectContext];
    
    [buildingData setValue:[[NSNumber alloc] initWithInt:buildingToBeSaved.level] forKey:@"level"];
    //[buildingData setValue:[[NSNumber alloc] initWithInt:buildingToBeSaved.type] forKey:@"type"];
}

- (void)loadBuilding:(OCBuilding *) newBuilding withData:(NSManagedObject *) buildingData {
    newBuilding.level = [[buildingData valueForKey:@"level"] intValue];
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

//this one includes the nextcounterresetdate too
- (void)savePlayerAfterQuest:(OCPlayer *) playerToBeSaved {
    
    NSManagedObject *playerData = [self.savedPlayers objectAtIndex:0];
    
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.gem] forKey:@"gem"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.gold] forKey:@"gold"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.highestQuestDifficultyAchievedInCurrentReset] forKey:@"highestQuestDifficultyAchievedInCurrentReset"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.numberOfDifferentQuestsCompleted] forKey:@"numberOfDifferentQuestsCompleted"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.totalNumberOfQuestsCompleted] forKey:@"totalNumberOfQuestsCompleted"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.numberOfDragonsFound] forKey:@"numberOfDragonsFound"];
    [playerData setValue:[[NSNumber alloc] initWithInt:playerToBeSaved.numberOfMythicalDragonsDiscovered] forKey:@"numberOfMythicalDragonsDiscovered"];
    
    [playerData setValue:playerToBeSaved.nextCounterResetDate forKey:@"nextCounterResetDate"];
    
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

- (void)savePlayerAfterCounterReset:(OCPlayer *) playerToBeSaved {
    NSManagedObject *playerData = [self.savedPlayers objectAtIndex:0];
    [playerData setValue:playerToBeSaved.nextCounterResetDate forKey:@"nextCounterResetDate"];
}

- (void)savePlayerAfterEnergyUpdate:(OCPlayer *) playerToBeSaved {
    NSManagedObject *playerData = [self.savedPlayers objectAtIndex:0];
    [playerData setValue:playerToBeSaved.lastEnergyUpdateDate forKey:@"lastEnergyUpdateDate"];
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

- (void)completeDragonEnergyUpdatesUntil:(NSDate *)finalDate {

    NSTimeInterval timePassed = [finalDate timeIntervalSinceDate:appDelegate.player.lastEnergyUpdateDate];
    if (timePassed >= appDelegate.player.energyRegenTimeInterval) {
        int numberOfEnergyUpdatesNeeded = timePassed / appDelegate.player.energyRegenTimeInterval;
        
        for (int i = 0; i < numberOfEnergyUpdatesNeeded; i += 1) {
            [appDelegate.player updateDragonEnergies];
        }
        
        //save the dragons and the player
        for (OCDragon *dragon in appDelegate.player.dragonList) {
            [self saveDragonAfterEnergyUpdate:dragon];
        }
        [self savePlayerAfterEnergyUpdate:appDelegate.player];
    }
}

@end
