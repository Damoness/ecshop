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



#pragma mark - UserAddress 用户地址
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
