//
//  GestureModel.h
//  ecshop
//
//  Created by 吴狄 on 2017/3/19.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface GestureModel : BaseModel



@property (nonatomic,strong) NSString *mobile_phone; //手机号
@property (nonatomic,strong) NSString *gesture_pass; //手势密码


-(NSDictionary *)toSaveGestureCodeParams;


-(NSDictionary *)toFetchGestureCodeParams;

@end
