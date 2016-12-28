//
//  AddressModel.h
//  ecshop
//
//  Created by Jin on 15/12/22.
//  Copyright © 2015年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
//收货地址id
@property(nonatomic,strong)NSString *address_id;
//详细的收货地址
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *telnumber; //电话
@property(nonatomic,strong)NSString *username;  //姓名
//是否默认收货地址0不是默认1是默认
@property(nonatomic,strong)NSString *is_default;


@property(nonatomic,strong)NSString *province,*city,*district;

@property(nonatomic,strong)AddressModel *model;


//用于新增用户地址
-(NSDictionary *)toAddAddressParams;

//用于查询地址
-(NSDictionary *)toAddressParams;

//用于删除地址
-(NSDictionary *)toDeleteParams;

//用于修改地址
-(NSDictionary *)toModifyParams;

//用于设置默认地址
-(NSDictionary *)toSetDefaultParams;
@end
