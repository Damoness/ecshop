//
//  orderModel.m
//  ecshop
//
//  Created by 吴狄 on 2016/12/23.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel




-(NSString *)toPath{
    
    
    return @"";
    
}


- (NSDictionary *)toParams{
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key]
                             
                                    }.mutableCopy;
    
    return params;
    
}

@end
