//
//  shoppingCartModel.m
//  ecshop
//
//  Created by 吴狄 on 2016/12/22.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import "ShoppingCartModel.h"

@implementation ShoppingCartModel



-(NSDictionary *)toShoppingCartParams{
    
    return [super toParams];
}

-(NSDictionary *)toDeleteGoodsFromShoppingCartParams{
    
    
    NSMutableString *mStr = [NSMutableString new];
    
    if (self.deletedGoodsIds && self.deletedGoodsIds.count > 0) {
        
        [mStr appendString: self.deletedGoodsIds.firstObject];
        
    }
    
    if(self.deletedGoodsIds.count >1){
        
        for (int i = 1; i < self.deletedGoodsIds.count; i++) {
            NSString *str = [NSString stringWithFormat:@",%@",self.deletedGoodsIds[i]];
            [mStr appendString:str];
        }
        
    }
    
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"rec_id":mStr
                                    }.mutableCopy;
    
    return params;
    
}




@end
