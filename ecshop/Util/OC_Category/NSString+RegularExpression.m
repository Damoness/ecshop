//
//  NSString+RegularExpression.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/21.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "NSString+RegularExpression.h"

@implementation NSString (RegularExpression)


-(Boolean)isPhoneNo{
    
    
    NSRange range = [self rangeOfString:@"^1[3]\\d{9}$" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        NSLog(@"%@", [self substringWithRange:range]);
        
        return YES;
    }
    
    return NO;
    
}



-(Boolean)isPhoneVerifyCode{
    
    

//    NSString ＊email ＝ @“nijino_saki@163.com”；
//    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isValid = [predicate evaluateWithObject:email];
    
    
        NSString *regex = @"(^\\d{6}$)";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isValid = [predicate evaluateWithObject:self];
    
    
    return isValid;
    
    
}

@end