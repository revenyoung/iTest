//
//  TabPickerView.m
//  iTest
//
//  Created by revenyoung on 14-2-16.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import "TabPickerView.h"

@interface TabPickerView ()

@end

@implementation TabPickerView

@synthesize textField_Name;
@synthesize segmentControl_Gender;
@synthesize switch_Remember;
@synthesize button_Add;
@synthesize button_Delete;
@synthesize pickerView_List;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

NSString *plistPath;
NSMutableDictionary *dict;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //plistPath = [[NSBundle mainBundle] pathForResource:@"PropertyList" ofType:@"plist"];
    NSArray* appPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* appPath = [appPaths objectAtIndex:0];
    plistPath=[appPath stringByAppendingPathComponent:@"PropertyList.plist"];
    dict=[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundb_TouchDown:(id)sender
{
    [textField_Name resignFirstResponder];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSMutableArray* array=[[NSMutableArray alloc] init];
    switch(component)
    {
        case 0:
            array=[dict objectForKey:@"NAME"];
            break;
        case 1:
            array=[dict objectForKey:@"GENDER"];
            break;
    }
    return [array count];
}

-(UIView *)pickerView:(UIPickerView *)pickerView
          titleForRow:(NSInteger)row
         forComponent:(NSInteger)component
{
    NSMutableArray* array=[[NSMutableArray alloc] init];
    switch(component)
    {
        case 0:
            array=[dict objectForKey:@"NAME"];
            break;
        case 1:
            array=[dict objectForKey:@"GENDER"];
            break;
    }
    return [array objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if(component==0)
    {
        [pickerView selectRow:row inComponent:1 animated:YES];
    }
}

-(IBAction)button_Add_Click:(id)sender
{
    NSString* name=textField_Name.text;
    NSString* gender=[segmentControl_Gender titleForSegmentAtIndex:segmentControl_Gender.selectedSegmentIndex];
    NSString* remember=@"NO";
    if(switch_Remember.isOn)
    {
        remember=@"YES";
    }
    else
    {
        remember=@"NO";
    }
    NSDate* updatetime=[NSDate date];
    
    NSMutableArray* nameArray=[dict objectForKey:@"NAME"];
    [nameArray addObject:name];
    NSMutableArray* genderArray=[dict objectForKey:@"GENDER"];
    [genderArray addObject:gender];
    NSMutableArray* rememberArray=[dict objectForKey:@"REMEMBER"];
    [rememberArray addObject:remember];
    NSMutableArray* updatetimeArray=[dict objectForKey:@"UPDATETIME"];
    [updatetimeArray addObject:updatetime];
    
    [dict writeToFile:plistPath atomically:YES];
    
    [pickerView_List reloadAllComponents];
    
    NSLog(@"SAVED");
}
-(IBAction)button_Delete_Click:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"SURE FOR DELETE?" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:@"OK",nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        int row=[pickerView_List selectedRowInComponent:0];
        
        NSMutableArray* nameArray=[dict objectForKey:@"NAME"];
        [nameArray removeObjectAtIndex:row];
        NSMutableArray* genderArray=[dict objectForKey:@"GENDER"];
        [genderArray removeObjectAtIndex:row];
        NSMutableArray* rememberArray=[dict objectForKey:@"REMEMBER"];
        [rememberArray removeObjectAtIndex:row];
        NSMutableArray* updatetimeArray=[dict objectForKey:@"UPDATETIME"];
        [updatetimeArray removeObjectAtIndex:row];
        
        [dict writeToFile:plistPath atomically:YES];
        
        [pickerView_List reloadAllComponents];
        
        NSLog(@"DELETED");
    }
}
@end
