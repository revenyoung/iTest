//
//  CollectionViewCellFunc.m
//  iTest
//
//  Created by revenyoung on 14-3-9.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import "CollectionViewCellFunc.h"

@implementation CollectionViewCellFunc

@synthesize row;
@synthesize label_Name;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)cellDidLoad
{
    label_Name.text=row.CD;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
