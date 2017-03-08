//
//  AlipayApiManager.h
//  ecshop
//
//  Created by 吴狄 on 2017/3/8.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol AlipayApiManagerDelegate <NSObject>

-(void)alipayApiManagerDidReceivePayResponse:(NSDictionary *)response;

@end


@interface AlipayApiManager : NSObject

+(instancetype)sharedManager;

-(void)handleAlipayResult:(NSDictionary *)result;

@property (nonatomic ,weak) id<AlipayApiManagerDelegate> delegate;

@end
