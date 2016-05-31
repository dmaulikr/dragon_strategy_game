//
//  OCRegion.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 31.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OCQuest.h"

@interface OCRegion : NSObject

@property NSString *name;
@property NSString *imageName; //might change this to some kind of a coordinate info
@property NSMutableArray *questList; //includes quest objects inside
@property NSMutableArray *buttonList;
@property int distanceFromBase; //check tomorrow for double
@property int regionNumber; //might need it to index
@property BOOL explored;

//Figure out what you need later for the init
-(id) initWithImageName:(NSString *) region_image_in withDistanceFromBase:(int) distance_in withRegionNo:(int) region_idx;
-(void) generateQuestButtons:(NSMutableArray *) coordinates;
-(void) setImageView:(UIImageView *) imageView;



@end
