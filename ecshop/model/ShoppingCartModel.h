//
//  shoppingCartModel.h
//  ecshop
//
//  Created by 吴狄 on 2016/12/22.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingCartGoodsModel.h"
@interface ShoppingCartModel : BaseModel


@property (nonatomic,strong) NSMutableArray<ShoppingCartGoodsModel *> *goods;


@property (nonatomic,strong) NSMutableArray *deletedGoodsIds;


@property (nonatomic,strong) NSMutableArray<ShoppingCartGoodsModel *> *selectedGoods; //被选择将要结算的商品

-(NSDictionary *)toShoppingCartParams;


-(NSDictionary *)toDeleteGoodsFromShoppingCartParams;


//用于获取确认订单的参数
-(NSDictionary *)toGetConfirmOrderParams;


@end
