//
//  OrderDetailModel.h
//  ecshop
//
//  Created by 吴狄 on 2017/1/10.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"
@interface OrderDetailModel : NSObject

//"consignee" : "Damon",
//"pay_name" : "支付宝",
//"order_sn" : "201701100221014835",
//"mobile" : "13202264038",
//"money_paid" : "135.00",
//"total" : 120,
//"address" : "中国广东省佛山市三水区(区\/县)12345678",
//"order_status" : "3",
//"shipping_name" : "韵达快递",
//"integral" : "0",
//"integral_money" : "0.00",
//"shipping_fee" : "15.00",
//"order_amount" : "0.00",
//"add_time" : "1484029261",
//"goods" : [
//           {
//               "goods_thumb" : "images\/201507\/thumb_img\/28_thumb_G_1437506346326.jpg",
//               "goods_price" : "120.00",
//               "goods_number" : "1",
//               "goods_name" : "进口费列罗巧克力礼盒DIY心形27粒【顺丰包邮】【代写贺卡】七夕礼物生日创意礼品"
//           }
//           ],
//"bonus" : "0.00"

@property (nonatomic,strong)NSString  *consignee;
@property (nonatomic,strong)NSString  *pay_name;
@property (nonatomic,strong)NSString  *order_sn;
@property (nonatomic,strong)NSString  *mobile;
@property (nonatomic,strong)NSString  *money_paid;
@property (nonatomic,strong)NSString  *total;
@property (nonatomic,strong)NSString  *address;
@property (nonatomic,strong)NSString  *order_status;
@property (nonatomic,strong)NSString  *shipping_name;
@property (nonatomic,strong)NSString  *integral;
@property (nonatomic,strong)NSString  *integral_money;
@property (nonatomic,strong)NSString  *shipping_fee;
@property (nonatomic,strong)NSString  *order_amount;
@property (nonatomic,strong)NSString  *add_time;
@property (nonatomic,strong)NSMutableArray<GoodsModel *>  *goods;


@end
