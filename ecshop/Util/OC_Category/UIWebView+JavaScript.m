//
//  UIWebView+JavaScript.m
//  JS与OC
//
//  Created by 吴狄 on 2017/3/9.
//  Copyright © 2017年 Ditiy. All rights reserved.
//

#import "UIWebView+JavaScript.h"

@implementation UIWebView (JavaScript)

-(void)webView:(UIWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame
{
    //NSLog(@"弹出提示++++++");
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示：" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];// 在这里不用挂上代理 message 是webView里JS中提示的内容
    [alert show];
}

static BOOL diagStat = NO;
static NSInteger btIndex = -1;// 区别于 alert 消失是的按钮


- (BOOL)webView:(UIWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame
{
    
    UIAlertView *confirmAlert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确定",nil]; // 这里必须挂上代理 message 是webView里JS中提示的内容
    [confirmAlert show];
    btIndex = -1;
    
    while (btIndex==-1)
    {
        //[NSThread sleepForTimeInterval:0.2];
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1f]];
    }
    if (btIndex == 0)
    {
        //取消;
        diagStat = NO;
    }
    else if (btIndex == 1)
    {
        //确定;
        diagStat = YES;
    }
    return diagStat;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    btIndex = buttonIndex;
    if (buttonIndex == 0)
    {
        NSLog(@"取消 按钮");
    }
    else
    {
        NSLog(@"确定  按钮");
    }
}
@end
