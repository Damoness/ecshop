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


/**
 获取导航页图片

 @param block <#block description#>
 */
-(void)request_WelcomeGuidePicBlock:(void (^)(id data,NSError *error))block;


/**
 注册分销商

 @param params <#params description#>
 @param block <#block description#>
 */
-(void)request_RegisterSharingMan_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;


/**
 注册分销商

 @param params <#params description#>
 @param progress <#progress description#>
 @param block <#block description#>
 */
-(void)request_RegisterSharingMan_WithParams:(NSDictionary *)params andProgress:(void (^)(float progress))progress andBlock:(void (^)(id data, NSError *error))block;



/**
 获取手机号验证码

 @param phone <#phone description#>
 @param block <#block description#>
 */
-(void)request_PhoneVerifyCode_WithParam:(NSString *)phone andBlock:(void (^)(id data,NSError *error))block;


/**
 验证手机号 和 验证码是否匹配

 @param phoneCode 验证码
 @param phoneNo 手机号
 @param block 结果
 */
-(void)request_VerifyPhoneCode:(NSString *)phoneCode WithPhoneNo:(NSString *)phoneNo andBlock:(void (^)(id data, NSError *error))block;



//请求将系
-(void)request_KingSeriesBlock:(void (^)(id data,NSError *error))block;

//http://sitmarket.ditiy.com/mobile/api.php?act=get_platform_code&return_data=json
//获取平台码
-(void)request_PlatformCodeBlock:(void (^)(id data,NSError *error))block;

#pragma mark - Login

//用户登录    toLoginParams
-(void)request_Login_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;


#pragma mark - GestureModel 手势


//请求保存手势密码 toSaveGestureCodeParams
-(void)request_SaveGestureCode_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;


//请求获取手势密码 toFetchGestureCodeParams
-(void)request_FetchGestureCode_WithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block;




#pragma mark - Order 订单


//创建订单 toCreateOrderParams
-(void)request_CreateOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

//取消订单 toCancelOrderParams
-(void)request_CancelOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

//再次购买 toRebuyParams
-(void)request_RebuyOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

//确认收到商品 toConfirmReceiveOrderParams
-(void)request_ConfirmReceiveOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

typedef enum {
    OrderAll = 0, //所有订单
    OrderUnpayed, //待付款
    OrderUndispatched , //代发货
    OrderUnreceived  ,//待收货
    OrderFinished  //已完成
} OrderType;

//获取订单列表    toParams
-(void)request_GetOrderList_withOrderType:(OrderType)type Params:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;

//获取订单详细信息 toOrderDetailInfoParams
-(void)request_OrderDetailInfo_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

typedef enum{
    PayWithBalance = 1 ,//余额支付
    PayWithAlipay  = 4 ,   //支付宝
    PayWithWeChat  = 5    //微信
}PayType;

//支付订单 toPayOrderParams
-(void)request_PayOrder_WithPayType:(PayType)type Params:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;


#pragma mark - User

//获取用户信息  toUserInfoParams
-(void)request_UserInfo_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;
//更新用户信息  toUpdateUserInfoParams
-(void)request_UpdateUserInfo_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;
//修改用户密码  toChangePasswordParams
-(void)request_ChangePassword_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

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


//获取商品详情 toDetailedGoodsInfoParams
-(void)request_DetailedGoodsInfoV2_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;


#pragma mark - ShoppingCart

//获取购物车  toShoppingCartParams
-(void)request_ShoppingCart_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

//删除购物车的商品 toDeleteGoodsFromShoppingCartParams
-(void)request_DeleteGoodsFromShoppingCart_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;

//确认订单 toGetConfirmOrderParams
-(void)request_ConfirmOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;



#pragma mark - ShoppingCartGoods
//修改购物车某个商品的数量 toChangeNumOfGoodsFromShoppingCartParams
-(void)request_ChangeNumOfGoodsFromShoppingCart_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;



#pragma mark - Bonus

//获取用户优惠券 toParams
-(void)request_UserBonus_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;


#pragma mark - Address 用户地址
//增加  toAddAddressParams
-(void)request_AddAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;

//查询 toAddressParams
-(void)request_GetAddressList_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;


//查询单条详细记录 toGetDetailAddressParams
-(void)request_GetDetailAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;


//删除 toDeleteParams
-(void)request_DeleteAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;

//修改 toModifyParams
-(void)request_ModifyAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;


//设置默认地址 toSetDefaultParams
-(void)request_SetDefaultAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;



#pragma mark - Search 搜索

//获取热搜关键字
-(void)request_HotSearchKeyBlock:(void (^)(id data ,NSError *error))block;



#pragma mark - H5用

//更新支付结果
-(void)request_UpdatePayResult_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;

//支付订单 toPayOrderParams
-(void)request_PayOrder_AppH5_WithPayType:(PayType)type Params:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;



//请求保存手势密码
-(void)request_H5_SaveGestureCode_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;


//请求获取手势密码 
-(void)request_H5_FetchGestureCode_WithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block;




#pragma mark - H5用


@end
