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

//获取导航页图片
-(void)request_WelcomeGuidePicBlock:(void (^)(id data,NSError *error))block{
    
    NSString *path = @"Welcome/guidePicture";
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:nil withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
    }];
    
    
}

//注册分销商
-(void)request_RegisterSharingMan_WithParams:(NSDictionary *)params andProgress:(void (^)(float progress))progress andBlock:(void (^)(id data, NSError *error))block{
    
    //http://sitmarket.ditiy.com/mobile/api_user_distributer_profile_save.php
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api_user_distributer_profile_save.php",baseURLStr];
    
    
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    
    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        UIImage *image =  [UIImage imageNamed:@"1"];
        
        NSData *fileData = UIImageJPEGRepresentation(image, 1);
        
        // 设置上传图片的名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        
        [formData appendPartWithFileData:fileData name:@"edi_card_face" fileName:fileName mimeType:@"image/png"];
        
        [formData appendPartWithFileData:fileData name:@"edi_card_back" fileName:fileName mimeType:@"image/png"];
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.completedUnitCount/ uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        block(responseObject,nil);
        NSLog(@"%@",[responseObject toConsole]);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(nil,error);
    }];

}

//更新支付结果
-(void)request_UpdatePayResult_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block{
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api_weixin_paysuccess.php",baseURLStr];
    
 
        AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
        [manager POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    
            block(responseObject,nil);
    
    
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    
            block(nil,error);
            
            
        }];
    
    
//    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
//        
//        block(data,error);
//        
//    }];
    
    
}


//注册分销商
-(void)request_RegisterSharingMan_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block{
    
    //http://sitmarket.ditiy.com/mobile/api_user_distributer_profile_save.php
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api_user_distributer_profile_save.php",baseURLStr];
    
    
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    
    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    
        // 设置上传图片的名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(params[@"edi_card_face"], 1) name:@"edi_card_face" fileName:fileName mimeType:@"image/png"];
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(params[@"edi_card_back"], 1) name:@"edi_card_back" fileName:fileName mimeType:@"image/png"];
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //progress(uploadProgress.completedUnitCount/ uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        block(responseObject,nil);
        NSLog(@"%@",[responseObject toConsole]);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(nil,error);
    }];
    
//    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        
//        UIImage *image =  [UIImage imageNamed:@"1"];
////        
//        [formData appendPartWithFormData:UIImagePNGRepresentation(image) name:@"edi_card_face"];
//        [formData appendPartWithFormData:UIImagePNGRepresentation(image) name:@"edi_card_back"];
//        
//        //NSString *theImagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];
//
////        [formData appendPartWithFileURL:[NSURL URLWithString:theImagePath] name:@"edi_card_face" error:nil];
////        [formData appendPartWithFileURL:[NSURL URLWithString:theImagePath] name:@"edi_card_back" error:nil];
//
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        block(responseObject,nil);
//        //NSLog(@"%@",[responseObject toConsole]);
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        block(nil,error);
//
//        
//    }];
    
    
//    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSString *str =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
//        block(str,nil);
//        
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        
//        block(nil,error);
//        
//        
//    }];
}


//请求保存手势密码
-(void)request_SaveGestureCode_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block{
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api/gesture_passCode.php",baseURLStr];
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
    }];
    
    
}


//请求获取手势密码
-(void)request_FetchGestureCode_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block{
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api/gesture_passCode.php",baseURLStr];
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
    }];
    
    
}



-(void)request_PhoneVerifyCode_WithParam:(NSString *)phone andBlock:(void (^)(id data,NSError *error))block{
    
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api/getmobileauthcode.php",baseURLStr];
    
    NSDictionary *dic = @{
                          @"mobile_phone":phone
                          };
    
    
    
//    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
//    
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
//    
//    [manager GET:path parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//
//        block(responseObject,nil);
//        
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        
//        block(nil,error);
//        
//        
//    }];
    
    

    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:dic withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
      
        block(data,error);
        
    }];
    
}

-(void)request_VerifyPhoneCode:(NSString *)phoneCode WithPhoneNo:(NSString *)phoneNo andBlock:(void (^)(id data, NSError *error))block{
    
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api/verifyauthcode.php",baseURLStr];
    
    NSDictionary *dic = @{
                          @"mobile_phone":phoneNo,
                          @"pass_code":phoneCode
                          };
    
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:dic withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        
        block(data,error);
        
    }];
    
    
}

