//
//  orderModel.h
//  ecshop
//
//  Created by 吴狄 on 2016/12/23.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : BaseModel

//@param goods_id       商品id
//* @param address_id     收获地址id
//* @param amount         商品总金额
//* @param money_paid     实际付费
//* @param shipping_fee   配送费用
//* @param expressage_id  配送方式id
//* @param redpacket      使用红包类型金额
//* @param bonus_id       红包id
//* @param bonus_type_id  红包类型id
//* @param message        订单留言
//* @param integral       积分可抵的金额
//* @param goods_attr_id  产品属性id
//* @param type           区分是直接购买还是从购物车购买 0：购物车，1：直接购买

@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSString *goods_id;
@property (nonatomic,strong) NSString *address_id;
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) NSString *money_paid;
@property (nonatomic,strong) NSString *shipping_fee;
@property (nonatomic,strong) NSString *expressage_id;
@property (nonatomic,strong) NSString *redpacket;
@property (nonatomic,strong) NSString *bonus_id;
@property (nonatomic,strong) NSString *bonus_type_id;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *integral;
@property (nonatomic,strong) NSString *goods_attr_id;
@property (nonatomic,strong) NSString *type;


- (NSDictionary *)toCreateOrderParams;

- (NSDictionary *)toParams;

@end
