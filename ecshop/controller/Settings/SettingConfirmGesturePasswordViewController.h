//
//  SettingConfirmGesturePasswordViewController.h
//  ecshop
//
//  Created by 吴狄 on 2017/3/14.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingGesturePasswordViewController.h"
@interface SettingConfirmGesturePasswordViewController : UIViewController


@property (nonatomic,strong) NSString *password; //上次的密码
@property (nonatomic,weak) id<SettingGesturePasswordViewControllerDelegate>delegate;
@end
