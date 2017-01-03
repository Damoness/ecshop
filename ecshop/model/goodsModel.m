//
//  goodsModel.m
//  ecshop
//
//  Created by Jin on 15/12/25.
//  Copyright © 2015年 jsyh. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

-(void)setModel:(GoodsModel *)model{
    self.goods_id = model.goods_id;
    self.goods_img = model.goods_img;
    self.goods_name = model.goods_name;
    self.goods_price = model.goods_price;
    self.number = model.number;
    self.rec_id = model.rec_id;
}


-(NSDictionary *)toFollowedGoodsParams{
    
    return [super toParams];
}

//关注商品参数
-(NSDictionary *)toFollowGoodsParams{
    
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"goods_id":self.goods_id
                                    }.mutableCopy;
    
    return params;
    
}

//取消关注参数
-(NSDictionary *)toUnfollowGoodsParams{
    
    
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"goods_id":self.goods_id
                                    }.mutableCopy;
    
    return params;
    
}



@end
