//
//  orderModel.m
//  ecshop
//
//  Created by 吴狄 on 2016/12/23.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel




-(NSString *)toPath{
    
    
    return @"";
    
}




//"address_id" = 89;
//amount = "15.00";
//"expressage_id" = 27;
//key = fdc2b334804e5ab5b37db152469813c7;
//"money_paid" = "15.00";
//"shipping_fee" = 15;
//type = 1;

- (NSDictionary *)toCreateOrderParams{
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"address_id":self.address_id,
                                    @"amount":self.amount,
                                    @"expressage_id":self.expressage_id,
                                    @"money_paid":self.money_paid,
                                    @"shipping_fee":self.shipping_fee,
                                    @"type":self.type,
                                    @"goods_id":self.goods_id
                                    }.mutableCopy;
    
    return params;
    
}


- (NSDictionary *)toCancelOrderParams{
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"order_id":self.order_id
                                    }.mutableCopy;
    
    return params;
    
}


//再次购买参数
- (NSDictionary *)toRebuyParams{
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"order_id":self.order_id
                                    }.mutableCopy;
    
    return params;
    
}


//确认收货参数
- (NSDictionary *)toConfirmReceiveOrderParams{
    
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"order_id":self.order_id
                                    }.mutableCopy;
    
    return params;
    
}

//详细订单参数
- (NSDictionary *)toOrderDetailInfoParams{
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"order_id":self.order_id
                                    }.mutableCopy;
    
    return params;
    
}

//支付订单参数
- (NSDictionary *)toPayOrderParams{
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"order_id":self.order_id
                                    }.mutableCopy;
    
    return params;
    
}


//H5支付订单参数
- (NSDictionary *)toPayOrderH5Params{
    
    NSMutableDictionary *params = @{
                                    @"order_id":self.order_id,
                                    @"type":self.payType
                                    }.mutableCopy;
    
    return params;
    
}

- (NSDictionary *)toParams{
    
    return  [super toParams];
}

@end
