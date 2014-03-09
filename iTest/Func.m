//
//  Func.m
//  iTest
//
//  Created by revenyoung on 14-3-8.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import "Func.h"

@implementation Func

@synthesize CD;
@synthesize Name;
@synthesize Icon;
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
