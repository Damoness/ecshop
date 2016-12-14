//
//  NSDictionary+Common.m
//  ecshop
//
//  Created by 吴狄 on 2016/12/14.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import "NSDictionary+Common.h"

@implementation NSDictionary (Common)

//
-(NSString *)toConsole{
    // json数据或者NSDictionary转为NSData，responseObject为json数据或者NSDictionary
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    // NSData转为NSString
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonStr;
   
}


@end
