//
//  Player.m
//  iTest
//
//  Created by revenyoung on 14-2-23.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize Name;
@synthesize Gender;
@synthesize Age;
@synthesize Photo;
@synthesize UpdateTime;

@synthesize changed;

- (id)init
{
    self = [super init];
    if (self) {
        changed=NO;
    }
    return self;
}
@end
