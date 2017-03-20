//
//  GestureModel.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/19.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "GestureModel.h"

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



@end
