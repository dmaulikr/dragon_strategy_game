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
    // Do any additional setup after loading the view.
    
    
    
    self.buildingImage.image = [UIImage imageNamed:self.building.imageName];
    self.buildingInformationLabel.text = [self.building getGeneralInformation];
    self.currentLevelEffectsLabel.text = [self.building getCurrentLevelInformation];
    self.nextLevelEffectsLabel.text = [self.building getNextLevelInformation];
    
    NSTextAttachment *icon = [[NSTextAttachment alloc] init];
    icon.image = [UIImage imageNamed:@"goldIcon.png"];
    NSAttributedString *iconString = [NSAttributedString attributedStringWithAttachment:icon];
    [self.upgradeButton setTitle:[NSString stringWithFormat:@"%d %@", [self.building upgradeCost], iconString] forState:UIControlStateNormal];
    
                                          
                                        
                                          
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
