//
//  DitiyNetAPIClient.h
//  ecshop
//
//  Created by 吴狄 on 2016/12/23.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface DitiyNetAPIClient : AFHTTPSessionManager

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod ;

+(instancetype)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;


@end
