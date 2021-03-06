//
//  ViewController.h
//  iTest
//
//  Created by revenyoung on 14-2-14.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController<ADBannerViewDelegate>

@property(retain, nonatomic) IBOutlet UILabel* label_Notice;
@property(retain,nonatomic) IBOutlet UITextField* textField_Name;
@property(retain, nonatomic) IBOutlet UISegmentedControl* segmentControl_Gender;
@property(retain, nonatomic) IBOutlet UISlider* slider_Age;
@property(retain, nonatomic) IBOutlet UISwitch* switch_Remember;
@property(retain, nonatomic) IBOutlet UIStepper* stepper_Age;
@property(retain,nonatomic) IBOutlet UIButton* button_Greet;
@property(retain,nonatomic) IBOutlet UIButton* button_Alter;
@property(retain,nonatomic) IBOutlet UIButton* button_Loading;
@property(retain,nonatomic) IBOutlet UIActivityIndicatorView* aiView;
@property(retain,nonatomic) IBOutlet UIProgressView* pView;
@property(retain,nonatomic) IBOutlet ADBannerView* adView;

@end
