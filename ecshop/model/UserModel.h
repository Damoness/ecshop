//
//  UserModel.h
//  ecshop
//
//  Created by 吴狄 on 2016/12/15.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UserModel : BaseModel

@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *nick_name;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *birthday;
@property(nonatomic,strong)NSString *email;

//关注数量
@property(nonatomic,strong)NSString *attention;

//分享卷
@property(nonatomic,strong)NSString *integration;

//分享豆
@property (nonatomic,strong)NSString *user_money;

//用户类型
@property (nonatomic,strong)NSString *rank_name;


//待付款数量
@property (nonatomic,strong)NSString *pay;
//待发货数量
@property (nonatomic,strong)NSString *shipping_send;

//已经发货数量
@property (nonatomic,strong)NSString *shipping;

//购物车数量
@property (nonatomic,strong)NSString *cart_num;

@property (nonatomic,strong)NSString *consume;

@property (nonatomic,strong)NSString *username ,*currentPassword , *changePassword ,*changePasswordConfirm;

-(NSDictionary *)toUserInfoParams;
-(NSDictionary *)toUpdateUserInfoParams;

//修改密码参数
-(NSDictionary *)toChangePasswordParams;

@end
