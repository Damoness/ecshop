//
//  IndexViewController.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/12.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "IndexViewController.h"
#import "SearchViewController.h"
#import "BarCodeViewController.h"
#import "GoodsDetailViewController.h"
#import "SearchListViewController.h"
#import "MyTabBarViewController.h"

@interface IndexViewController ()<UIWebViewDelegate,UIScrollViewDelegate,QRCodeDelegate>
{
    
    UIView *topView;//导航栏
    
    
}

@property (nonatomic,strong) UIWebView *myWebView;



@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initViews];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = true;
    
    
    MyTabBarViewController *myTbVC = (MyTabBarViewController *) self.navigationController.tabBarController;
    [myTbVC hideCustomTabbar:NO];
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
    
    
    MyTabBarViewController *myTbVC = (MyTabBarViewController *) self.navigationController.tabBarController;
    
    [myTbVC hideCustomTabbar:YES];
}


-(void)initViews{
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    _myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0 , 0, kScreenWidth, kScreenHeight)];
    
    _myWebView.scrollView.showsVerticalScrollIndicator = NO;
    _myWebView.scrollView.bounces = NO;
    
    
    _myWebView.delegate=self;
    _myWebView.scrollView.delegate = self;
    
    [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:indexURLStr]]];
    
    [self.view addSubview:_myWebView];
    
    
    topView = ({
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        view.backgroundColor = [UIColor redColor];
        view.alpha = 0;
        
        [self.view addSubview:view];
        
        //左侧扫一扫
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 24, 50, 40);
        UIImage * image1=[UIImage imageNamed:@"home_head_icon_saoyisao"];
        image1=[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [button setImage:image1 forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(scan_Action:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        //右侧消息
        UIButton * button2=[UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame=CGRectMake(kScreenWidth-50, 24, 50, 40);
        UIImage * image2=[UIImage imageNamed:@"home_head_icon_information"];
        [button2 setImage:image2 forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(message_Action:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button2];
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
        [view addSubview:searchBtn];
        
        
        view;
    });
    
    
}


#pragma mark-搜索点击事件
-(void)search_Action
{
    SearchViewController *search=[[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:NO];
}

#pragma mark-扫一扫点击事件
-(void)scan_Action:(id)sender
{
    BarCodeViewController *bcVC=[[BarCodeViewController alloc]init];
    bcVC.delegate=self;
    [self presentViewController:bcVC animated:YES completion:nil];
    
}


#pragma mark-消息点击事件
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSString *newUrl = request.URL.absoluteString;
    
    
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
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
    CGPoint contentOffset = _myWebView.scrollView.contentOffset;
    
    DebugLog(@"CGPoint:(%f,%f)",contentOffset.x,contentOffset.y);
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    CGPoint contentOffset = _myWebView.scrollView.contentOffset;
    
    DebugLog(@"CGPoint:(%f,%f)",contentOffset.x,contentOffset.y);
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    
    
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    CGPoint contentOffset = _myWebView.scrollView.contentOffset;
    //
    //    DebugLog(@"CGPoint:(%f,%f)",contentOffset.x,contentOffset.y);
    //
    CGFloat offset = scrollView.contentOffset.y;
    
    CGFloat alpha = offset / 180;
    
    if (alpha <= 0.7) {
        topView.alpha = alpha;
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
