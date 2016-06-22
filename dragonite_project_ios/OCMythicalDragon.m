//
//  OCMythicalDragon.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCMythicalDragon.h"

@interface OCMythicalDragon ()
    
@end

@implementation OCMythicalDragon

- (id)initWithName:(NSString *)name_in withTitle:(NSString *)title_in withImage:(NSString *)image_name_in {
    self = [super init];
    if (self)
    {
        self.name = name_in;
        self.title = title_in;
        self.imageName = image_name_in;
        self.discovered = NO;
    }
    return self;
}

- (void)hasBeenDiscovered {
    self.discovered = YES;
    
    //Find the view controller on the top
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    //container view
    UIView *dragonPopUp = [[UIView alloc] init];
    //dragonPopUp.frame = CGRectMake(0, 0, topController.view.frame.size.width, topController.view.frame.size.height);
    dragonPopUp.frame = CGRectMake(0, topController.view.frame.size.height*4/5, topController.view.frame.size.width, topController.view.frame.size.height*1/5);
    dragonPopUp.backgroundColor = [UIColor cyanColor];
    
    //label
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,  dragonPopUp.frame.size.height/4, dragonPopUp.frame.size.width*4/5, dragonPopUp.frame.size.height/2);
    
    NSString *tempString = [NSString stringWithFormat:@"%@ %@",self.name, self.title];
    //[tempString stringByAppendingString:self.title];
    label.text = [NSString stringWithFormat:@"You have discovered %@", tempString];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: label.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(20, text.length-20)];
    [label setAttributedText: text];
    label.textAlignment = NSTextAlignmentCenter;
    
    [dragonPopUp addSubview:label];
    
    //image
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(dragonPopUp.frame.size.width*4/5, dragonPopUp.frame.size.height/10, dragonPopUp.frame.size.width*1/5, dragonPopUp.frame.size.height*8/10)];
    //double size = view.frame.size.height;
    imageView.image=[UIImage imageNamed:self.imageName];
    imageView.backgroundColor = [UIColor redColor];
    [dragonPopUp addSubview:imageView];
    
    
    [topController.view addSubview:dragonPopUp];
    
    [self performSelector:@selector(closeView:) withObject:dragonPopUp afterDelay:3.0];
    
    /*dispatch_async(dispatch_get_main_queue(), ^{
        if ([NSThread isMainThread]) NSLog(@"İDK HOW");
        [self closeView:dragonPopUp];
    }); */
    
    
    
    /*UILabel *dragonLabel = [[UILabel alloc] init];
    self.achievementLabel.frame = CGRectMake(0,  topController.view.frame.size.height*4/5, topController.view.frame.size.width, topController.view.frame.size.height*1/5);
    self.achievementLabel.backgroundColor = [UIColor yellowColor];
    self.achievementLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    self.achievementLabel.layer.borderWidth = 2.0f;
    
    self.achievementLabel.text = [NSString stringWithFormat:@"You have unlocked %@", achievementUnlocked.title];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.achievementLabel.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(18, text.length-18)];
    [self.achievementLabel setAttributedText: text];
    self.achievementLabel.textAlignment = NSTextAlignmentCenter;
    
    [topController.view addSubview:self.achievementLabel];
    NSTimer *achievementViewTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(closeAchievementNotification) userInfo:self.achievementLabel repeats:NO];*/
}


- (void)closeView:(UIView *)view {
    [view removeFromSuperview];
}


@end
