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
    
    UIImage* image = self.mapImageView.image;
    self.mapImageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    
    //WTF?
    self.mapScrollView.contentSize = image.size;
    self.mapScrollView.contentSize=CGSizeMake(self.mapImageView.frame.size.width, self.mapImageView.frame.size.height); //qswdersdtytgefdw
    self.mapScrollView.minimumZoomScale=1.0;
    self.mapScrollView.maximumZoomScale=2.0;
    
    self.mapScrollView.delegate=self;
    
    _mapScrollView.delaysContentTouches = NO;
    _mapScrollView.canCancelContentTouches = NO;
    
    self.mapScrollView.userInteractionEnabled = YES;
    
    //NSLog(@"hey");
    
    
    
    //self.regionView.hidden = YES;
    //self.regionView = YES;
    
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

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"hey");
    //[self manageImageOnScrollView];//here i managed the image's coordinates and zoom
    [self manageButtonCoordinatesWithRespectToImageWithScale:scale];
   
    NSLog(@"hey");
    
}

-(void)manageButtonCoordinatesWithRespectToImageWithScale:(float)scaleFactor {
    
    //initialButtonFrame is frame of button
    float x = self.Button.frame.origin.x;
    float xx = x*scaleFactor;
    self.Button.frame = CGRectMake((self.Button.frame.origin.x * scaleFactor),
                                   (self.Button.frame.origin.y * scaleFactor),
                                   self.Button.frame.size.width,
                                   self.Button.frame.size.height);
    [self.Button setTitle:[[NSNumber numberWithFloat:xx] stringValue] forState:UIControlStateNormal];
    
    //[self.ScrollView addSubview:self.Button];// I removed the button from superview while zooming and later added with updated button coordinates which I got here
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)ScrollView
{
    return self.mapImageView;
}

/*- (void):(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y) animated:NO];
} */

@end
