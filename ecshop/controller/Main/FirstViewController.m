//
//  FirstViewController.m
//  ecshop
//
//  Created by jsyh-mac on 15/11/30.
//  Copyright © 2015年 jsyh. All rights reserved.
//首页

#import "FirstViewController.h"
#import "SearchViewController.h"
#import "Masonry.h"
#import "GoodsDetailViewController.h"
#import "SearchListViewController.h"
#import "MyTabBarViewController.h"
#import "BarCodeViewController.h"
#import "AFNetworkReachabilityManager.h"
@interface FirstViewController ()<UIWebViewDelegate,QRCodeDelegate,UIAlertViewDelegate>
{
    NSURLRequest *requestt;
    UIView *topView;//导航栏
   // UIView * viewww;
}


@property (nonatomic, strong) UIWebView *webview;

@end

@implementation FirstViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    
    [tabbar hideCustomTabbar:NO];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    
    [tabbar hideCustomTabbar:NO];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initViews];
   // [self afn];
    

}
//-(void)afn
//{
//    //1.创建网络状态监测管理者
//    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
//    
//    //2.监听改变
//    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:
//                [self createNoNet];
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                [self createNoNet];
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                
//                break;
//            default:
//                break;
//        }
//    }];
//}
//-(void)createNoNet
//{
//    viewww=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
//    viewww.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
//    UIImageView * notImgView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-47, viewww.frame.size.height/2-149,94, 75)];
//    UIImage * notImg=[UIImage imageNamed:@"ic_network_error.png"];
//    notImg=[notImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    notImgView.image=notImg;
//    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, viewww.frame.size.height/2-64, 150 , 20)];
//    label.numberOfLines=0;
//    label.text=@"网络请求失败!";
//    label.font=[UIFont systemFontOfSize:17];
//    label.textColor=[UIColor lightGrayColor];
//    label.textAlignment=NSTextAlignmentCenter;
//    UIButton * notBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    notBtn.frame=CGRectMake(self.view.frame.size.width/2-55, viewww.frame.size.height/2-34, 110, 50);
//    notBtn.layer.cornerRadius = 10.0;
//    [notBtn.layer setBorderWidth:1];
//    notBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
//    notBtn.backgroundColor=[UIColor whiteColor];
//    [notBtn setTitle:@"重新加载" forState:UIControlStateNormal ];
//    notBtn.titleLabel.font=[UIFont systemFontOfSize:15];
//    [notBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [notBtn addTarget:self action:@selector(reloadNotNet) forControlEvents:UIControlEventTouchUpInside];
//    [viewww addSubview:notImgView];
//    [viewww addSubview:notBtn];
//    [viewww addSubview:label];
//    [self.view addSubview:viewww];
//
//}
//-(void)reloadNotNet
//{
//    
//}
#pragma mark-扫一扫点击事件
-(void)scan_Action:(id)sender
{
    BarCodeViewController * code=[[BarCodeViewController alloc]init];
    code.delegate=self;
    [self presentViewController:code animated:YES completion:nil];
    
}


//消息点击事件
-(void)message_Action:(id)sender
{
    
}




