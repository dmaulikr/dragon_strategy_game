//
//  SideNotificationView.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 18.07.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "SideNotificationView.h"

@implementation SideNotificationView

- (id)initWithFrame:(CGRect)frame onView:(UIView *)viewToPresentOn withText:(NSString *)text withStartingColor:(NSArray *)startingColorList withEndColor:(NSArray *)endingColorList withDuration:(NSTimeInterval)duration {
    
    self = [super init];
    if (self)
    {
        //It's gonna start from the top and fall down
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.view.alpha = 0.0;
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.label.text = text;
        self.label.font = [UIFont systemFontOfSize:15];
        [self.label setTextColor:[UIColor whiteColor]];
        
        //self.view.backgroundColor = [UIColor whiteColor];
        
        self.gradient = [CAGradientLayer layer];
        self.gradient.frame = self.view.bounds;
        self.gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:[startingColorList[0] floatValue] green:[startingColorList[1] floatValue] blue:[startingColorList[2] floatValue] alpha:[startingColorList[3] floatValue]] CGColor], (id)[[UIColor colorWithRed:[endingColorList[0] floatValue] green:[endingColorList[1] floatValue] blue:[endingColorList[2] floatValue] alpha:[endingColorList[3] floatValue]] CGColor], nil];
        
        self.gradient.startPoint = CGPointMake(0.0, 0.5);
        self.gradient.endPoint = CGPointMake(1.0, 0.5);
        [self.view.layer insertSublayer:self.gradient atIndex:0];
        
        
        [self.view addSubview:self.label];
        
        /*UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        while (topController.presentedViewController) {
            topController = topController.presentedViewController;
        }*/
        
        //add gestures to view
        UISwipeGestureRecognizer *swipeLeft=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deleteNotificationAction)];
        swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:swipeLeft];
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteNotificationAction)];
        [self.view addGestureRecognizer:singleFingerTap];
        
        
        //[topController.view addSubview:self.view];
        [viewToPresentOn addSubview:self.view];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.view.frame = frame;
                             self.view.alpha = 1.0;
                         } completion:^(BOOL finished) {
                             
                             self.view.userInteractionEnabled = YES;
                             
                             //set the timer that's gonna notify the center to delete
                             self.timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(deleteNotificationAction) userInfo:nil repeats:YES ];
                         }
         ];
    }
    return self;
}

- (void)changeToFrame:(CGRect)frame {
    
    //move down
    [UIView animateWithDuration:0.1 animations:^{
        self.view.frame = frame; // move to new location
    }];
}

- (void)disappear {
    [self.timer invalidate];
    [self.view removeFromSuperview];
    [self.label removeFromSuperview];
}

- (void)notifyForDeletion {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"DeleteNotification"
     object:self];
}


- (void)deleteNotificationAction {
    CGRect newFrame = self.view.frame;
    newFrame.origin.x -= newFrame.size.width;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.view.frame = newFrame;
                     } completion:^(BOOL finished) {
                         //delete the notification
                         [self notifyForDeletion];
                     }
     ];
    
    
}
@end
