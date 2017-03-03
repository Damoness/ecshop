//
//  SharingManModel.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/2.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "SharingManModel.h"

@implementation SharingManModel


- (NSDictionary *)toRegisterParams{
    
    NSMutableDictionary *params = @{
                                    @"key":[LoginModel key],
                                    @"edi_mobile":self.edi_mobile,
                                    @"edi_mobile_vali_code":self.edi_mobile_vali_code,
                                    @"edi_invite_code":self.edi_invite_code,
                                    //@"edi_general_id":self.edi_general_id,
                                    @"edi_real_name":self.edi_real_name,
                                    @"edi_card":self.edi_card,
                                    @"addr_provinces":self.addr_provinces,
                                    @"addr_city":self.addr_city,
                                    @"addr_detail":self.addr_detail,
                                    @"edi_card_face":self.edi_card_face,
                                    @"edi_card_back":self.edi_card_back,
                                    }.mutableCopy;
    
    
    if ([self.edi_invite_code isEqualToString:self.platform_code] && !self.edi_general_id) {
        
        [params setValue:@"edi_general_id" forKey:self.edi_general_id];
        
    }
    
    return params;
    
}
@end
