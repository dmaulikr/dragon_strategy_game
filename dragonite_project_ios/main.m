//
//  main.m
//  dragonite_project_ios
//
//  Created by Utku Gürkan on 20.05.2016.
//  Copyright © 2016 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "OCdragon.h"
#import "OCcharacter.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        OCDragon *Dranxia = [[OCDragon alloc] initRandomDragonWithName:@"Dranxia" withType:OCfire withGender:OCDragonfemale];
        
        OCCharacter *Bob = [[OCCharacter alloc] initCharacterWithName:@"Bob" withGender:OCCharactermale withLevel:1];
        
        NSLog(@"hey");
        //[new_dragon levelUp];
        
        Dranxia = nil;
        Bob = nil;
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
