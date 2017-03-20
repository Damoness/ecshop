//
//  SettingManager.h
//  ecshop
//
//  Created by 吴狄 on 2017/3/16.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingManager : NSObject


@property (nonatomic,assign)Boolean fingerprintLock; //指纹解锁

@property (nonatomic,assign)Boolean gestureLock;  //手势解锁


+(instancetype)sharedManager;


//设置手势密码
-(void)setGesturePassword:(NSString *)password;


//获取手势
-(NSString *)gesturePassword;


@end
