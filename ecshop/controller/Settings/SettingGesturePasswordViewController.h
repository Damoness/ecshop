//
//  SettingGesturePasswordViewController.h
//  ecshop
//
//  Created by 吴狄 on 2017/3/14.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class SettingGesturePasswordViewController;
@protocol SettingGesturePasswordViewControllerDelegate <NSObject>

-(void)settingGesturePasswordViewController:(SettingGesturePasswordViewController *)vc didFinishSettingWithPassword:(NSString *)password; //完成设置手势密码

@end


@interface SettingGesturePasswordViewController : UIViewController


@property (nonatomic,strong) NSString *promptStr;

@property (nonatomic,weak) id<SettingGesturePasswordViewControllerDelegate>delegate;

@end
