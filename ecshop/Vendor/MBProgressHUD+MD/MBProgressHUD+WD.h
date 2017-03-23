//
//  MBProgressHUD+WD.h
//  MBProgressHUD+MD
//
//  Created by 吴狄 on 2017/3/23.
//  Copyright © 2017年 Ditiy. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (WD)


+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;


+(void)showPromptInfo:(NSString *)message toView:(UIView *)view;



+(void)showPromptInfo:(NSString *)message;

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (void)hideHUD;


@end
