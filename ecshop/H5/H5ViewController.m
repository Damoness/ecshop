//
//  H5ViewController.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/6.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "H5ViewController.h"
#import "OrderModel.h"
#import "Util.h"
#import "WXApiManager.h"

#import <WebKit/WebKit.h>


@interface H5ViewController ()<UIWebViewDelegate,WXApiManagerDelegate>

@property (nonatomic,strong) UIWebView *webView;


@property (nonatomic,strong) OrderModel *myOrderModel;

@end

@implementation H5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //WKWebView
    
    NSURLCache *urlCache = [[NSURLCache alloc]initWithMemoryCapacity:4 * 1024 *1024 diskCapacity:20 *1024 * 1024 diskPath:nil];
    
    [NSURLCache setSharedURLCache:urlCache];
    
    [self initViews];
    
    [WXApiManager sharedManager].delegate = self;
    
}


-(void)initViews{
    
    
    self.myOrderModel = [OrderModel new];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"nav_arrow.png"];
    
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [backButton setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    _webView.delegate = self;
    
    [self.view addSubview:_webView];
    
    
    [self.webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://sitmarket.ditiy.com/mobile/"]]];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


-(void)backAction{
    
    [self.webView goBack];
    
}

//http://sitmarket.ditiy.com/mobile/weixinpay.php?out_trade_no=915

#define kURL_Order_Submit @"http://sitmarket.ditiy.com/mobile/flow.php?step=checkout" //立即购买

#define kURL_Order_Finished @"http://sitmarket.ditiy.com/mobile/flow.php?step=done" //提交订单成功

#define kURL_Order_PayWithWeixin @"http://sitmarket.ditiy.com/mobile/weixinpay.php?out_trade_no=" //微信支付 （包含）

//http://sitmarket.ditiy.com/mobile/flow.php?step=done

#define kURL2 @"http://sitmarket.ditiy.com/mobile/flow.php?step=cart"

#define kURL3 @"http://sitmarket.ditiy.com/mobile/user.php?act=order_detail&order_id"

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSMutableString *urlStr = [NSMutableString stringWithString:request.URL.absoluteString];
    
    NSLog(@"urlStr:%@",urlStr);
    //
    //    if ([urlStr hasSuffix:@"is_app=y"]) {
    //
    //        NSLog(@"urlStr:-YES%@",urlStr);
    //
    //        return YES;
    //
    //    }
    //    else
    if ([urlStr containsString:kURL3] && [urlStr hasSuffix:@"is_pay=1"]) {
        
        
        _myOrderModel = [OrderModel new];
        
        NSString *payType  = [webView stringByEvaluatingJavaScriptFromString:@"get_pay_type_for_app()"];
        
        
        NSLog(@"get_pay_type_for_app():%@",payType);
        
        if ([payType isEqualToString:@""]) {
            
            return NO;
        }
        
        
        if ([payType isEqualToString:@"weixin"]) {
            
            _myOrderModel.payType = [NSString stringWithFormat:@"%d",PayWithWeChat];
            
        }else if ([payType isEqualToString:@"alipay"]){
            
            _myOrderModel.payType = [NSString stringWithFormat:@"%d",PayWithAlipay];
            
        }
        
        
        
        //NSDictionary *dic =  [Util getURLParameters:urlStr];
        
        _myOrderModel.order_id = [[Util getURLParameters:urlStr] objectForKey:@"order_id"];
        
        WS(ws)
        [[Ditiy_NetAPIManager sharedManager]request_PayOrder_AppH5_WithPayType:PayWithWeChat Params:[_myOrderModel toPayOrderH5Params] andBlock:^(id data, NSError *error) {
            
            if(data && [ws.myOrderModel.payType intValue] == PayWithWeChat){
                [ws sendWechatPay:data];
            }
            
        }];
        
        
    }else if([urlStr isEqualToString:kURL_Order_Submit]) {
        
        
        NSLog(@"urlStr-加参数:%@",urlStr);
        
        if ([[[urlStr componentsSeparatedByString:@"/"]lastObject]containsString:@"?"]) {
            
            [urlStr appendString:@"&is_app=y"];
            
        }else{
            
            [urlStr appendString:@"?is_app=y"];
            
        }
        
        NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        
        
        [webView loadRequest:mRequest];
        
        //        NSMutableURLRequest *mRequest = request;
        //
        //        [mRequest setValue:@"y" forHTTPHeaderField:@"is_app"];
        //
        //        [webView loadRequest:mRequest];
        
        return NO;
        
    }
//    else if ([urlStr isEqualToString:kURL_Order_Finished] && [request valueForHTTPHeaderField:@"is_app"] == nil){
//        
//        //NSLog(@"%@",[request allHTTPHeaderFields]);
//        
//        
//        NSMutableURLRequest *mRequest = request;
//        
//        [mRequest setValue:@"y" forHTTPHeaderField:@"is_app"];
//        
//        
//        
//        [mRequest setHTTPMethod:@"POST"];
//        
//        //NSLog(@"%@",[request allHTTPHeaderFields]);
//        
//        [webView loadRequest:mRequest];
//        
//        return NO;
//        
//        
//        
//    }
    else  if([urlStr containsString:kURL_Order_PayWithWeixin]) {
        
        
        NSLog(@"webViewDidFinishLoad:%@",webView);
        
        NSString *orderId = [_webView stringByEvaluatingJavaScriptFromString:@"get_order_id_for_app()"];
        NSLog(@"orderId %@", orderId);
        
        //微信支付，支付宝
        
        NSArray *arrayData = [orderId componentsSeparatedByString:@"_"];
        
        
        
        NSLog(@"%@,%@",arrayData[0],arrayData[1]);
        
        
        self.myOrderModel.order_id = arrayData[0];
        
        
        if ([arrayData[1] isEqualToString:@"微信支付"]) {
            
            _myOrderModel.payType = [NSString stringWithFormat:@"%d",PayWithWeChat];
            
        }else if ([arrayData[1] isEqualToString:@"支付宝"]){
            
            _myOrderModel.payType = [NSString stringWithFormat:@"%d",PayWithAlipay];
            
        }
        
                // 获取当前页面的标题
                NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
                NSLog(@"title %@", title);
        
        
        WS(ws)
        [[Ditiy_NetAPIManager sharedManager]request_PayOrder_AppH5_WithPayType:PayWithWeChat Params:[_myOrderModel toPayOrderH5Params] andBlock:^(id data, NSError *error) {
            
            
            //[ws.myOrderModel.payType intValue] == PayWithWeChat
            
            
            NSLog(@"ws.myOrderModel.payType:%d, PayWithWeChat:%d ",[ws.myOrderModel.payType intValue],PayWithWeChat);
            
            
            
            if(data && [ws.myOrderModel.payType intValue] == PayWithWeChat){
                
                NSLog(@"微信支付");
                
                [ws sendWechatPay:data];
            }
            
        }];
        
        
        
    }
    
    return  true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideHUDForView:self.view animated:true];
    
    
    
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"%@",error);
    [MBProgressHUD hideHUDForView:self.view animated:true];
    
}



