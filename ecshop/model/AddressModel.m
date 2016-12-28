//
//  AddressModel.m
//  ecshop
//
//  Created by Jin on 15/12/22.
//  Copyright © 2015年 jsyh. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
-(void)setModel:(AddressModel *)model{
    self.is_default = model.is_default;
    self.address_id = model.address_id;
    self.address = model.address;
    self.telnumber = model.telnumber;
    self.username = model.username;
}



-(NSDictionary *)toAddAddressParams{
    
    NSMutableDictionary *params =  @{
                                     @"key":[LoginModel key],
                                     
                                     @"username":self.username,
                                     @"telnumber":self.telnumber,
                                     
                                     @"province":self.province,
                                     @"city":self.city,
                                     @"district":self.district,
                                     
                                     @"address_p":self.address,
                                     }.mutableCopy;
    
    
    return params;
    
}


-(NSDictionary *)toAddressParams{
    
    NSMutableDictionary *params =  @{
                                     @"key":[LoginModel key],
                                    
                                     }.mutableCopy;
    
    
    return params;
    
}

//用于删除地址
-(NSDictionary *)toDeleteParams{
    
    NSMutableDictionary *params =  @{
                                     @"key":[LoginModel key],
                                     @"address_id":self.address_id
                                     
                                     }.mutableCopy;
    
    
    return params;
}

//用于设置默认
-(NSDictionary *)toSetDefaultParams{
    
    NSMutableDictionary *params =  @{
                                     @"key":[LoginModel key],
                                     @"address_id":self.address_id
                                     
                                     }.mutableCopy;
    
    
    return params;
}

@end
