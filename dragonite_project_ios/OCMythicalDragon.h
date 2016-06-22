//
//  OCMythicalDragon.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OCMythicalDragon : NSObject

@property NSString *name; //Akhza
@property NSString *title; //the fire lord
@property NSString *imageName;
@property BOOL discovered;

- (id)initWithName:(NSString *)name_in withTitle:(NSString *)title_in withImage:(NSString *)image_name_in;
- (void)hasBeenDiscovered; //also creates the notification view

@end