-(void)sendWechatPay:(id)data{
    
    PayReq *request = [[PayReq alloc] init];
    
    request.openID = data[@"data"][@"appid"];
    
    /** 商家向财付通申请的商家id */
    request.partnerId = data[@"data"][@"mch_id"];
    /** 预支付订单 */
    request.prepayId= data[@"data"][@"prepay_id"];
    /** 商家根据财付通文档填写的数据和签名 */
    request.package = @"Sign=WXPay";
    /** 随机串，防重发 */
    request.nonceStr= data[@"data"][@"nonce_str"];
    
    // 将当前时间转化成时间戳
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    UInt32 timeStamp =[timeSp intValue];
    request.timeStamp= timeStamp;
    
    /** 时间戳，防重发 */
    request.timeStamp= timeStamp;
    
    // 签名加密
    MXWechatSignAdaptor *md5 = [[MXWechatSignAdaptor alloc] init];
    
    /** 商家根据微信开放平台文档对数据做的签名 */
    request.sign=[md5 createMD5SingForPay:request.openID
                                partnerid:request.partnerId
                                 prepayid:request.prepayId
                                  package:request.package
                                 noncestr:request.nonceStr
                                timestamp:request.timeStamp];
    /*! @brief 发送请求到微信，等待微信返回onResp
     *
     * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
     * SendAuthReq、SendMessageToWXReq、PayReq等。
     * @param req 具体的发送请求，在调用函数后，请自己释放。
     * @return 成功返回YES，失败返回NO。
     */
    [WXApi sendReq: request];
    
    
}


-(void)UpdatePayResult{
    
    NSString *path = [NSString stringWithFormat:@"%@/mobile/api_weixin_paysuccess.php",baseURLStr];
    
    
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    
    [mRequest setHTTPMethod:@"POST"];
    
    
    //    NSDictionary *values = @{
    //                             @"order_id":_myOrderModel.order_id,
    //                             @"pay_result":@"00"
    //                             };
    //891
    NSString *order_id = [[NSString stringWithFormat:@"order_id=%@",_myOrderModel.order_id]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *pay_result = [[NSString stringWithFormat:@"pay_result=00"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *pay_type = [[NSString stringWithFormat:@"pay_type=微信"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //
    //                    NSMutableData *postData = [NSMutableData new];
    //
    //                    postData appendBytes:<#(nonnull const void *)#> length:<#(NSUInteger)#>
    //_myOrderModel.order_id
    
    NSString *valueStr = [[NSString stringWithFormat:@"order_id=%@&pay_result=00&pay_type=微信",_myOrderModel.order_id]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *postData = [valueStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    //                        [mRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];//请求头
    
    // values dat
    
    
    [mRequest setHTTPBody:postData];
    
    
    [_webView loadRequest:mRequest];
    
}


-(void)managerDidReceivePayResponse:(PayResp *)resp{
    
    NSString *strMsg;
    
    
    switch (resp.errCode) {
        case WXSuccess:{
            
            strMsg = @"支付结果：成功！";
            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            
            
            [self UpdatePayResult];
            
            
            break;
            
        }
            
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
    }
    
    
}

@end