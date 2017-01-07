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


-(NSDictionary *)toShoppingCartParams;


-(NSDictionary *)toDeleteGoodsFromShoppingCartParams;


@end
