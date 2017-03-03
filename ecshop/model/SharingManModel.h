//
//  SharingManModel.h
//  ecshop
//
//  Created by 吴狄 on 2017/3/2.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "BaseModel.h"

@interface SharingManModel : BaseModel

@property(nonatomic,strong)NSString *edi_mobile; //手机号
@property(nonatomic,strong)NSString *edi_mobile_vali_code; //手机验证码
@property(nonatomic,strong)NSString *edi_invite_code; // 邀请码
@property(nonatomic,strong)NSString *edi_general_id; //将系ID
@property(nonatomic,strong)NSString *edi_real_name; //真实姓名
@property(nonatomic,strong)NSString *edi_card; //身份证号
@property(nonatomic,strong)NSString *addr_provinces; //省id
@property(nonatomic,strong)NSString *addr_city; //市id
@property(nonatomic,strong)NSString *addr_detail; //地址明细
@property(nonatomic,strong)UIImage *edi_card_face; //身份证正面
@property(nonatomic,strong)UIImage *edi_card_back; //身份证反面


@property(nonatomic,strong)NSString *platform_code; //从服务端获取的平台码


//+(BOOL)isRightPhoneNo:(NSString *)phone;

- (NSDictionary *)toRegisterParams;

@end
