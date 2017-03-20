//
//  SettingManager.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/16.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "SettingManager.h"


#define  kSetting_GesturePassword @"kSetting_GesturePassword" //手势密码
#define  kSetting_GestureLock @"kSetting_GestureLock"
static NSString *setting_GesturePassword;
static Boolean  setting_GestureLock;


@interface SettingManager ()

@property (nonatomic,strong) NSUserDefaults *defaults;
@end

@implementation SettingManager


+(instancetype)sharedManager{
    
    static SettingManager *settingManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        settingManager = [[self alloc]init];
        settingManager.defaults = [NSUserDefaults standardUserDefaults];
    });
    
    return settingManager;
    
}

//设置手势密码
-(void)setGesturePassword:(NSString *)password{
    
    
    if(password){
        
        setting_GesturePassword = password;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:password forKey:kSetting_GesturePassword];
        
        [defaults synchronize];

        
    }

    
}


-(Boolean)gestureLock{

    
    setting_GestureLock = [_defaults boolForKey:kSetting_GestureLock];
    
    
    return setting_GestureLock;
    
}

-(void)setGestureLock:(Boolean)gestureLock{
    
    if (setting_GestureLock != gestureLock) {
        
        setting_GestureLock = gestureLock;
        
        [_defaults setBool:setting_GestureLock forKey:kSetting_GestureLock];
        
        [_defaults synchronize];
        
    }

}

//获取手势
-(NSString *)gesturePassword{
    
    
    
    if (!setting_GesturePassword) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        setting_GesturePassword = [defaults objectForKey:kSetting_GesturePassword];
        
        
    }
    

    return setting_GesturePassword;
    
}


@end
