//
//  OCRegion.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 31.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCQuest.h"

@interface OCRegion : NSObject

@property NSString *name;
//@property NSString *imageName; //might change this to some kind of a coordinate info
@property CGPoint imageOrigin;
@property CGSize imageSize;
@property NSMutableArray *questList; //includes quest objects inside
@property NSMutableArray *questButtonCoordinates;
//@property int distanceFromBase; //check tomorrow for double
@property int regionNumber; //might need it to index
//@property BOOL explored;

//Figure out what you need later for the init
- (id)initWithRegionNo:(int)regionIndex;
//-(void) generateQuestButtons:(NSMutableArray *) coordinates;
//-(void) setImageView:(UIImageView *) imageView;
//-(void) placeButtonsOn:(UIView *) view;


- (BOOL)isExplored;
- (void)setImageInfoX:(float)x_in y:(float)y_in width:(float)width_in height:(float)height_in;

//- (void)



@end
