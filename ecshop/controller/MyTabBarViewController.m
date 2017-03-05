//
//  MyTabBarViewController.m
//  ecshop
//
//  Created by jsyh-mac on 15/11/30.
//  Copyright © 2015年 jsyh. All rights reserved.
//自定义tabbar

#import "MyTabBarViewController.h"
#import "UIColor+Hex.h"
#import "UserGuideViewController.h"
#import "AppDelegate.h"
#import "UIButton+Common.h"
#import "CustomButton.h"
@interface MyTabBarViewController ()
{
    UIImageView *customBar; // 定制底部导航栏
    
    
    
    UILabel *shoppingCartBadgeLabel;
    UIView *shoppingCartView; //
}
@end

@implementation MyTabBarViewController
-(void)setIntroductionView
{
    
    UserGuideViewController *userVC = [[UserGuideViewController alloc]init];
    [self addChildViewController:userVC];
    [self.view addSubview:userVC.view];
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [viewController viewWillAppear:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.tabBarController.selectedViewController viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
#pragma mark -- 引导页
//    [self setIntroductionView];
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            [self setIntroductionView];
    
            //启动引导页
        }else{
            //不是第一次启动的话
            
        }
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];

}
-(void)initViews
{
    
#pragma mark --接收登录通知
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(setShoppingCartLabelNo:) name:kNotification_ShoppingCart_No object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(quite:) name:@"quite" object:nil];
//
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
//    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    NSString *tabBarItemFont = data[@"tabBarItemFont"];
//    //字体大小
//    int tabBarFont = [tabBarItemFont intValue];
//    NSString *tabBarBackgroundColor = data[@"tabBarBackgroundColor"];
//    NSString *tabBarIitmColorAfter = data[@"tabBarIitmColorAfter"];
//    NSString *tabBarIitmColorBefore = data[@"tabBarIitmColorBefore"];
//    NSString *tabbar1 = data[@"tabbar1"];
//    NSString *tabbar2 = data[@"tabbar2"];
//    NSString *tabbar3 = data[@"tabbar3"];
//    NSString *tabbar4 = data[@"tabbar4"];
    
    
    
    
    self.tabBar.hidden=YES;
    customBar = [[UIImageView alloc]init];
    //设置customBar位置和大小，屏幕的最低部
    customBar.frame = CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49);
    [customBar setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:customBar];
    NSArray *arr=@[@{
                       @"title":@"首页",
                       @"normalImageName":@"tab_home_gray",
                       @"selectedImageName":@"tab_home"
                       },
                   @{
                       @"title":@"分类",
                       @"normalImageName":@"tab_classification_gray",
                       @"selectedImageName":@"tab_classification"
                       },
                   @{
                       @"title":@"购物车",
                       @"normalImageName":@"tab_shopping_gray",
                       @"selectedImageName":@"tab_shopping"
                       },
                   @{
                       @"title":@"我的",
                       @"normalImageName":@"tab_user_gray",
                       @"selectedImageName":@"tab_user"
                       }];
    
    
    for (int i = 0; i < 4; i++)
    {
        UIButton *button = [[UIButton alloc]init];
        
//        if (i == 1) {
//            button = [CustomButton new];
//        }
        
        button.frame = CGRectMake(i * kScreenWidth/4, 0, kScreenWidth/4, 49);
        [button setImage:[UIImage imageNamed:arr[i][@"normalImageName"]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:arr[i][@"normalImageName"]] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:arr[i][@"selectedImageName"]] forState:UIControlStateSelected];

        
        if (i == 2) { //购物车视图
            shoppingCartView = [[UIView alloc]initWithFrame:CGRectMake(button.frame.size.width - 35, 3, 12, 12)];
            shoppingCartView.backgroundColor = [UIColor redColor];
            [shoppingCartView.layer setCornerRadius:6];
            shoppingCartBadgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
            shoppingCartBadgeLabel.font = [UIFont systemFontOfSize:8];
            shoppingCartBadgeLabel.text = @"12";
            shoppingCartBadgeLabel.textAlignment = NSTextAlignmentCenter;
            shoppingCartBadgeLabel.textColor = [UIColor whiteColor];
            [shoppingCartView addSubview:shoppingCartBadgeLabel];
            [button addSubview:shoppingCartView];
            
            shoppingCartView.hidden = YES;
            
        }
        [button setTitle:arr[i][@"title"] forState:UIControlStateNormal];
        [button setTitleColor:RGB(156, 156, 156) forState:UIControlStateNormal];
        [button setTitleColor:RGB(156, 156, 156) forState:UIControlStateHighlighted];
        [button setTitleColor:RGB(230, 37, 137) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        
        
        //button.titleEdgeInsets = UIEdgeInsetsMake(35, 0, 0, 0);
//        button.imageEdgeInsets = UIEdgeInsetsMake(0,20, 15, -5);
        

        [button verticalImageAndTitle:5];

//        if (i ==0 || i ==2) {
//            button.backgroundColor = [UIColor blueColor];
//        }
//        
//        button.titleLabel.backgroundColor = [UIColor greenColor];
        
//        if (i==2) {
//            button.titleEdgeInsets = UIEdgeInsetsMake(35, -25, 0, 5);
//            button.imageEdgeInsets = UIEdgeInsetsMake(0,20, 15, -5);
//        }
//        else if(i==3){
//            button.titleEdgeInsets = UIEdgeInsetsMake(35, -22, 0, 5);
//            button.imageEdgeInsets = UIEdgeInsetsMake(0,20, 15, 0);
//        }else
//        {
//            button.titleEdgeInsets = UIEdgeInsetsMake(35, -25, 0, 12);
//            button.imageEdgeInsets = UIEdgeInsetsMake(0,12, 15, 0);
//        }
        button.tag = 100 + i;
        [customBar addSubview:button];
    }
    customBar.userInteractionEnabled = YES;
}
-(void)hideCustomTabbar:(BOOL)hiden
{
    [UIView animateWithDuration:0.5 animations:^{
        if (hiden) {
            customBar.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 49);
            
        }
        else
        {
            customBar.frame = CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49);
        }
    }];
    
}
-(void)buttonClicked:(UIButton *)button
{
    for(int i = 0; i < 4; i++)
    {
        UIButton *btn = (id)[self.view viewWithTag:100 + i];
        if (btn != button) {
            btn.selected = NO;
        }
        
    }
    UIButton * tabBarBtn = [customBar viewWithTag:button.tag];
    tabBarBtn.selected = YES;
    self.selectedIndex = button.tag - 100;
    
}





- (void)dealloc {
    NSLog(@"%@ --%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置购物车图片数量
-(void)setShoppingCartLabelNo:(NSNotification *)sender{

    NSDictionary *dic = sender.object;
    shoppingCartBadgeLabel.text = dic[@"cart_num"];
    if ([LoginModel isLogin]) {
        shoppingCartView.hidden = NO;
    }else{
        shoppingCartView.hidden = YES;
    }
}
-(void)quite:(NSNotification *)sender{
  
    shoppingCartView.hidden = YES;
    
}
@end
