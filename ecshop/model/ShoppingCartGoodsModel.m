//
//  ShoppingCartGoodsModel.m
//  ecshop
//
//  Created by 吴狄 on 2017/1/7.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "ShoppingCartGoodsModel.h"

@implementation ShoppingCartGoodsModel



-(NSDictionary *)toChangeNumOfGoodsFromShoppingCartParams{
    
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"rec_id":self.rec_id,
                                    @"num":[NSString stringWithFormat:@"%d",self.number]
                                    }.mutableCopy;
    
    return params;
    
}


@end
