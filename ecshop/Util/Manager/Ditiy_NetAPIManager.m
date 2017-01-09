//
//  Ditiy_NetAPIManager.m
//  ecshop
//
//  Created by 吴狄 on 2016/12/23.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import "Ditiy_NetAPIManager.h"

@implementation Ditiy_NetAPIManager


+ (instancetype)sharedManager {
    static Ditiy_NetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}


-(void)request_Login_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *path = @"user/login";
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
       
        
        
        block(data,error);
        
        
    }];

    
}


-(void)request_UserInfo_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *path = @"user/userinfo";
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
    }];
    
    
}

//更新用户信息
-(void)request_UpdateUserInfo_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *path = @"user/modifyUser";
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
    }];
    
    
}

//修改用户密码  toChangePasswordParams
-(void)request_ChangePassword_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    
    NSString *toPath = @"user/modifypasswd";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
    
}



-(void)request_CreateOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *toPath = @"order/create";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
    
    
}

//确认订单
-(void)request_ConfirmOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *toPath = @"order/confirm";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
    
}


-(void)request_AddAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block{
    
    NSString *toPath = @"goods/address";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
}

//查询
-(void)request_GetAddressList_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block{
    
    
    NSString *toPath = @"goods/addresslist";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
}

//删除
-(void)request_DeleteAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block{
    
    NSString *toPath = @"goods/deladdress";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
}

//修改
-(void)request_ModifyAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block{
    
    NSString *toPath = @"goods/address";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
    
}

-(void)request_GetDetailAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block{
    
    
    NSString *toPath = @"goods/addrdetail";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
}


-(void)request_SetDefaultAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;
{
    
    NSString *toPath = @"goods/addrdefault";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
}


-(void)request_GetOrderList_withOrderType:(OrderType)type Params:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block{
    
    NSString *toPath ;
    
    switch (type) {
        case OrderAll:
            
            toPath = @"user/order";
            
            break;
        case OrderUnpayed:
            toPath = @"order/obligation";
            
            break;
        case OrderUndispatched:
            toPath = @"order/send_goods";
            
            break;
        case OrderUnreceived:
            toPath = @"order/reciv_goods";
            
            break;
        case OrderFinished:
            toPath = @"order/order_sucess";
            
            break;
    }
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
    
    
    
}


-(void)request_UserBonus_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    
    
    NSString *toPath = @"user/bonus";
    
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
    
}



-(void)request_FollowedGoods_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *toPath = @"goods/collectlist";
    
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
        
    }];
    
}


//关注商品  toFollowGoodsParams
-(void)request_FollowGoods_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *toPath = @"goods/collect";
    
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
        
    }];
}

//取消关注商品 toUnfollowGoodsParams
-(void)request_UnfollowGoods_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *toPath = @"goods/qcollect";
    
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
        
    }];
}

//加入购物车
-(void)request_AddGoodsToShoppingCart_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *toPath = @"goods/addcart";
    
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
        
    }];
    
    
}

//获取商品详情 toDetailedGoodsInfoParams
-(void)request_DetailedGoodsInfo_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    
    NSString *toPath = @"goods/goodsinfo";
    
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
        
    }];
    
}


//获取购物车
-(void)request_ShoppingCart_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *toPath = @"goods/cartlist";
    
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
        
    }];
    
}

//删除购物车的商品 toDeleteGoodsFromShoppingCartParams
-(void)request_DeleteGoodsFromShoppingCart_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    
    NSString *toPath = @"goods/delcart";
    
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
        
    }];
    
    
}

-(void)request_ChangeNumOfGoodsFromShoppingCart_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    
    NSString *toPath = @"goods/charnum";
    
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
        
    }];
    
}

@end
