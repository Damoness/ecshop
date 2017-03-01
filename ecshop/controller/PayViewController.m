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
#import "WXApiRequestHandler.h"
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
    return 2;
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
    //    else if(indexPath.section == 2){
    //        cell.textLabel.text = @"微信支付";
    //        cell.imageView.image = [UIImage imageNamed:@"支付-微信支付"];
    //        cell.detailTextLabel.text=@"微信支付";
    //    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NSString * pathh;
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
    //    else if(indexPath.section == 2){
    //        [self bizPay];
    //    }
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
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(label.frame.origin.x + label.frame.size.width + 10, 25, 80, 30)];
    [rightBtn setTitle:@"订单中心" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexString:navigationRightColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:rightFont];
    [rightBtn addTarget:self action:@selector(centerBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBtn];
    [self.view addSubview:view];
    
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)bizPay {
    NSString *res = [WXApiRequestHandler jumpToBizPay];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
        
    }
    
}
@end