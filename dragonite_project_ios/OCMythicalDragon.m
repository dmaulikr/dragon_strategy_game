//
//  OCMythicalDragon.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 21.06.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import "OCMythicalDragon.h"

@implementation OCMythicalDragon

- (id)initWithName:(NSString *)name_in withImage:(NSString *)image_name_in {
    self = [super init];
    if (self)
    {
        self.name = name_in;
        self.imageName = image_name_in;
        self.discovered = NO;
    }
    return self;
}

@end
