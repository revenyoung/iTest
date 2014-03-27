//
//  FuncDetails.h
//  iTest
//
//  Created by revenyoung on 14-3-26.
//  Copyright (c) 2014年 revenyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Func.h"

@interface FuncDetails : UIViewController

@property(retain, nonatomic) Func* row;
@property(retain, nonatomic) IBOutlet UILabel* label_FuncName;
@property(retain, nonatomic) IBOutlet UIActivityIndicatorView* aiv_Loading;
@property(retain, nonatomic) IBOutlet UITextField* textField_Url;
@property(retain, nonatomic) IBOutlet UIWebView* webView;


-(IBAction)button_Exist_Click:(id)sender;
-(void)webViewDidStartLoad:(UIWebView *)webView;
-(void)webViewDidFinishLoad:(UIWebView *)webView;
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
@end
