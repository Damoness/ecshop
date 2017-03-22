//
//  GestureModel.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/19.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "GestureModel.h"
#import "Util.h"
@implementation GestureModel




-(NSDictionary *)toSaveGestureCodeParams{
    
    NSMutableDictionary *params = @{
                                    @"act":@"savePass",
                                    @"key":[LoginModel key],
                                    @"mobile_phone":self.mobile_phone,
                                    @"gesture_pass":self.gesture_pass
                                    
                                    }.mutableCopy;
    
    return params;
    
    
}


-(NSDictionary *)toFetchGestureCodeParams{
    
    NSMutableDictionary *params = @{
                                    @"act":@"fetchPass",
                                    @"key":[LoginModel key],
                                    @"mobile_phone":self.mobile_phone
                                    }.mutableCopy;
    
    return params;

    
}



-(NSDictionary *)toH5SaveGestureCodeParams{
    
    
    
    NSString *_3DES_user_id = [Util tripleDES_Encrypt:self.user_id withKey:k3DES_Ditiy_Key];
    NSString *_3DES_gesture_pass = [Util tripleDES_Encrypt:self.gesture_pass withKey:k3DES_Ditiy_Key];
    
    
    
    NSMutableDictionary *params = @{
                                    @"act":@"savePass",
                                    @"user_id":_3DES_user_id,
                                    @"gesture_pass":_3DES_gesture_pass
                                    
                                    }.mutableCopy;
    
    return params;
}


-(NSDictionary *)toH5FetchGestureCodeParams{
    
    
    
    NSString *_3DES_user_id = [Util tripleDES_Encrypt:self.user_id withKey:k3DES_Ditiy_Key];
    

    NSMutableDictionary *params = @{
                                    @"act":@"fetchPass",
                                    @"user_id":_3DES_user_id
                                    
                                    }.mutableCopy;
    
      return params;
}


@end
