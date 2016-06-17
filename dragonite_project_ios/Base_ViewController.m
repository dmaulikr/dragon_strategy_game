//
//  Base_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "Base_ViewController.h"

@interface Base_ViewController ()

@end

@implementation Base_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.gemLabel.text = [NSString stringWithFormat:@"%d", appDelegate.player.gem];
    self.goldLabel.text = [NSString stringWithFormat:@"%d", appDelegate.player.gold];
    self.dragonLabel.text = [NSString stringWithFormat:@"%d/%d", [appDelegate.player numberOfDragonsAvailable], (int)[appDelegate.player.dragonList count] ];
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
