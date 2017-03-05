//
//  PayViewController.m
//  ecshop
//
//  Created by jsyh-mac on 16/1/11.
//  Copyright © 2016年 jsyh. All rights reserved.
//收银台页

#import "PayViewController.h"
#import "MyOrderViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "UIColor+Hex.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderModel.h"
@interface PayViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView * table;
    UILabel * lab2;
}
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
    [self initNavigationBar];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"订单中心" style:UIBarButtonItemStylePlain target:self action:@selector(orderCenterClicked)];
}
-(void)initViews
{
    UIView * headView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 35)];
    UILabel * lab1=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 20)];
    lab1.text=@"请选择支付方式";
    lab1.textColor=[UIColor lightGrayColor];
    lab1.textAlignment=NSTextAlignmentLeft;
    lab1.font=[UIFont systemFontOfSize:14];
    lab2=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, 7, 60, 20)];
    lab2.textAlignment=NSTextAlignmentLeft;
    lab2.text=_jiage;
    lab2.textColor=[UIColor redColor];
    lab2.font=[UIFont systemFontOfSize:13];
    [headView addSubview:lab2];
    [headView addSubview:lab1];
    [self.view addSubview:headView];
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    
}
-(void)orderCenterClicked
{
    MyOrderViewController * order=[[MyOrderViewController alloc]init];
    order.tagg = @"0";// 所以订单
    [self.navigationController pushViewController:order animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * string=@"string";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:string];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section==0) {
        cell.imageView.image=[UIImage imageNamed:@"支付-余额支付"];
        cell.textLabel.text=@"余额支付";
        cell.detailTextLabel.text=@"用户余额支付";
        
    }
    else if (indexPath.section==1)
    {
        cell.imageView.image=[UIImage imageNamed:@"支付-支付宝支付"];
        cell.textLabel.text=@"支付宝支付";
        cell.detailTextLabel.text=@"支付宝安全支付";
    }
    else if(indexPath.section == 2){
            cell.textLabel.text = @"微信支付";
            cell.imageView.image = [UIImage imageNamed:@"支付-微信支付"];
            cell.detailTextLabel.text=@"微信支付";
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.section==0) {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定使用您的账户余额支付吗?"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {

                                                                
                                                                  OrderModel *model = [OrderModel new];
                                                                  model.order_id = _orderNs;
                                                                  
                                                                  
                                                                  WS(ws)
                                                                  [[Ditiy_NetAPIManager sharedManager]request_PayOrder_WithPayType:PayWithBalance Params:[model toPayOrderParams] andBlock:^(id data, NSError *error) {
                                                                      
                                                                      
                                                                      if(data){
                                                                          
                                                                          [MBProgressHUD showSuccess:data[@"msg"]];
                                                                          [ws.navigationController popToRootViewControllerAnimated:YES];
                                                                          
                                                                      }
                                                                      
                                                                      
                                                                      
                                                                  }];
                                                                  

                                                                  
                                                              }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler: nil];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else if (indexPath.section==1)
    {
        
        
        OrderModel *model = [OrderModel new];
        model.order_id = _orderNs;
        
        
        WS(ws)
        [[Ditiy_NetAPIManager sharedManager]request_PayOrder_WithPayType:PayWithAlipay Params:[model toPayOrderParams] andBlock:^(id data, NSError *error) {
            
            
            if(data){
                
                NSString * orderStr=data[@"data"];
                NSString *appScheme = @"alisdk123";
                [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    
                    
                    if([resultDic[@"resultStatus"]intValue] == 9000){
                        
                        [MBProgressHUD showSuccess:@"购买成功"];
                        
                        [ws.navigationController popToRootViewControllerAnimated:YES];
                        
                    }else{
                        
                        
                        [MBProgressHUD showSuccess:resultDic[@"memo"]];
                        
                    }
                    
                }];
                
            }
            
            
            
        }];
        
    }
    else if(indexPath.section == 2){
            //[self bizPay];
        
        OrderModel *model = [OrderModel new];
        model.order_id = _orderNs;
        
        //[self payWithWeChat];
        
        WS(ws)
        [[Ditiy_NetAPIManager sharedManager]request_PayOrder_WithPayType:PayWithWeChat Params:[model toPayOrderParams] andBlock:^(id data, NSError *error) {
            
            if(data){
                
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
            
            
            
        }];
        
        
        
    }
}


-(void)payWithWeChat{
    
    
    PayReq *request = [[PayReq alloc] init];
    
    /** 商家向财付通申请的商家id */
    request.partnerId = @"1220277201";
    /** 预支付订单 */
    request.prepayId= @"82010380001603250865be9c4c063c30";
    /** 商家根据财付通文档填写的数据和签名 */
    request.package = @"Sign=WXPay";
    /** 随机串，防重发 */
    request.nonceStr= @"lUu5qloVJV7rrJlr";
    /** 时间戳，防重发 */
    request.timeStamp= 1458893985;
    /** 商家根据微信开放平台文档对数据做的签名 */
    request.sign= @"b640c1a4565b476db096f4d34b8a9e71960b0123";
    /*! @brief 发送请求到微信，等待微信返回onResp
     *
     * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
     * SendAuthReq、SendMessageToWXReq、PayReq等。
     * @param req 具体的发送请求，在调用函数后，请自己释放。
     * @return 成功返回YES，失败返回NO。
     */
    [WXApi sendReq: request];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark -- 自定义导航栏
- (void)initNavigationBar{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *naviBGColor = data[@"navigationBGColor"];
    NSString *navigationTitleFont = data[@"navigationTitleFont"];
    int titleFont = [navigationTitleFont intValue];
    NSString *naiigationTitleColor = data[@"naiigationTitleColor"];
    NSString *navigationRightColor = data[@"navigationRightColor"];
    NSString *navigationRightFont = data[@"navigationRightFont"];
    int rightFont = [navigationRightFont intValue];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor colorWithHexString:naviBGColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, self.view.frame.size.width - 200, 44)];
    label.text = @"收银台";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:titleFont];
    label.textColor = [UIColor colorWithHexString:naiigationTitleColor];
    [view addSubview:label];
    
    UIImage *img = [UIImage imageNamed:@"back.png"];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 20, 20)];
    imgView.image = img;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [btn addSubview:imgView];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
//    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(label.frame.origin.x + label.frame.size.width + 10, 25, 80, 30)];
//    [rightBtn setTitle:@"订单中心" forState:UIControlStateNormal];
//    [rightBtn setTitleColor:[UIColor colorWithHexString:navigationRightColor] forState:UIControlStateNormal];
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:rightFont];
//    [rightBtn addTarget:self action:@selector(centerBtn) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:rightBtn];
    [self.view addSubview:view];
    
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)bizPay {
//    NSString *res = [WXApiRequestHandler jumpToBizPay];
//    if( ![@"" isEqual:res] ){
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        
//        [alter show];
//        
//    }
//    
//}
@end
