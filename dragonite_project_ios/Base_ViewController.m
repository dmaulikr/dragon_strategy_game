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
    
    /*button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button]; */
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


- (IBAction)IncreaseCountButton:(id)sender {
    ++appDelegate->count;
}
@end
