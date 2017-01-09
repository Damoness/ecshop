//
//  DitiyNetAPIClient.m
//  ecshop
//
//  Created by 吴狄 on 2016/12/23.
//  Copyright © 2016年 jsyh. All rights reserved.
//

#import "DitiyNetAPIClient.h"

#define kNetworkMethodName @[@"Get", @"Post", @"Put", @"Delete"]

@implementation DitiyNetAPIClient


+(instancetype)sharedJsonClient {
    
    static DitiyNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DitiyNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString: baseURLStr]];
    });
    return _sharedClient;
}

-(instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if(!self){
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    
    self.securityPolicy.allowInvalidCertificates = YES;
    
    return self;
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block{
    
    
    if (!aPath || aPath.length <=0) {
        return;
    }
    
    DebugLog(@"\n=========request===========\n%@\n%@:\n%@",kNetworkMethodName[method],aPath,params);
    
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    switch (method) {
        case Get:
            
            break;
            
        case Post:
        {
            [self POST:aPath parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, [responseObject toConsole]);
                
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                
                if (error) {
                    
                    block(nil,error);
                    
                }else{
                    
                    block(responseObject,nil);
                }
    
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
               
                
                block(nil,error);
                
            }];
        
            break;
        }
        default:
            
            break;
    }
    
    
}

#pragma mark NetError
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError{
    
    NSError *error  = nil;
    
    NSInteger code =  [(NSNumber *) [responseJSON valueForKey:@"code"]integerValue];
    
    
    if(code !=1){
        
        error = [NSError errorWithDomain:baseURLStr code:code userInfo:responseJSON];
        
        if(autoShowError){
            
            [MBProgressHUD showError:responseJSON[@"msg"]];
        }
        
        if(code == -220){ //用户未登录
            
            if ([LoginModel isLogin]) {
                [LoginModel doLogout];
            }
            
        }

    }
    
    return  error;
    
}


@end
