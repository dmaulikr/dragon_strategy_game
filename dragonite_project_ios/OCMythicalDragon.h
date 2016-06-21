//
//  OCMythicalDragon.h
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMythicalDragon : NSObject

@property NSString *name;
@property NSString *imageName;
@property BOOL discovered;

- (id)initWithName:(NSString *)name_in withImage:(NSString *)image_name_in;

@end
