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
    
    self.mapScrollView.contentSize=CGSizeMake(self.mapImageView.frame.size.width, self.mapImageView.frame.size.height); //qswdersdtytgefdw
    self.mapScrollView.minimumZoomScale=1.0;
    self.mapScrollView.maximumZoomScale=8.0;
    
    self.mapScrollView.bouncesZoom = NO;
    self.mapScrollView.bounces = NO;
    
    self.mapScrollView.delegate=self;
    
    self.mapScrollView.delaysContentTouches = NO;
    self.mapScrollView.canCancelContentTouches = NO;
    
    self.mapScrollView.userInteractionEnabled = YES;
    
    
    
    buttons = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [appDelegate.regionButtonCoordinates count]/2; ++i) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        button.tag = i;
        button.frame = CGRectMake([[appDelegate.regionButtonCoordinates objectAtIndex:i*2] intValue], [[appDelegate.regionButtonCoordinates objectAtIndex:i*2+1] intValue], 20, 20);
        [button addTarget:self
                   action:@selector(sayHi:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        [buttons addObject:button];
    }
    
    upperBound = self.upperBoundView.frame.origin.y+self.upperBoundView.frame.size.height;
    lowerBound = self.lowerBoundView.frame.origin.y;
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


////////////////////////////////////////////////////////////////////////////////////////
//#pragma mark - Positions

- (void)updatePositionForViews {
    CGFloat scale = self.mapScrollView.zoomScale;
    CGPoint contentOffset = self.mapScrollView.contentOffset;
    for (UIButton *button in buttons) {
        CGPoint basePosition = [self basePositionForView:button];
        [self updatePositionForView:button scale:scale basePosition:basePosition offset:contentOffset];
    }
}

- (CGPoint)basePositionForView:(UIButton *)button
{
    
    return CGPointMake([[appDelegate.regionButtonCoordinates objectAtIndex:button.tag*2] intValue], [[appDelegate.regionButtonCoordinates objectAtIndex:button.tag*2+1] intValue]);
}


- (void)updatePositionForView:(UIButton *)button scale:(CGFloat)scale basePosition:(CGPoint)basePosition offset:(CGPoint)offset;
{
    CGPoint position;
    position.x = (basePosition.x * scale) - offset.x;
    position.y = (basePosition.y * scale) - offset.y;
    
    CGRect frame = button.frame;
    frame.origin = position;
    button.frame = frame;
    
    if (button.frame.origin.y <= upperBound || button.frame.origin.y+button.frame.size.height >= lowerBound) {
        button.enabled = NO;
        button.hidden = YES;
    }
    else {
        button.enabled = YES;
        button.hidden = NO;
    }
    
    NSLog(@"tag:%d, coordinates:%f,%f", button.tag, button.frame.origin.x, button.frame.origin.y);
}

//////////////////////////////////////////////////////////////////////////////////////
//#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self updatePositionForViews];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updatePositionForViews];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
{
    return _mapImageView;
}


-(IBAction) sayHi:(UIButton *) sender {
    NSLog(@"hi");
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
   
    Region_ViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Region_ViewController"];
    vc.regionIndex = sender.tag;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
