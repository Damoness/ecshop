//
//  Bonus.m
//  ecshop
//
//  Created by 吴狄 on 2017/1/3.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "BonusModel.h"

@implementation BonusModel


-(NSDictionary *)toParams{
    
    NSDictionary *params = @{
                             @"key":[LoginModel key]
                             
                             }.mutableCopy;
    
    
    return params;
    
    
}


@end
