//
//  DragonList_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 7.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "DragonList_ViewController.h"

@interface DragonList_ViewController ()

@end

@implementation DragonList_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self setDragonListScene];
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


- (void)setDragonListScene {
    
    int viewHeight = 100; //adjust this
    self.scrollView.contentSize = CGSizeMake(0, viewHeight * [appDelegate.player.dragonList count]);
    
    for (OCDragon *dragon in appDelegate.player.dragonList) {
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(10, 10, self.scrollView.frame.size.width, viewHeight);
        //view.backgroundColor = [UIColor yellowColor];
        view.layer.borderColor = [UIColor yellowColor].CGColor;
        view.layer.borderWidth = 3.0f;
        
        [view.heightAnchor constraintEqualToConstant:viewHeight].active = true;
        [view.widthAnchor constraintEqualToConstant:self.stackView.frame.size.width].active = true;
        
        //create imageview
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, view.frame.size.height*4/5)];
        //double size = view.frame.size.height;
        imageView.image=[UIImage imageNamed:@"dragon_sample.jpg"];
        [view addSubview:imageView];
        
        
        //create name label
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, 120, 20)];
        [nameLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        [nameLabel setText:dragon.name];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:nameLabel];
        
        //create type label
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 40, 120, 20)];
        [typeLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        [typeLabel setText:[dragon typeText]];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:typeLabel];
        
        //create level label
        UILabel *lvlLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 70, 120, 20)];
        [lvlLabel setBackgroundColor:[UIColor /*clearColor*/ blueColor]];
        [lvlLabel setText:[NSString stringWithFormat:@"%d", dragon.level]];
        lvlLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lvlLabel];
        
        
        //create lvl label
      /*  UILabel *lvlLabel = [[UILabel alloc]initWithFrame:CGRectMake(buttonsAdded*160+120, 0, 40, self.dragonScrollView.frame.size.height*1/5)];
        [lvlLabel setBackgroundColor:[UIColor clearColor]];
        [lvlLabel setText:[NSString stringWithFormat:@"%d", dragon.level]];
        lvlLabel.textAlignment = NSTextAlignmentCenter;
        [self.dragonScrollView addSubview:lvlLabel];
        //[LvlLabel release];
        
        //create name label
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(buttonsAdded*160, self.dragonScrollView.frame.size.height*4/5, 160, self.dragonScrollView.frame.size.height/5)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setText:dragon.name];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.dragonScrollView addSubview:nameLabel];
        //[LvlLabel release];
        
        buttonsAdded += 1; */
        
        
        
        [self.stackView addArrangedSubview:view];
    }
}

@end
