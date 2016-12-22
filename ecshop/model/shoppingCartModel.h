//
//  shoppingCartModel.h
//  ecshop
//
//  Created by 吴狄 on 2016/12/22.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "goodsModel.h"
@interface shoppingCartModel : NSObject


@property (nonatomic,strong) NSMutableArray<goodsModel *> *goods;



@end
