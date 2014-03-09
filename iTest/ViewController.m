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
@synthesize button_Loading;
@synthesize aiView;
@synthesize pView;

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
-(IBAction)button_Loading_Click:(id)sender
{
    if([aiView isHidden])
    {
        [aiView startAnimating];
    }
    else
    {
        [aiView stopAnimating];
    }
    [self startprogress:pView];
}
NSTimer* timer;
/* 启动进度条 */
-(IBAction)startprogress:(id)sender
{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.03f target:self selector:@selector(timeChanged:) userInfo:nil repeats:YES];
    
    /*
     启动一个定时器，间隔时间为0.03s，间隔0.03s即调用self里边的timechanged方法
     */
    
}
/* 停止进度条，进度都置为零*/
-(IBAction)stopprogress:(id)sender
{
    [timer invalidate];
    //    [timer release];
    timer = nil;
    pView.progress=0.0f;
    pView.progress=0.0f;
}
/* 进度条进度+0.01*/
-(IBAction)timeChanged:(id)sender
{
    
    pView.progress +=0.01f;
    pView.progress+=0.01f;
}


CGPoint pt;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =  [touches anyObject];
    pt=[touch locationInView:self.view];
    NSLog(@"x:%f y:%f", pt.x, pt.y);
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
