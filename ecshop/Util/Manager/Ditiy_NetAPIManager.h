//
//  Ditiy_NetAPIManager.h
//  ecshop
//
//  Created by 吴狄 on 2016/12/23.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DitiyNetAPIClient.h"

//typedef (void (^)(id data ,NSError *error)) Block;

@interface Ditiy_NetAPIManager : NSObject


+ (instancetype)sharedManager;


#pragma mark - Login
-(void)request_Login_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;



#pragma mark - Order
-(void)request_CreateOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;



#pragma mark - User

//获取用户信息
-(void)request_UserInfo_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;
//更新用户信息
-(void)request_UpdateUserInfo_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;



#pragma mark - Goods  

//获取用户关注的商品  toFollowedGoodsParams
-(void)request_FollowedGoods_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

//关注商品  toFollowGoodsParams
-(void)request_FollowGoods_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

//取消关注商品 toUnfollowGoodsParams
-(void)request_UnfollowGoods_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

//加入购物车 toAddGoodsParams
-(void)request_AddGoodsToShoppingCart_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

//获取商品详情 toDetailedGoodsInfoParams
-(void)request_DetailedGoodsInfo_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;



#pragma mark - ShoppingCart

//获取购物车  toShoppingCartParams
-(void)request_ShoppingCart_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

#pragma mark - Bonus

//获取用户优惠券
-(void)request_UserBonus_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;


#pragma mark - Address 用户地址
//增加
-(void)request_AddAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;

//查询
-(void)request_GetAddressList_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;


//查询单条详细记录
-(void)request_GetDetailAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;


//删除
-(void)request_DeleteAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;

//修改
-(void)request_ModifyAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;


//设置默认地址
-(void)request_SetDefaultAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;



#pragma mark - OrderList 用户订单

typedef enum {
    OrderAll = 0, //所有订单
    OrderUnpayed, //待付款
    OrderUndispatched , //代发货
    OrderUnreceived  ,//待收货
    OrderFinished  //已完成
} OrderType;


-(void)request_GetOrderList_withOrderType:(OrderType)type Params:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;

@end
