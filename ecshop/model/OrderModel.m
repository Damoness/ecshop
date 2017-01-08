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

- (NSDictionary *)toParams{
    
    return  [super toParams];
}

@end