-(void)QRCodeScanFinishiResult:(NSString *)result
{
    GoodsDetailViewController* good=[[GoodsDetailViewController alloc]init];
    if ([result rangeOfString:@"goods_id:"].location !=NSNotFound) {
        int a=[[result substringFromIndex:9 ]intValue];
        good.goodID=[NSString stringWithFormat:@"%d",a] ;
        [self.navigationController pushViewController:good animated:YES];
    }else {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"亲,只能扫描我们的商品二维码哦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}


//创建主界面
-(void)initViews
{
    
    self.navigationController.navigationBar.hidden=YES;
    
    _webview=[[UIWebView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    _webview.scrollView.showsVerticalScrollIndicator = NO;
    _webview.scrollView.bounces = NO;
    _webview.delegate=self;
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:indexURLStr]]];
    [self.view addSubview:_webview];
    
#pragma mark-左侧扫一扫  右侧消息
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    topView.backgroundColor = [UIColor redColor];
    topView.alpha = 0;
    [self.view addSubview:topView];
    //左侧扫一扫
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 24, 50, 40);
    UIImage * image1=[UIImage imageNamed:@"home_head_icon_saoyisao"];
    image1=[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setImage:image1 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(scan_Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //右侧消息
    UIButton * button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(kScreenWidth-50, 24, 50, 40);
    UIImage * image2=[UIImage imageNamed:@"home_head_icon_information"];
    [button2 setImage:image2 forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(message_Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
#pragma mark-搜索
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(55, 25, kScreenWidth - 110, 32);
    searchBtn.backgroundColor = [UIColor whiteColor];
    searchBtn.layer.borderWidth=1;
    searchBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    searchBtn.layer.cornerRadius = 5;
    searchBtn.layer.masksToBounds=YES;
    [searchBtn addTarget:self action:@selector(search_Action) forControlEvents:UIControlEventTouchUpInside];
    UIImage * imagebtn=[UIImage imageNamed:@"search"];
    imagebtn=[imagebtn imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView * imageviewLeft=[[UIImageView alloc]initWithFrame:CGRectMake(12, 8, 18, 18)];
    imageviewLeft.image=imagebtn;
    UILabel * centerLab=[[UILabel alloc]initWithFrame:CGRectMake(40, 8, 200, 18)];
    centerLab.text=@"点我搜索";
    centerLab.textColor=[UIColor lightGrayColor];
    centerLab.font=[UIFont systemFontOfSize:16];
    centerLab.textAlignment=NSTextAlignmentLeft;
    [searchBtn addSubview:centerLab];
    [searchBtn addSubview:imageviewLeft];
    [self.view addSubview:searchBtn];
}
#pragma mark-webview点击图片
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSURL * ulrNew=request.URL;
    NSString * newUrl=[NSString stringWithFormat:@"%@",ulrNew];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *url1 = data[@"shareurl"];
    
    
    NSLog(@"新的url -- %@",newUrl);
    NSLog(@"老的的url -- %@",url1);
    
    
    
    if ([newUrl isEqualToString:indexURLStr])
    {
        return YES;
    }
    
    if ([newUrl containsString:@".php"]) {
        
        return YES;
        
    }else{
        
        NSArray *separatedArray = [newUrl componentsSeparatedByString:@"/"];
        
        long no = [separatedArray count];
        
        if ([separatedArray[no - 2] isEqualToString:@"goodsid"]) {
            
            GoodsDetailViewController * good=[[GoodsDetailViewController alloc]init];
            good.goodID=separatedArray[no -1];
            [self.navigationController pushViewController:good animated:NO];
            
            return NO;
            
        }
        else if ([separatedArray[no - 2] isEqualToString:@"type"]){
            
            SearchListViewController * search=[[SearchListViewController alloc]init];
            search.typeState=separatedArray[no -1];
            [self.navigationController pushViewController:search animated:NO];
            
            return NO;
            
        }   else if ([separatedArray[no - 2] isEqualToString:@"icon"]){

            
            if ([separatedArray[no -1] isEqualToString:@"catalog"]) {//商品分类
                
                MyTabBarViewController *tab =(MyTabBarViewController *)self.navigationController.tabBarController;
               
            
                UIButton * button = [[UIButton alloc]init];
                button.tag = 101;
                [tab buttonClicked:button];
                
                tab.selectedIndex = 2;
                
                return NO;
            }
            else if ([separatedArray[no -1] isEqualToString:@"agent"]){//代理区
                
                
            }
            
            
            return NO;
            
        }
        

        
    }
    
    
    return NO;
}

#pragma mark-点击我跳转点击事件
-(void)search_Action
{
    SearchViewController *search=[[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:NO];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)dealloc {
    NSLog(@"%@ --%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"offset---scroll:%f",self.webview.scrollView.contentOffset.y);
    //[self.webview.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    UIScrollView *scrollView = object;
    int offset = scrollView.contentOffset.y;
    
    CGFloat alpha = 0;
    CGFloat a = 180 - offset;
    CGFloat b = a / 180;
    alpha=1-b;
    if (alpha <= 0.7) {
        topView.alpha = alpha;
        NSLog(@"%f - %f",scrollView.contentOffset.y,alpha);
        NSLog(@"a - %f",a);
        NSLog(@"b - %f",b);
    }
    
}
@end