//
//  TabPickerView.h
//  iTest
//
//  Created by revenyoung on 14-2-16.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabPickerView : UIViewController

@property(retain,nonatomic) IBOutlet UITextField* textField_Name;
@property(retain,nonatomic) IBOutlet UISegmentedControl* segmentControl_Gender;
@property(retain,nonatomic) IBOutlet UISwitch* switch_Remember;
@property(retain, nonatomic) IBOutlet UIButton* button_Add;
@property(retain,nonatomic) IBOutlet UIButton* button_Delete;
@property(retain, nonatomic) IBOutlet UIPickerView* pickerView_List;

@end
