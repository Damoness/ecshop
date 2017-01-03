//
//  UserModel.m
//  ecshop
//
//  Created by 吴狄 on 2016/12/15.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel



-(NSDictionary *)toUserInfoParams{
    
    return [super toParams];
    
};

-(NSDictionary *)toUpdateUserInfoParams{
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"sex":self.sex,
                                    @"birthday":self.birthday
                                    }.mutableCopy;
    
    return params;
    
}

@end
