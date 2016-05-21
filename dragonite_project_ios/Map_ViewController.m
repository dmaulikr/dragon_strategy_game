//
//  Map_ViewController.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "Map_ViewController.h"

@interface Map_ViewController ()

@end

@implementation Map_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImage* image = self.ImageView.image;
    self.ImageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    self.ScrollView.contentSize = image.size;
    
    self.ScrollView.minimumZoomScale=0.9;
    self.ScrollView.maximumZoomScale=2.0;
    self.ScrollView.delegate=self;
    
    _ScrollView.delaysContentTouches = NO;
    _ScrollView.canCancelContentTouches = NO;
    
    self.ScrollView.userInteractionEnabled = YES;
    
    //NSLog(@"hey");
    
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

/*- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    //[self manageImageOnScrollView];//here i managed the image's coordinates and zoom
    [self manageButtonCoordinatesWithRespectToImageWithScale:scale];
    
    NSLog(@"hey");
}

-(void)manageButtonCoordinatesWithRespectToImageWithScale:(float)scaleFactor
{
    
    //initialButtonFrame is frame of button
    self.Button.frame = CGRectMake((self.Button.frame.origin.x * scaleFactor),
                                   (self.Button.frame.origin.y * scaleFactor),
                                   self.Button.frame.size.width,
                                   self.Button.frame.size.height);
    
    [self.ScrollView addSubview:self.Button];// I removed the button from superview while zooming and later added with updated button coordinates which I got here
} */

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)ScrollView
{
    return self.ImageView;
}

- (IBAction)IncreaseCountButton:(id)sender {
    ++appDelegate->count;
}
@end
