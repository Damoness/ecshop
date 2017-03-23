//
//  NSString+RegularExpression.h
//  ecshop
//
//  Created by 吴狄 on 2017/3/21.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularExpression)


-(Boolean)isPhoneNo;


-(Boolean)isPhoneVerifyCode; //手机验证码


-(Boolean)isIdentityCard; //验证身份证


-(Boolean)isEmail; //邮箱
@end
