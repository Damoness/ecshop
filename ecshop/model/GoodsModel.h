//
//  goodsModel.h
//  ecshop
//
//  Created by Jin on 15/12/25.
//  Copyright © 2015年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : BaseModel
@property (nonatomic,strong)NSString *goods_id; //

@property (nonatomic,strong)NSString *goods_img;
@property (nonatomic,strong)NSString *goods_thumb;
@property (nonatomic,strong)NSString *goods_name;
@property (nonatomic,strong)NSString *goods_price;
@property (nonatomic,strong)NSString *goods_number;

@property (nonatomic,assign)int number;

@property (nonatomic,strong)NSString *attrvalue_id;

@property (nonatomic)Boolean is_attention; //是否关注
@property (nonatomic,strong)NSString *sales; //销售数量
@property (nonatomic,strong)NSString *goods_sn;

@property (nonatomic,strong)GoodsModel *model;



//关注的商品参数
-(NSDictionary *)toFollowedGoodsParams;

//关注商品参数
-(NSDictionary *)toFollowGoodsParams;

//取消关注参数
-(NSDictionary *)toUnfollowGoodsParams;

//加入购物车参数
-(NSDictionary *)toAddGoodsParams;

//获取商品详情参数
-(NSDictionary *)toDetailedGoodsInfoParams;

@end
