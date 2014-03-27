//
//  FuncDetails.m
//  iTest
//
//  Created by revenyoung on 14-3-26.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import "FuncDetails.h"

@interface FuncDetails ()

@end

@implementation FuncDetails

@synthesize row;
@synthesize label_FuncName;
@synthesize aiv_Loading;
@synthesize textField_Url;
@synthesize webView;

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
    
    label_FuncName.text=row.Name;
    
    textField_Url.text=@"http://g.cn";
    NSURL *url =[NSURL URLWithString:textField_Url.text];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)button_Exist_Click:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [aiv_Loading startAnimating] ;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [aiv_Loading stopAnimating];
    [aiv_Loading removeFromSuperview];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
