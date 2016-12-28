//
//  Ditiy_NetAPIManager.h
//  ecshop
//
//  Created by 吴狄 on 2016/12/23.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DitiyNetAPIClient.h"

//typedef (void (^)(id data ,NSError *error)) Block;

@interface Ditiy_NetAPIManager : NSObject


+ (instancetype)sharedManager;



#pragma mark - Login
-(void)request_Login_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;



#pragma mark - Order
-(void)request_CreateOrder_WithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError *error))block;



#pragma mark - 
-(void)request_AddAddress_WithParams:(NSDictionary *)params andBlock:(void (^)(id data ,NSError *error))block;
                                                                       
@end
