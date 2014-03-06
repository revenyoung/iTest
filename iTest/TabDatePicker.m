//
//  TabDatePicker.m
//  iTest
//
//  Created by revenyoung on 14-2-16.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import "TabDatePicker.h"

@interface TabDatePicker ()

@end

@implementation TabDatePicker

@synthesize label_Notice;
@synthesize datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    datePicker.date=[NSDate date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)datePicker_ValueChanged:(id)sender
{
    NSDateFormatter* formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    label_Notice.text=[formatter stringFromDate:datePicker.date];
}

@end
