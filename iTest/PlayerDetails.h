//
//  PlayerDetails.h
//  iTest
//
//  Created by revenyoung on 14-2-26.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface PlayerDetails : UIViewController<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(retain, nonatomic) Player* row;
@property(retain,nonatomic) IBOutlet UITextField* textField_Name;
@property(retain,nonatomic) IBOutlet UISwitch* switch_Gender;
@property(retain,nonatomic) IBOutlet UITextField* textField_Age;
@property(retain,nonatomic) IBOutlet UIImageView* imageView_Photo;
@property(retain, nonatomic) IBOutlet UILabel* label_UpdateTime;

@end
