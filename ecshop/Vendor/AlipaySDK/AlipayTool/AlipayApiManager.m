//
//  AlipayApiManager.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/8.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "AlipayApiManager.h"

@implementation AlipayApiManager


+(instancetype)sharedManager{

    static AlipayApiManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[AlipayApiManager alloc]init];
    });

    return instance;
    
}



-(void)handleAlipayResult:(NSDictionary *)result{
    
    if (_delegate && [_delegate respondsToSelector:@selector(alipayApiManagerDidReceivePayResponse:)]) {
        
        [_delegate alipayApiManagerDidReceivePayResponse:result];
        
    }
    
    
}


@end
