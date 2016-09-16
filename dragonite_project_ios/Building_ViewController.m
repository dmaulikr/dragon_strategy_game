//
//  Building_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 23.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "Building_ViewController.h"

@interface Building_ViewController ()

@end

@implementation Building_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.buildingImage.image = [UIImage imageNamed:self.building.imageName];
    self.buildingInformationLabel.text = [self.building getGeneralInformation];
    self.currentLevelEffectsLabel.text = [self.building getCurrentLevelInformation];
    self.nextLevelEffectsLabel.text = [self.building getNextLevelInformation];
    
    //hide the scrollview
    self.dragonScrollView.backgroundColor = [UIColor colorWithRed:0.30 green:0.28 blue:0.28 alpha:1.0];
    self.dragonScrollView.userInteractionEnabled = YES;
    self.dragonScrollView.hidden = YES;
    
    //upgrade button text
    NSTextAttachment *icon = [[NSTextAttachment alloc] init];
    icon.image = [UIImage imageNamed:@"goldIcon.png"];
    NSAttributedString *iconString = [NSAttributedString attributedStringWithAttachment:icon];
    [self.upgradeButton setTitle:[NSString stringWithFormat:@"%d %@", [self.building upgradeCost], iconString] forState:UIControlStateNormal];
    
    
    self.buildingImage.image = [UIImage imageNamed:self.building.imageName];
    self.levelLabel.text = [NSString stringWithFormat:@"Level %d", self.building.level];
    self.buildingNameLabel.text = self.building.name;
    self.buildingInformationLabel.text = [self.building getGeneralInformation];
    self.currentLevelEffectsLabel.text = [self.building getCurrentLevelInformation];
    self.nextLevelEffectsLabel.text = [self.building getNextLevelInformation];
    
    //Setup gesture recognizers
    UITapGestureRecognizer *singeTapOnBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (closeView)];
    [self.backgroundFilterView addGestureRecognizer:singeTapOnBackground];
    
    
    if (self.building.type == OCSpring) {
        
        self.selectedDragonIndex = -1;
        self.dragonButtonColorForNormalState = [UIColor colorWithRed:0.20 green:0.19 blue:0.19 alpha:1.0];
        self.dragonButtonColorForSelectedState = [UIColor colorWithRed:0.70 green:0.08 blue:0.08 alpha:1.0];
        
        //create the arrays
        self.availableDragonList = [[NSMutableArray alloc] init];
        self.availableDragonButtonList = [[NSMutableArray alloc] init];
        self.selectedDragonButtonList = [[NSMutableArray alloc] init];
        
        //Set up NSNotificationCenter
        [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(selectDragon:)
                name:@"SelectedDragonForBuildingSpring"
                    object:nil];
    }
                                          
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
    [self setScrollView];
    //NSLog(@"hey");
}

- (void)setScrollView {
    
    if (self.building.type == OCSpring) {
        self.dragonScrollView.hidden = NO;
        
        //clear contents of the scrollview
        [self.dragonScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.availableDragonList removeAllObjects];
        [self.availableDragonButtonList removeAllObjects];
        
        self.sortedDragonList = [appDelegate.player.dragonList sortedArrayUsingSelector:@selector(compareAccordingToLevelAndFavorite:)];
        
        self.selectedDragonIndex = -1;
        int buttonsAdded = 0;
        
        int buttonWidth = self.dragonScrollView.frame.size.height/9*16;
        int imageBorder = 1;
        
        for (OCDragon *dragon in self.sortedDragonList) {
            if (!dragon.onQuest && !dragon.isResting) {
                [self.availableDragonList addObject:dragon];
            }
        }
        
        for (OCDragon *dragon in self.availableDragonList) {
            DragonViewForSelection *button = [[DragonViewForSelection alloc] initWithFrame:CGRectMake(buttonsAdded*buttonWidth, 0, buttonWidth, self.dragonScrollView.frame.size.height) inside:self.dragonScrollView forDragon:dragon withNormalStateColor:self.dragonButtonColorForNormalState withSelectedStateColor:self.dragonButtonColorForSelectedState withType:AvailableForBuildingSpringEntry withIndex:buttonsAdded];
            
            [self.availableDragonButtonList addObject:button];
            
            buttonsAdded += 1;
        }
        
        self.dragonScrollView.contentSize = CGSizeMake(buttonWidth*buttonsAdded, self.dragonScrollView.frame.size.height);
    }
    
    /*UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [testButton addTarget:self
               action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    testButton.frame = CGRectMake(0, 0, 50, 50); //change size vals
    testButton.backgroundColor = [UIColor cyanColor];
    [self.dragonScrollView addSubview:testButton];*/
}

- (void)selectDragon:(NSNotification *) notification {
    
    if (self.selectedDragonIndex != -1) {
        DragonViewForSelection *previouslySelectedButton = [self.availableDragonButtonList objectAtIndex:self.selectedDragonIndex];
        [previouslySelectedButton deselect];
    }
    
    self.selectedDragonIndex = [notification.object intValue];
    
    DragonViewForSelection *selectedButton = [self.availableDragonButtonList objectAtIndex:self.selectedDragonIndex];
    
    OCDragon *selectedDragon = selectedButton.dragon;
    
    //self.startQuestButton.enabled = YES;
    /*[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.startQuestButton.alpha = 1.0;
     }
                     completion:nil];*/
    
    NSLog(@"%@ says sup", selectedDragon.name);
}

- (IBAction)closeView {
    //UIView *blackView = [self.parentViewController.view.subviews objectAtIndex:[self.parentViewController.view.subviews count]-2];
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^ {
        self.view.alpha = 0;
        //blackView.alpha = 0;
    }
                     completion:^(BOOL finished) {
                         if(finished) {
                             [self dismissViewControllerAnimated:YES completion:NULL];
                         }
                     }
     ];
}


@end
