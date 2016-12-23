//
//  Ditiy_NetAPIManager.h
//  ecshop
//
//  Created by 吴狄 on 2016/12/23.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DitiyNetAPIClient.h"
@interface Ditiy_NetAPIManager : NSObject


+ (instancetype)sharedManager;

#pragma mark - Order
-(void)request_CreateOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;
                                                                       
@end
