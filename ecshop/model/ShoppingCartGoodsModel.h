//
//  ShoppingCartGoodsModel.h
//  ecshop
//
//  Created by 吴狄 on 2017/1/7.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartGoodsModel : BaseModel

//"goods_id" : "35"
//"rec_id" : "941",
//"goods_name" : "米妮哈鲁童装2015夏装新款女童韩版蕾丝连衣裙碎花公主裙",
//"number" : "1",
//"goods_price" : "149.00",
//"attrvalue_id" : [
//
//],
//"goods_img" : "http:\/\/sitmarket.ditiy.com\/images\/201507\/thumb_img\/35_thumb_G_1437508751067.jpg",


@property (nonatomic,strong)NSString *goods_id; //
@property (nonatomic,strong)NSString *rec_id;
@property (nonatomic,strong)NSString *goods_name;
@property (nonatomic)       int number;
@property (nonatomic,strong)NSString *goods_price;
@property (nonatomic,strong)NSArray  *attrvalue_id;
@property (nonatomic,strong)NSString *goods_img;


-(NSDictionary *)toChangeNumOfGoodsFromShoppingCartParams;


@end
