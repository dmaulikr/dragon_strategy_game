//
//  DragonName_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "DragonName_ViewController.h"

@implementation UITextField (DisableCopyPaste)

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [UIMenuController sharedMenuController].menuVisible = NO;
    return NO;
}

@end


@interface DragonName_ViewController ()

@end

@implementation DragonName_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.opaque = YES;
    OCDragon *dragon = [appDelegate.player.dragonList objectAtIndex:self.dragonIndex];
    self.nameTextField.text = dragon.name;
    
    self.containerView.alpha = 1;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.containerView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.84 green:0.13 blue:0.13 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:0.23 green:0.22 blue:0.20 alpha:1.0] CGColor], nil];
    [self.containerView.layer insertSublayer:gradient atIndex:0];
    self.containerView.backgroundColor = [UIColor orangeColor];
    self.nameTextField.alpha = 1;
    
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(closeView)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    self.nameTextField.delegate = self;
    //self.nameTextField.men
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

- (void)closeView {
    
    UIView *blackView = [self.parentViewController.view.subviews objectAtIndex:[self.parentViewController.view.subviews count]-2];
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^ {
        self.view.alpha = 0;
        blackView.alpha = 0;
    }
                     completion:^(BOOL finished) {
                         if(finished) {
                             [self willMoveToParentViewController:nil];
                             [self.view removeFromSuperview];
                             [self removeFromParentViewController];
                             [blackView removeFromSuperview];
                         }
                     }
     ];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField selectAll:self];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; // Dismiss the keyboard.
    [self saveNameAndAdjustLabelAccordingToText:textField];
    [self closeView];
    return YES;
}

- (void)saveNameAndAdjustLabelAccordingToText:(UITextField *)textField {
    if (textField.text.length > 0) {
        OCDragon *dragon = [appDelegate.player.dragonList objectAtIndex:self.dragonIndex];
        dragon.name = textField.text;
        self.dragonNameLabel.text = dragon.name;
    }
}

- (IBAction)closeButton:(id)sender {
    [self saveNameAndAdjustLabelAccordingToText:self.nameTextField];
    [self closeView];
}
@end
