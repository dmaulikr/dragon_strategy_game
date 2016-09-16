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

- (IBAction)showBuildingView:(UIButton *)sender {
    
    //Find the view controller on the top
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    Building_ViewController *buildingViewController = [storyboard instantiateViewControllerWithIdentifier:@"Building_ViewController"];
    
    /*UIView *blackView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, topController.view.frame.size.width, topController.view.frame.size.height)];
    [blackView setBackgroundColor:[UIColor blackColor]];
    blackView.alpha = 0;
    [topController.view addSubview:blackView];*/
    
    buildingViewController.building = [appDelegate.buildingList objectAtIndex:sender.tag];
    buildingViewController.indexInBuildingArray = sender.tag;
    buildingViewController.view.backgroundColor = [UIColor clearColor];
    //[topController addChildViewController:buildingViewController];
    //viewController.view.frame = self.view.frame;
    //buildingViewController.view.frame = CGRectMake(0, 0, topController.view.frame.size.width, topController.view.frame.size.height);
    //[topController.view addSubview:buildingViewController.view];
    //buildingViewController.view.alpha = 0;
    //[buildingViewController didMoveToParentViewController:topController];
    
    buildingViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:buildingViewController animated:YES completion:nil];

    
    /*[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         //blackView.alpha = 0.5;
         buildingViewController.view.alpha = 1;
     }
                     completion:nil];*/
    
}
@end
