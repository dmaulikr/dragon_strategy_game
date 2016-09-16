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
    
    UIImage *mapImage = [UIImage imageNamed:@"main_map.png"];
    
    self.mapScrollView.backgroundColor = [UIColor redColor];
    self.mapImageView.backgroundColor = [UIColor blueColor];
    
    
    self.mapScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.mapScrollView.contentSize = self.mapImageView.frame.size;
    
    self.mapScrollView.minimumZoomScale=0.3;
    self.mapScrollView.maximumZoomScale=0.7;
    
    self.mapScrollView.bouncesZoom = NO;
    self.mapScrollView.bounces = NO;
    
    self.mapScrollView.delegate=self;
    
    self.mapScrollView.delaysContentTouches = NO;
    self.mapScrollView.canCancelContentTouches = NO;
    
    self.mapScrollView.userInteractionEnabled = YES;
    
    //hide the indicators
    [self.mapScrollView setShowsHorizontalScrollIndicator:NO];
    [self.mapScrollView setShowsVerticalScrollIndicator:NO];
    
    
    buttons = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [appDelegate.regionButtonCoordinates count]/2; ++i) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.frame = CGRectMake([[appDelegate.regionButtonCoordinates objectAtIndex:i*2] intValue], [[appDelegate.regionButtonCoordinates objectAtIndex:i*2+1] intValue], 35, 35);
        [button addTarget:self
                   action:@selector(loadRegion:) forControlEvents:UIControlEventTouchUpInside];
        OCRegion *region = [appDelegate.regionList objectAtIndex:i];
        [[button imageView] setContentMode: UIViewContentModeScaleAspectFit];
        if ([region isExplored])
            [button setImage:[UIImage imageNamed:@"exploredRegionButtonUp"] forState:UIControlStateNormal];
        else [button setImage:[UIImage imageNamed:@"unexploredRegionButtonUp"] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
        
        [buttons addObject:button];
    }
    
    
    //center the map and zoom out (maybe)
    [self.mapScrollView setZoomScale:0.5 animated:YES];
    [self.mapScrollView setContentOffset:CGPointMake(self.mapImageView.center.x - 400, self.mapImageView.center.y - 170)  animated:YES];
    
    //NSNotificationCenter stuff
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeButtonImage:)
                                                 name:@"ExploredRegion"
                                               object:nil];
    
    
    //Set map filter for explored/unexplored
    /*MapFilter *filter = [[MapFilter alloc] initWithFrame:CGRectMake(0, 0, self.mapScrollView.contentSize.width, self.mapScrollView.contentSize.height) ];
    filter.backgroundColor = [UIColor clearColor];
    filter.alpha = 0.7;
    filter.userInteractionEnabled = NO;
    [self.mapImageView addSubview:filter]; */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)viewWillAppear:(BOOL)animated {
    self.dragonLabel.text = [NSString stringWithFormat:@"%d/%d", [appDelegate.player numberOfDragonsAvailable], (int)[appDelegate.player.dragonList count] ];
}*/

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
    
    /*if (button.frame.origin.y <= upperBound ||
        button.frame.origin.y+button.frame.size.height >= lowerBound) {
        button.enabled = NO;
        button.hidden = YES;
    }
    else {
        button.enabled = YES;
        button.hidden = NO;
    }*/
    
    //NSLog(@"tag:%d, coordinates:%f,%f", (int)button.tag, button.frame.origin.x, button.frame.origin.y);
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


-(IBAction) loadRegion:(UIButton *) sender {
    NSLog(@"hi");
    
    //stop the timer that's in the main container
    [self.timerInMainContainer invalidate];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    Region_ViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Region_ViewController"];
    vc.regionIndex = (int)sender.tag;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)changeButtonImage:(NSNotification *) notification {
    UIButton *button = [buttons objectAtIndex:[[notification object] intValue]];
    [button setImage:[UIImage imageNamed:@"exploredRegionButtonUp"] forState:UIControlStateNormal];
}

@end
