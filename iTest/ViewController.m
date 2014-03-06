//
//  ViewController.m
//  iTest
//
//  Created by revenyoung on 14-2-14.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize label_Notice;
@synthesize textField_Name;
@synthesize button_Greet;
@synthesize segmentControl_Gender;
@synthesize slider_Age;
@synthesize switch_Remember;
@synthesize stepper_Age;
@synthesize button_Alter;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    stepper_Age.value=slider_Age.value;
}

- (IBAction)backgroundb_TouchDown:(id)sender
{
    [textField_Name resignFirstResponder];
}

-(IBAction)stepper_Age_ValueChanged:(id)sender
{
    slider_Age.value=stepper_Age.value;
}

-(IBAction)button_Greet_Click:(id)sender
{
    NSString *state;
    if(switch_Remember.isOn)
    {
        state=@"ON";
    }
    else
    {
        state=@"OFF";
    }
    label_Notice.text=[[NSString alloc] initWithFormat:@"%@ %@ %@ %f %@", @"Hello"
                       , textField_Name.text
                       , [segmentControl_Gender titleForSegmentAtIndex:segmentControl_Gender.selectedSegmentIndex]
                       ,slider_Age.value
                       ,state];
}

-(IBAction)button_Alter_Click:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:label_Notice.text delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:@"OK",@"SETTING",nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        UITextField *name=[actionSheet textFieldAtIndex:0];
        textField_Name.text=name.text;
    }
}
@end
