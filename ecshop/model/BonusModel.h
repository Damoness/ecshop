//
//  Bonus.h
//  ecshop
//
//  Created by 吴狄 on 2017/1/3.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BonusModel : BaseModel

//"status" : "已使用",
//"order_id" : "284",
//"type_name" : "用户红包",
//"status_num" : 1,
//"type_money" : "10.00",
//"min_goods_amount" : "10.00",
//"use_end_date" : "1484841600",
//"use_start_date" : "1482163200"

@property(nonatomic,strong) NSString *status;

@property(nonatomic,strong) NSString *order_id;

@property(nonatomic,strong) NSString *type_name;

@property(nonatomic,strong) NSString *status_num;

@property(nonatomic,strong) NSString *type_money;

@property(nonatomic,strong) NSString *min_goods_amount;

@property(nonatomic,strong) NSString *use_end_date;

@property(nonatomic,strong) NSString *use_start_date;



-(NSDictionary *)toParams;


@end
