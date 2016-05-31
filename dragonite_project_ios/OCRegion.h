//
//  OCRegion.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 31.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OCRegion : NSObject

@property NSString *name;
@property NSString *imageName;
@property NSMutableArray *questList;
@property int distanceFromBase; //check tomorrow for double
@property BOOL explored;

-(void) setImageView:(UIImageView *) image;


@end
