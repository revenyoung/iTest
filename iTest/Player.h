//
//  Player.h
//  iTest
//
//  Created by revenyoung on 14-2-23.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property(retain, nonatomic) NSString* Name;
@property(retain,nonatomic) NSString* Gender;
@property(readwrite, nonatomic) NSInteger Age;
@property(retain, nonatomic) NSData* Photo;
@property(retain, nonatomic) NSDate* UpdateTime;

@property(readwrite, nonatomic) Boolean changed;

@end
