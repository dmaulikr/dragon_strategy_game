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
@property NSString *imageName; //might change this to some kind of a coordinate info
@property NSMutableArray *questList; //includes quest objects inside
@property NSMutableArray *buttonList;
@property int distanceFromBase; //check tomorrow for double
@property int regionNumber; //might need it to index
@property BOOL explored;

//-(void) init; Figure out what you need later
-(void) generateQuestButtons:(NSMutableArray *) coordinates;
-(void) setImageView:(UIImageView *) image;


@end