-(void)request_VersionOfAppInAppStore:(NSString *)appId andBlock:(void(^)(id data,NSError *error))block{
    
    
    NSString *path = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",appId];
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
    }];
    
    
}

//请求将系
-(void)request_KingSeriesBlock:(void (^)(id data,NSError *error))block{
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api/get_generalinfo.php",baseURLStr];
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
    }];
    
    
}

//获取平台码
-(void)request_PlatformCodeBlock:(void (^)(id data,NSError *error))block{

    NSString *path = [NSString stringWithFormat:@"%@/mobile/api.php?act=get_platform_code&return_data=json",baseURLStr];
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        block(data,error);
        
        
    }];
    
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

//获取用户信息(通过用户ID)
-(void)request_UserInfoWithUserID:(NSString *)userID andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *path = @"user/userIdinfo";
    
    NSDictionary *params = @{
                          
                          @"user_id":userID
                          
                          };
    
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


//取消订单
-(void)request_CancelOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *toPath = @"order/qorder";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
    
    
}

//再次购买
-(void)request_RebuyOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    NSString *toPath = @"order/recart";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {

        block(data,error);

    }];
    
}

//确认收货
-(void)request_ConfirmReceiveOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    
    NSString *toPath = @"order/received";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:YES andBlock:^(id data, NSError *error) {
        
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

-(void)request_OrderDetailInfo_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    
    
    NSString *toPath = @"order/lorder";
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
}

-(void)request_PayOrder_WithPayType:(PayType)type Params:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block{
    
    
    
    NSString *toPath = @"order/pay";
    
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:params];
    [mDic setObject:[NSString stringWithFormat:@"%d",type] forKey:@"type"];
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:mDic withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
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

//获取商品详情 toDetailedGoodsInfoParams
-(void)request_DetailedGoodsInfoV2_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block{
    //http://sitmarket.ditiy.com/mobile/api_goods.php
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api_goods.php",baseURLStr];
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
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



//获取热搜关键字
-(void)request_HotSearchKeyBlock:(void (^)(id data ,NSError *error))block{
    
    NSString *toPath = @"first/keywords";
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:toPath withParams:nil withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
       
        
        block(data,error);
        
    }];
    
}


-(void)request_PayOrder_AppH5_WithPayType:(PayType)type Params:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block{
    
    
    NSString *toPath = @"order/appH5Pay";
    
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:params];
    [mDic setObject:[NSString stringWithFormat:@"%d",type] forKey:@"type"];
    
    [[DitiyNetAPIClient sharedJsonClient] requestJsonDataWithPath:toPath withParams:mDic withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
        
    }];
    
    
    
}


//请求保存手势密码
-(void)request_H5_SaveGestureCode_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block{
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api/h5gesture_passCode.php",baseURLStr];
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
    }];
    
    
}


//请求获取手势密码
-(void)request_H5_FetchGestureCode_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block{
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api/h5gesture_passCode.php",baseURLStr];
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        
        
        
        block(data,error);
        
        
    }];
    
    
}


/**
 获取用户ID 对应手机号的验证码
 
 @param phone <#phone description#>
 @param block <#block description#>
 */
-(void)request_H5_PhoneVerifyCode_WithUserID:(NSString *)UserID andBlock:(void (^)(id data,NSError *error))block{
    
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api/getuseridAuthcode.php",baseURLStr];
    
    NSDictionary *dic = @{
                          @"user_id":UserID
                          };

    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:dic withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        
        block(data,error);
        
    }];
    
}


/**
 验证用户ID对应手机号 和 验证码是否匹配
 
 @param phoneCode 验证码
 @param UserID 用户ID
 @param block 结果
 */
-(void)request_H5_VerifyPhoneCode:(NSString *)phoneCode WithUserID:(NSString *)UserID andBlock:(void (^)(id data, NSError *error))block{
    
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api/verifyuseridAuthcode.php",baseURLStr];
    
    NSDictionary *dic = @{
                          @"user_id":UserID,
                          @"pass_code":phoneCode
                          };
    
    
    [[DitiyNetAPIClient sharedJsonClient]requestJsonDataWithPath:path withParams:dic withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        
        block(data,error);
        
    }];
    
    
}




@end
