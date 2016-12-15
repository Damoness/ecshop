//
//  LoginModel.m
//  ecshop
//
//  Created by 吴狄 on 2016/12/15.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import "LoginModel.h"
#import "UserModel.h"

#define kLoginStatus @"login_status"

#define KLoginUserDic @"user_dic"


static UserModel *userModel;

@implementation LoginModel


+(Boolean)isLogin{
    
    
   NSNumber *loginStatus =  [[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus];
    
    
    if (loginStatus.boolValue) {
        
        return YES;
        
    }else{
        
        return NO;
    }
    
}


+(void)doLogin:(NSDictionary *)dic{

    
    if (dic) {
        
        NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:kLoginStatus];
        
         userModel =  [UserModel mj_objectWithKeyValues:dic];
        
        [defaults setObject:userModel forKey:KLoginUserDic];
        
        [defaults synchronize];
        
    }
    
    
    
    
}

@end
