//
//  TableViewCellPlayer.h
//  iTest
//
//  Created by revenyoung on 14-2-23.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface TableViewCellPlayer : UITableViewCell

@property(retain, nonatomic) Player* row;
@property(retain,nonatomic) IBOutlet UILabel* label_Name;
@property(retain,nonatomic) IBOutlet UILabel* label_Gender;
@property(retain,nonatomic) IBOutlet UILabel* label_Age;
@property(retain,nonatomic) IBOutlet UIImageView* imageView_Photo;

-(void) cellDidLoad;

@end
