//
//  LoginModel.m
//  ecshop
//
//  Created by 吴狄 on 2016/12/15.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import "LoginModel.h"

#define kLoginStatus @"kLoginStatus"

#define KLoginUserDic @"KLoginUserDic"

#define KLoginKey    @"KLoginKey"

//#define

static UserModel *userModel;

static  NSString *key;

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
        
        [defaults setObject:dic forKey:KLoginUserDic];
        
        userModel =  [UserModel mj_objectWithKeyValues:dic];
        

        [defaults synchronize];
        
    }
    
    
    
    
}

//登出
+(void)doLogout{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:kLoginStatus];
    [defaults synchronize];
    
}


+(NSString *)key{
    
    if (!key) {
        
        NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
        
        key =  [defaults stringForKey:KLoginKey];
        
    }
    
    return  key;
    
}


+(void)setKey:(NSString *)k{
    
    
    if (k) {
        
        key = k;
        
        NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:key forKey:KLoginKey];
        
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:kLoginStatus];
        
        [defaults synchronize];
    }
    
}


+ (UserModel *)currentLoginUser{
    if (!userModel) {
        
          NSDictionary *loginData = [[NSUserDefaults standardUserDefaults] objectForKey:KLoginUserDic];

          userModel = loginData ? [UserModel mj_objectWithKeyValues:loginData]:nil;
    }
    return userModel;
}

@end
