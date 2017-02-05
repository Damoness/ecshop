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
@interface MyTabBarViewController ()
{
    UIImageView *customBar; // 定制底部导航栏
    
    UILabel *shoppingCartBadgeLabel;
    UIView *shoppingCartView;
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
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(cartNum:) name:@"cart_num" object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(quite:) name:@"quite" object:nil];
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *tabBarItemFont = data[@"tabBarItemFont"];
    //字体大小
    int tabBarFont = [tabBarItemFont intValue];
    NSString *tabBarBackgroundColor = data[@"tabBarBackgroundColor"];
    NSString *tabBarIitmColorAfter = data[@"tabBarIitmColorAfter"];
    NSString *tabBarIitmColorBefore = data[@"tabBarIitmColorBefore"];
    NSString *tabbar1 = data[@"tabbar1"];
    NSString *tabbar2 = data[@"tabbar2"];
    NSString *tabbar3 = data[@"tabbar3"];
    NSString *tabbar4 = data[@"tabbar4"];
    
    self.tabBar.hidden=YES;
    customBar = [[UIImageView alloc]init];
    //获取屏幕的尺寸
    CGSize size = [UIScreen mainScreen].bounds.size;
    //设置customBar位置和大小，屏幕的最低部
    customBar.frame = CGRectMake(0, size.height - 49, size.width, 49);
//    [customBar setBackgroundColor:[UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0]];
    [customBar setBackgroundColor:[UIColor colorWithHexString:tabBarBackgroundColor]];
    [self.view addSubview:customBar];
    NSArray *arr=@[tabbar1,tabbar2,tabbar3,tabbar4];
    for (int i = 0; i < 4; i++)
    {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(i * size.width/4, 0, size.width/4, 49);
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab%d",i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab%d",i]] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabc%d",i]] forState:UIControlStateSelected];
        //        if (i==3) {
        //            JSBadgeView *badgeView=[[JSBadgeView alloc]initWithParentView:button alignment:JSBadgeViewAlignmentTopRight];
        //           // badgeView.badgeText=_numLab.text;
        //            badgeView.badgeTextColor=[UIColor whiteColor];
        //            badgeView.backgroundColor=[UIColor redColor];
        //            badgeView.badgePositionAdjustment = CGPointMake(-15, 10);
        //            [button addSubview:badgeView];
        //            [customBar sendSubviewToBack:button];
        //        }
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
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:tabBarIitmColorBefore] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:tabBarIitmColorBefore] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithHexString:tabBarIitmColorAfter] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:tabBarFont];
        if (i==2) {
            button.titleEdgeInsets = UIEdgeInsetsMake(35, -25, 0, 5);
            button.imageEdgeInsets = UIEdgeInsetsMake(0,20, 15, -5);
        }
        else if(i==3){
            button.titleEdgeInsets = UIEdgeInsetsMake(35, -22, 0, 5);
            button.imageEdgeInsets = UIEdgeInsetsMake(0,20, 15, 0);
        }else
        {
            button.titleEdgeInsets = UIEdgeInsetsMake(35, -25, 0, 12);
            button.imageEdgeInsets = UIEdgeInsetsMake(0,12, 15, 0);
        }
        button.tag = 100 + i;
        [customBar addSubview:button];
    }
    customBar.userInteractionEnabled = YES;
}
-(void)hiddenTabbar:(BOOL)hiden
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    [UIView animateWithDuration:0.5 animations:^{
        if (hiden) {
            customBar.frame = CGRectMake(0, size.height, size.width, 49);
        }
        else
        {
            customBar.frame = CGRectMake(0, size.height - 49, size.width, 49);
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


-(void)cartNum:(NSNotification *)sender{

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
