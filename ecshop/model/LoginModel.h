//
//  LoginModel.h
//  ecshop
//
//  Created by 吴狄 on 2016/12/15.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject


@property (readwrite ,nonatomic,strong) NSString *user , *passwd;


//是否已经登录
+(Boolean)isLogin;

//登录成功后存储用户数据
+(void)doLogin:(NSDictionary *)dic;


@end
