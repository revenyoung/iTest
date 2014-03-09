//
//  CollectionViewCellFunc.h
//  iTest
//
//  Created by revenyoung on 14-3-9.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Func.h"

@interface CollectionViewCellFunc : UICollectionViewCell

@property(retain, nonatomic) Func* row;
@property(retain,nonatomic) IBOutlet UILabel* label_Name;

-(void) cellDidLoad;

@end
