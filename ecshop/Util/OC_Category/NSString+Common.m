//
//  NSString+Common.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/3.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)


-(BOOL)isEmptyStr{
    
    if (self ==nil || [self isEqualToString:@""]) {
        
        return true;
        
    }else{
        
        return false;
    }
    
}


@end
