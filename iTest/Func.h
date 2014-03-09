//
//  Func.h
//  iTest
//
//  Created by revenyoung on 14-3-8.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Func : NSObject

@property(retain, nonatomic) NSString* CD;
@property(retain,nonatomic) NSString* Name;
@property(retain, nonatomic) NSData* Icon;
@property(retain, nonatomic) NSDate* UpdateTime;

@property(readwrite, nonatomic) Boolean changed;

@end
