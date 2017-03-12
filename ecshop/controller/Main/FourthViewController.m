//
//  FourthViewController.m
//  ecshop
//
//  Created by jsyh-mac on 15/11/30.
//  Copyright © 2015年 jsyh. All rights reserved.
//第四页

#import "FourthViewController.h"
#import "AppDelegate.h"
#import "MineTableViewCell.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "OpinionViewController.h"
#import "Masonry.h"
#import "SettingViewController.h"
#import "MyAccountViewController.h"
#import "MyOrderViewController.h"
#import "AddressViewController.h"
#import "RequestModel.h"
#import "MyAttentionViewController.h"
#import "RechargeViewController.h"
#import "MyTabBarViewController.h"
#import "UIColor+Hex.h"
#import "CouponsViewController.h"
#import "MyRetailViewController.h"
#import "MemberRegisterViewController.h"

//尾视图按钮高度
#define kViewHeight 50
#define kColorBack [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0]
@interface FourthViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UIButton *button1;
    UIButton *button2;
}
@property (nonatomic,strong)UITableView *table;
@property (nonatomic,strong)NSString *mykey;
@property (nonatomic,assign)NSInteger tagg;

@property (nonatomic,strong)UserModel *model;
//关注商品的label
@property (nonatomic,strong)UILabel *labelForGoods1;
//余额
@property (nonatomic,strong)UILabel *labelForBalance1;
//积分
@property (nonatomic,strong)UILabel *labelForIntegration1;
//用户名
@property (nonatomic,strong)UILabel *label1;

//分享豆
@property (nonatomic,strong)UILabel *shareBeanLabel;
//分享劵
@property (nonatomic,strong)UILabel *shareTicketLabel;

//用户身份
@property (nonatomic,strong)UILabel *rankNameLabel;


//登录视图
@property (nonatomic,strong)UIView *loginView;
//用户视图
@property (nonatomic,strong)UIView *userView;

//登录后头像
@property (nonatomic,strong)UIImageView *headView1;
@property (nonatomic,strong)NSString *waitPayNum;//待付款个数
@property (nonatomic,strong)NSString *waitSendNum;//待发货个数
@property (nonatomic,strong)NSString *waitReceiveNum;//待收货个数
@property (nonatomic,strong)NSString *completedNum;//已完成个数


@end

@implementation FourthViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.view.backgroundColor = kColor_UIView_BackgroundColor;
    
    [self configLoginView];
    
    [self configUserView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:NO];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.tempDic = app.tempDic;
    
    if ([LoginModel isLogin]) {

        //登录后
        self.userName = app.userName;
        _loginView.hidden = YES;
        _userView.hidden = NO;
        
        [self myAccount];
        self.tagg = 2;
        [self.table reloadData];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
        NSLog(@"imageFile->>%@",imageFilePath);
        UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//
        if (selfPhoto != nil) {
            _headView1.image = selfPhoto;
            [_headView1.layer setCornerRadius:CGRectGetHeight([_headView1 bounds]) / 2];  //修改半径，实现头像的圆形化
            _headView1.layer.masksToBounds = YES;
        }else{
            UIImage *headImg = [UIImage imageNamed:@"null_head.png"];
            _headView1.image = headImg;
        }
        
    }else{
        
        //未登录
        _loginView.hidden = NO;
        _userView.hidden = YES;
        self.tagg = 1;
        [self.table reloadData];
        
        

    }
    
}

#pragma mark --我关注的商品等请求的数据
-(void)mygoods{
    
}

-(void)change:(id)sender{
    SettingViewController *settingVC = [SettingViewController new];
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    settingVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVC animated:YES];
}
#pragma mark -- 登录后
-(void)configUserView{
    
    
    _userView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _userView.hidden = YES;
    //[self initNavigationBar];
    

    
    //背景图
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, (kScreenHeight/7)*2)];
    imgView.userInteractionEnabled = YES;
    //imgView.image = [UIImage imageNamed:@"会员中心-已登录-背景1.png"];
    imgView.backgroundColor = kColor_NavigationBar_BarTintColor;
    [_userView addSubview:imgView];
    
//    
//    UIButton *settingButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 80, 20, 60, 30)];
//    [settingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [settingButton setTitle:@"设置" forState:UIControlStateNormal];
//    
//    
//    [_userView addSubview:settingButton];
    
    
    //跳转到编辑个人信息
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height - 64);
    [button addTarget:self action:@selector(changeToMine:) forControlEvents:UIControlEventTouchUpInside];
    [_userView addSubview:button];
    
    
    //头像
    _headView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 90,kScreenWidth/5, kScreenWidth/5)];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    NSLog(@"imageFile->>%@",imageFilePath);
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//
    if (selfPhoto != nil) {
        _headView1.image = selfPhoto;
        [_headView1.layer setCornerRadius:CGRectGetHeight([_headView1 bounds]) / 2];  //修改半径，实现头像的圆形化
        _headView1.layer.masksToBounds = YES;
    }else{
        UIImage *headImg = [UIImage imageNamed:@"null_head.png"];
        _headView1.image = headImg;
    }
    [_userView addSubview:_headView1];
    
    
    
    //imgView
    

    
    
    //底部色块

    UIView *backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, imgView.frame.size.height - 40, self.view.frame.size.width, 40)];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    UIImage *backImg = [UIImage imageNamed:@"login_title_foot_bg.png"];
    backImageView.image = backImg;
    [backgroudView addSubview:backImageView];
    [imgView addSubview:backgroudView];
    //关注商品按钮
    UIButton *goodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goodsBtn.frame = CGRectMake(0, imgView.frame.size.height - 40, self.view.frame.size.width/3, 40);
    //关注商品数量
    
    _labelForGoods1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, 20)];
    _labelForGoods1.text = @"0";
    _labelForGoods1.font = [UIFont systemFontOfSize:11];
    _labelForGoods1.textColor = [UIColor whiteColor];
    _labelForGoods1.textAlignment = NSTextAlignmentCenter;
    [goodsBtn addSubview:_labelForGoods1];
    
    
    UILabel *labelForGoods2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width/3, 20)];
    labelForGoods2.text = @"我关注的商品";
    labelForGoods2.font = [UIFont systemFontOfSize:11];
    labelForGoods2.textColor = [UIColor whiteColor];
    labelForGoods2.textAlignment = NSTextAlignmentCenter;
    [goodsBtn addSubview:labelForGoods2];
    [goodsBtn addTarget:self action:@selector(goodsAction:) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:goodsBtn];
    //我的余额按钮
    UIButton *balanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [balanceBtn addTarget:self action:@selector(changeToCharge:) forControlEvents:UIControlEventTouchUpInside];
    
    balanceBtn.frame = CGRectMake(self.view.frame.size.width/3, imgView.frame.size.height - 40, self.view.frame.size.width/3, 40);
    //余额
    
    _labelForBalance1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, 20)];
    _labelForBalance1.text = @"0.00";
    _labelForBalance1.font = [UIFont systemFontOfSize:11];
    _labelForBalance1.textColor = [UIColor whiteColor];
    _labelForBalance1.textAlignment = NSTextAlignmentCenter;
    [balanceBtn addSubview:_labelForBalance1];
    
    
    UILabel *labelForBalance2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width/3, 20)];
    labelForBalance2.text = @"我的余额";
    labelForBalance2.font = [UIFont systemFontOfSize:11];
    labelForBalance2.textColor = [UIColor whiteColor];
    labelForBalance2.textAlignment = NSTextAlignmentCenter;
    [balanceBtn addSubview:labelForBalance2];
    [imgView addSubview:balanceBtn];
    //我的积分按钮
    UIButton *integrationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    integrationBtn.frame = CGRectMake((self.view.frame.size.width/3)*2, imgView.frame.size.height - 40, self.view.frame.size.width/3, 40);
    //积分
    _labelForIntegration1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, 20)];
    _labelForIntegration1.text = @"0";
    _labelForIntegration1.font = [UIFont systemFontOfSize:11];
    _labelForIntegration1.textColor = [UIColor whiteColor];
    _labelForIntegration1.textAlignment = NSTextAlignmentCenter;
    [integrationBtn addSubview:_labelForIntegration1];
    
    UILabel *labelForIntegration2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width/3, 20)];
    labelForIntegration2.text = @"我的积分";
    labelForIntegration2.font = [UIFont systemFontOfSize:11];
    labelForIntegration2.textColor = [UIColor whiteColor];
    labelForIntegration2.textAlignment = NSTextAlignmentCenter;
    [integrationBtn addSubview:labelForIntegration2];
    [imgView addSubview:integrationBtn];
    //线条
    
    UIView *viewLine1 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, imgView.frame.size.height - 35, 1, 30)];
    viewLine1.backgroundColor = [UIColor whiteColor];
    [imgView addSubview:viewLine1];
    
    
    UIView *viewLine2 = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/3)*2, imgView.frame.size.height - 35, 1, 30)];
    viewLine2.backgroundColor = [UIColor whiteColor];
    [imgView addSubview:viewLine2];
    
    
    
    UIView *shareBeanView = ({
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,imgView.frame.size.height - 80 , kScreenWidth/2, 80)];
        
        view.backgroundColor = kColor_NavigationBar_BarTintColor;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/4- 20, 80/2-20, 20, 20)];
        
        
        imageView.image = [UIImage imageNamed:@"mybean"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4 + 5, 80/2 - 20, 80, 20)];
        label.text = @"分享豆";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        
        self.shareBeanLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4 - 80 + 10 , 80/2 + 10, 160, 20)];
        self.shareBeanLabel.text = @"0.0";
        self.shareBeanLabel.textAlignment = NSTextAlignmentCenter;
        self.shareBeanLabel.font = [UIFont systemFontOfSize:16];
        self.shareBeanLabel.textColor = [UIColor whiteColor];
        
        [view addSubview:label];
        [view addSubview:imageView];
        [view addSubview: self.shareBeanLabel];
        
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = [[UIColor grayColor] CGColor];
        
        view;
    });
    

    UIView *shareTicketView = ({
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2,imgView.frame.size.height - 80 , kScreenWidth/2, 80)];
        
        view.backgroundColor = kColor_NavigationBar_BarTintColor;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/4- 20, 80/2-20, 20, 20)];
        
        imageView.image = [UIImage imageNamed:@"voucher"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4 + 5, 80/2 - 20, 80, 20)];
        label.text = @"分享券";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        
        self.shareTicketLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/4 - 80 + 10 , 80/2 + 10, 160, 20)];
        self.shareTicketLabel.text = @"0.0";
        self.shareTicketLabel.textAlignment = NSTextAlignmentCenter;
        self.shareTicketLabel.font = [UIFont systemFontOfSize:16];
        self.shareTicketLabel.textColor = [UIColor whiteColor];
        
        [view addSubview:label];
        [view addSubview:imageView];
        [view addSubview: self.shareTicketLabel];
        
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = [[UIColor grayColor] CGColor];
        
        view;
    });
    
    self.rankNameLabel = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 60, imgView.frame.size.height /2 - 10, 70, 20)];
        
        
        label.text = @"消费者";
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = RGB(179, 56, 11);
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        label;
    
    });
    
        
    [imgView addSubview:shareBeanView];
    [imgView addSubview:shareTicketView];
    [imgView addSubview:self.rankNameLabel];
    
    
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height/7)*2 + 64, self.view.frame.size.width, (self.view.frame.size.height/7)*4 - 44) style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    
    [self setExtraCellLineHidden:_table];
    [_userView addSubview:_table];
    //用户名label
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(20+self.view.frame.size.width/5, 110, self.view.frame.size.width/2, 40)];
    _label1.text = self.userName;
    
    _label1.textColor = [UIColor whiteColor];
    [_userView addSubview:_label1];
    
    [self.view addSubview:_userView];
}
#pragma mark --跳转我关注的商品界面
-(void)goodsAction:(id)sender{
    MyAttentionViewController *myAttentionVC = [MyAttentionViewController new];
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    [self.navigationController pushViewController:myAttentionVC animated:YES];
}
#pragma mark --跳转到充值页面
-(void)changeToCharge:(id)sender{
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    RechargeViewController *reVC = [RechargeViewController new];
    reVC.temp = _labelForBalance1.text;
    [self.navigationController pushViewController:reVC animated:YES];
}
#pragma mark --登录后跳转到个人设置页面
-(void)changeToMine:(id)sender{
    MyAccountViewController *myVC = [MyAccountViewController new];
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    myVC.hidesBottomBarWhenPushed = YES;
    myVC.tempDic = self.tempDic;
    myVC.userName = self.userName;
    [self.navigationController pushViewController:myVC animated:YES];
}

#pragma mark -- 未登录
-(void)configLoginView{
    
    _loginView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _loginView.hidden = NO;
    
    //[self initNavigationBar];
    //背景图
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, (self.view.frame.size.height/7)*2)];
    UIImage *image = [UIImage imageNamed:@"会员中心-未登录-背景.png"];
    imgView.image = image;
    [_loginView addSubview:imgView];
    
    //登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.layer.cornerRadius = 10;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor whiteColor];
    loginBtn.frame = CGRectMake(self.view.frame.size.width/4-10, (imgView.frame.size.height/3)*2 + 64, self.view.frame.size.width/4, imgView.frame.size.height/6);
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(changeToLogin:) forControlEvents:UIControlEventTouchUpInside];
    [_loginView addSubview:loginBtn];
    
    //注册按钮
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.layer.cornerRadius = 10;
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.frame = CGRectMake(self.view.frame.size.width/2+10, (imgView.frame.size.height/3)*2 +64, self.view.frame.size.width/4, imgView.frame.size.height/6);
    registerBtn.backgroundColor = [UIColor whiteColor];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(changeToRegister:) forControlEvents:UIControlEventTouchUpInside];
    [_loginView addSubview:registerBtn];
    
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height/7)*2 + 64, self.view.frame.size.width, (self.view.frame.size.height/7)*6 - 110) style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    
    
    [_loginView addSubview:_table];
    //label1
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x - 70,  30, self.view.frame.size.width/2, imgView.frame.size.height/7)];
    label1.text = @"您当前还没有登录？";
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor whiteColor];
    [imgView addSubview:label1];
    
    //label2
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x - 70,  50 , self.view.frame.size.width/2, imgView.frame.size.height/7)];
    label2.text = @"马上登录吧!";
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = [UIColor whiteColor];
    [imgView addSubview:label2];
    [self.view addSubview:_loginView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changeToLogin:(id)sender{
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)changeToRegister:(id)sender{
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
#pragma mark tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.tagg == 1) {
        return 3;
    }else{
        return 6;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    if (section == 0) {
        
        UIView *view11 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        view11.backgroundColor = [UIColor whiteColor];
        //button1
        button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button1.frame = CGRectMake(0, 0, self.view.frame.size.width/4, kViewHeight);
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIImageView *imgView1 = [[UIImageView alloc]init];
        imgView1.frame = CGRectMake((button1.frame.size.width/2)-13, 5, 26, 24);
        UIImage *img1 = [UIImage imageNamed:@"个人中心-我的订单-待付款icon.png"];
        imgView1.image = img1;
        
        
        [button1 addSubview:imgView1];
        UILabel *label1 = [[UILabel alloc]init];
        label1.frame = CGRectMake(0, 30, self.view.frame.size.width/4, kViewHeight-30);
        label1.text = @"待付款";
        label1.font = [UIFont systemFontOfSize:11];
        label1.textAlignment = NSTextAlignmentCenter;
        [button1 addSubview:label1];
        [button1 addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [view11 addSubview:button1];
        //button2
        button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button2.frame = CGRectMake(self.view.frame.size.width/4, 0, self.view.frame.size.width/4, kViewHeight);
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIImageView *imgView2 = [[UIImageView alloc]init];
        imgView2.frame = CGRectMake((button1.frame.size.width/2)-13, 5, 26, 24);
        UIImage *img2 = [UIImage imageNamed:@"个人中心-我的订单-待发货icon.png"];
        imgView2.image = img2;
        [button2 addSubview:imgView2];
        UILabel *label2 = [[UILabel alloc]init];
        label2.frame = CGRectMake(0, 30, self.view.frame.size.width/4, kViewHeight-30);
        label2.text = @"待发货";
        label2.font = [UIFont systemFontOfSize:11];
        label2.textAlignment = NSTextAlignmentCenter;
        [button2 addSubview:label2];
        [button2 addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view11 addSubview:button2];
        //button3
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button3.frame = CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/4, kViewHeight);
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIImageView *imgView3 = [[UIImageView alloc]init];
        imgView3.frame = CGRectMake((button1.frame.size.width/2)-13, 5, 26, 24);
        UIImage *img3 = [UIImage imageNamed:@"个人中心-我的订单-待收货icon.png"];
        imgView3.image = img3;
        [button3 addSubview:imgView3];
        UILabel *label3 = [[UILabel alloc]init];
        label3.frame = CGRectMake(0, 30, self.view.frame.size.width/4, kViewHeight-30);
        label3.text = @"待收货";
        label3.font = [UIFont systemFontOfSize:11];
        label3.textAlignment = NSTextAlignmentCenter;
        [button3 addSubview:label3];
        [button3 addTarget:self action:@selector(receivedAction:) forControlEvents:UIControlEventTouchUpInside];
        [view11 addSubview:button3];
        //button4
        UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button4.frame = CGRectMake((self.view.frame.size.width/4)*3, 0, self.view.frame.size.width/4, kViewHeight);
        [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIImageView *imgView4 = [[UIImageView alloc]init];
        imgView4.frame = CGRectMake((button1.frame.size.width/2)-13, 5, 26, 24);
        UIImage *img4 = [UIImage imageNamed:@"个人中心-我的订单-售后icon.png"];
        imgView4.image = img4;
        [button4 addSubview:imgView4];
        UILabel *label4 = [[UILabel alloc]init];
        label4.frame = CGRectMake(0, 30, self.view.frame.size.width/4, kViewHeight-30);
        label4.text = @"已完成";
        label4.font = [UIFont systemFontOfSize:11];
        label4.textAlignment = NSTextAlignmentCenter;
        [button4 addSubview:label4];
        [button4 addTarget:self action:@selector(customerAction:) forControlEvents:UIControlEventTouchUpInside];
        [view11 addSubview:button4];
        //线条
        UIView *viewLine1 = [[UIView alloc]init];
        viewLine1.frame = CGRectMake(0, 0, self.view.frame.size.width, 1);
        viewLine1.backgroundColor = kColorBack;
        [view11 addSubview:viewLine1];
        //
        UIView *viewLine2 = [[UIView alloc]init];
        viewLine2.frame = CGRectMake(self.view.frame.size.width/4, 0, 1, kViewHeight);
        viewLine2.backgroundColor = kColorBack;
        [view11 addSubview:viewLine2];
        //
        UIView *viewLine3 = [[UIView alloc]init];
        viewLine3.frame = CGRectMake(self.view.frame.size.width/2, 0, 1,  kViewHeight);
        viewLine3.backgroundColor = kColorBack;
        [view11 addSubview:viewLine3];
        //
        UIView *viewLine4 = [[UIView alloc]init];
        viewLine4.frame = CGRectMake((self.view.frame.size.width/4)*3, 0, 1, kViewHeight);
        viewLine4.backgroundColor = kColorBack;
        [view11 addSubview:viewLine4];
        //
        UIView *viewLine5 = [[UIView alloc]init];
        
        viewLine5.backgroundColor = kColorBack;
        [view11 addSubview:viewLine5];
        [viewLine5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
            make.top.equalTo(view11).with.offset(kViewHeight);
            make.left.equalTo(view11).with.offset(0);
        }];
        return view11;
    }else{
        return nil;
    }
}
//待付款
-(void)payAction:(id)sender{
    NSLog(@"待付款");
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    if (self.tagg == 1) {
        LoginViewController *registerVC = [LoginViewController new];
        [self.navigationController pushViewController:registerVC animated:YES];
    }else if(self.tagg == 2){
        MyOrderViewController *myVC = [MyOrderViewController new];
        myVC.tagg = @"1";
        [self.navigationController pushViewController:myVC animated:YES];
    }
    
}
//待发货
-(void)sendAction:(id)sender{
    NSLog(@"待发货");
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    if (self.tagg == 1) {
        LoginViewController *registerVC = [LoginViewController new];
        [self.navigationController pushViewController:registerVC animated:YES];
    }else if (self.tagg == 2){
        MyOrderViewController *myVC = [MyOrderViewController new];
        myVC.tagg = @"3";
        [self.navigationController pushViewController:myVC animated:YES];
    }
}
//待收货
-(void)receivedAction:(id)sender{
    NSLog(@"待收货");
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    if (self.tagg == 1) {
        LoginViewController *registerVC = [LoginViewController new];
        [self.navigationController pushViewController:registerVC animated:YES];
    }else if (self.tagg == 2){
        MyOrderViewController *myVC = [MyOrderViewController new];
        myVC.tagg = @"4";
        [self.navigationController pushViewController:myVC animated:YES];
    }
}
//已完成
-(void)customerAction:(id)sender{
    NSLog(@"售后");
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    if (self.tagg == 1) {
        LoginViewController *registerVC = [LoginViewController new];
        [self.navigationController pushViewController:registerVC animated:YES];
    }else if (self.tagg == 2){
        MyOrderViewController *myVC = [MyOrderViewController new];
        myVC.tagg = @"5";
        [self.navigationController pushViewController:myVC animated:YES];
    }
}
//尾视图大小
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }else{
        return 1;
    }
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.00001;
    }else if (section == 1) {
        return 10;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
#pragma mark --未登录的tableview
    if (self.tagg == 1) {
        static NSString *string = @"cell";
        MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MineTableViewCell" owner:self options:nil]lastObject];
        }
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.lab.text = @"我的订单";
                cell.img.image = [UIImage imageNamed:@"个人中心-我的订单icon.png"];
            }
            
        }else if(indexPath.section == 1){
            cell.lab.text = @"地址管理";
            cell.img.image = [UIImage imageNamed:@"个人中心-地址管理icon.png"];
        }else if(indexPath.section == 2){
            cell.lab.text = @"我的红包";
            cell.img.image = [UIImage imageNamed:@"huiyuanzhongxin_hongbao"];
        }
        return cell;
    }
#pragma mark --登陆后的tableview
    else if(self.tagg == 2){
        static NSString *string = @"cell";
        MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MineTableViewCell" owner:self options:nil]lastObject];
        }
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.lab.text = @"我的订单";
                //cell.img.image = [UIImage imageNamed:@"个人中心-我的订单icon.png"];
            }
            
        }else if(indexPath.section == 1){
            cell.lab.text = @"我的分享";
            cell.myRightLabel.text = @"查看分享信息";
            cell.img.image = [UIImage imageNamed:@"myshare"];
        }else if(indexPath.section == 2){
            cell.lab.text = @"评价/晒单";
            cell.myRightLabel.text = @"查看评价/晒单";
            cell.img.image = [UIImage imageNamed:@"myevaluate"];
        }else if(indexPath.section == 3){
            cell.lab.text = @"我的收藏";
            cell.myRightLabel.text = @"商品收藏/店铺收藏";
            cell.img.image = [UIImage imageNamed:@"mycollect"];
        }else if(indexPath.section == 4){
            cell.lab.text = @"收货地址";
            cell.myRightLabel.text = @"添加/修改";
            cell.img.image = [UIImage imageNamed:@"mylocation"];
        }else if(indexPath.section == 5){
            
            //cell.focusStyle = UITableViewCellFocusStyleDefault;
            //[cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.lab.text = @"退出";
            cell.myRightLabel.text = @"退出用户登录";
            cell.img.image = [UIImage imageNamed:@"个人中心-退出icon.png"];

        }
        return cell;
    }else{
        return nil;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
#pragma mark --未登录选择cell
    if (self.tagg == 1) {
        if (indexPath.section == 0) {
            LoginViewController *registerVC = [LoginViewController new];
            registerVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:registerVC animated:YES];
        }else if (indexPath.section == 3){
            OpinionViewController *opinVC = [OpinionViewController new];
            opinVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:opinVC animated:YES];
        }else if (indexPath.section == 2){
            LoginViewController *registerVC = [LoginViewController new];
            registerVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:registerVC animated:YES];

        }
        else if(indexPath.section == 1){
            LoginViewController *registerVC = [LoginViewController new];
            registerVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:registerVC animated:YES];
            //[tabbar hideCustomTabbar:NO];
        }
        
    }
#pragma mark --登陆后选择cell
    else if (self.tagg == 2){
        if (indexPath.section == 0) {
            //我的订单
            MyOrderViewController *myVC = [MyOrderViewController new];
            myVC.tagg = @"0";
        
            myVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myVC animated:YES];
        }else if(indexPath.section == 1){//我的分享
    
            MemberRegisterViewController *mrVC = [MemberRegisterViewController new];
            mrVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:mrVC animated:YES];
            
            
        }
        else if (indexPath.section == 2){//评价/晒单
//            //红包
//            CouponsViewController *myHBVC = [[CouponsViewController alloc]init];
//            [self.navigationController pushViewController:myHBVC animated:YES];
            
            UIViewController *vc = [UIViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.section == 3){//我的收藏
      
            
        }else if(indexPath.section == 4){//收货地址
            //cell.lab.text = @"分销";
//            CouponsViewController *myHBVC = [[CouponsViewController alloc]init];
//            [self.navigationController pushViewController:myHBVC animated:YES];
            
//            MyRetailViewController *myRetailVC = [[MyRetailViewController alloc]init];
//            
//            [self presentViewController:myRetailVC animated:YES completion:nil];
            
            //地址管理
            AddressViewController *addressVC = [AddressViewController new];
            addressVC.tempDic = self.tempDic;
            addressVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addressVC animated:YES];
            
            
        }else if(indexPath.section == 5){//退出
        
            //退出
            __weak typeof(self) weakSelf = self;
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"您确定要退出吗？"preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#pragma mark --注册通知各页已经退出
                
                [LoginModel doLogout];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"quite" object:nil];
                weakSelf.loginView.hidden = NO;
                weakSelf.userView.hidden = YES;
                MyTabBarViewController * tabbar =(MyTabBarViewController *)weakSelf.navigationController.tabBarController;
                [tabbar hideCustomTabbar:NO];
                weakSelf.tagg = 1;
                [weakSelf.table reloadData];
                
                
                
            }];
            [alertVC addAction:cancelAction];
            [alertVC addAction:okAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark--我的资料数据请求
-(void)myAccount{

    WS(ws);
    UserModel *userModel  = [UserModel new];
    
    [[Ditiy_NetAPIManager sharedManager]request_UserInfo_WithParams:[userModel toUserInfoParams] andBlock:^(id data, NSError *error) {
        
        if (data) {
            
            ws.model = [UserModel mj_objectWithKeyValues:data[@"data"][0]];
            
            
            ws.labelForGoods1.text = ws.model.attention;
            ws.labelForBalance1.text = ws.model.user_money;
            ws.labelForIntegration1.text = ws.model.integration;
            ws.label1.text = ws.model.nick_name;
            
            ws.shareTicketLabel.text = ws.model.integration;
            ws.shareBeanLabel.text = ws.model.user_money;
            ws.rankNameLabel.text = ws.model.rank_name;
            
            NSString *a = [NSString stringWithFormat:@"%@",ws.model.pay];
            NSString *b = [NSString stringWithFormat:@"%@",ws.model.shipping_send];
            
            
            if ([a isEqualToString:@"0"]) {
                
            }else{
                
                UIView *smallView1 = [[UIView alloc]initWithFrame:CGRectMake(button1.frame.size.width - 15, 3, 12, 12)];
                smallView1.backgroundColor = [UIColor redColor];
                [smallView1.layer setCornerRadius:6];
                UILabel *smallLab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
                smallLab1.font = [UIFont systemFontOfSize:8];
                smallLab1.text = a;
                smallLab1.textAlignment = NSTextAlignmentCenter;
                smallLab1.textColor = [UIColor whiteColor];
                [smallView1 addSubview:smallLab1];
                [button1 addSubview:smallView1];
                
                
            }
            if ([b isEqualToString:@"0"]) {
                
            }else{
                
                UIView *smallView2 = [[UIView alloc]initWithFrame:CGRectMake(button2.frame.size.width - 15, 3, 12, 12)];
                smallView2.backgroundColor = [UIColor redColor];
                [smallView2.layer setCornerRadius:6];
                UILabel *smallLab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
                smallLab2.font = [UIFont systemFontOfSize:8];
                smallLab2.text = b;
                smallLab2.textAlignment = NSTextAlignmentCenter;
                smallLab2.textColor = [UIColor whiteColor];
                [smallView2 addSubview:smallLab2];
                [button2 addSubview:smallView2];
            }
            NSString *c = [NSString stringWithFormat:@"%@",ws.model.cart_num];
            
            NSDictionary *dicc = [[NSDictionary alloc]init];
            dicc = @{@"cart_num":c};
#pragma mark -- 发送购物车数量通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_ShoppingCart_No object:dicc];
            
            
        }
        
    }];
    
//    
//    [RequestModel requestWithDictionary:dict model:@"user" action:@"userinfo" block:^(id result) {
//        NSDictionary *dic = result;
//        for (NSMutableDictionary *dict in dic[@"data"]) {
//            weakSelf.model = [PersonalInfoModel new];
//            
//            weakSelf.model.user_id = dict[@"user_id"];//缺少
//            weakSelf.model.nick_name = dict[@"nick_name"];
//            weakSelf.model.sex = dict[@"sex"];
//            weakSelf.model.address = dict[@"address"];
//            weakSelf.model.mobile = dict[@"mobile"];
//            weakSelf.model.integration = dict[@"integration"];
//            weakSelf.model.attention = dict[@"attention"];
//            weakSelf.model.user_money = dict[@"user_money"];
//            weakSelf.model.pay = dict[@"pay"];
//            weakSelf.model.shipping_send = dict[@"shipping_send"];
//            weakSelf.model.cart_num = dict[@"cart_num"];
//            weakSelf.labelForGoods1.text = weakSelf.model.attention;
//            weakSelf.labelForBalance1.text = weakSelf.model.user_money;
//            weakSelf.labelForIntegration1.text = weakSelf.model.integration;
//            weakSelf.label1.text = weakSelf.model.nick_name;
//            NSString *a = [NSString stringWithFormat:@"%@",dict[@"pay"]];
//            NSString *b = [NSString stringWithFormat:@"%@",dict[@"shipping_send"]];
//            
//            
//            if ([a isEqualToString:@"0"]) {
//                
//            }else{
//                
//                UIView *smallView1 = [[UIView alloc]initWithFrame:CGRectMake(button1.frame.size.width - 15, 3, 12, 12)];
//                smallView1.backgroundColor = [UIColor redColor];
//                [smallView1.layer setCornerRadius:6];
//                UILabel *smallLab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
//                smallLab1.font = [UIFont systemFontOfSize:8];
//                smallLab1.text = a;
//                smallLab1.textAlignment = NSTextAlignmentCenter;
//                smallLab1.textColor = [UIColor whiteColor];
//                [smallView1 addSubview:smallLab1];
//                [button1 addSubview:smallView1];
//                
//                
//            }
//            if ([b isEqualToString:@"0"]) {
//                
//            }else{
//                
//                UIView *smallView2 = [[UIView alloc]initWithFrame:CGRectMake(button2.frame.size.width - 15, 3, 12, 12)];
//                smallView2.backgroundColor = [UIColor redColor];
//                [smallView2.layer setCornerRadius:6];
//                UILabel *smallLab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
//                smallLab2.font = [UIFont systemFontOfSize:8];
//                smallLab2.text = b;
//                smallLab2.textAlignment = NSTextAlignmentCenter;
//                smallLab2.textColor = [UIColor whiteColor];
//                [smallView2 addSubview:smallLab2];
//                [button2 addSubview:smallView2];
//            }
//            NSString *c = [NSString stringWithFormat:@"%@",dict[@"cart_num"]];
//            NSDictionary *dicc = [[NSDictionary alloc]init];
//            dicc = @{@"cart_num":c};
//#pragma mark -- 发送购物车数量通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"cart_num" object:dicc];
//            
//        }
//        
//        
//    }];
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}
#pragma mark -- 自定义导航栏
- (void)initNavigationBar{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *naviBGColor = data[@"navigationBGColor"];
    NSString *tabbar = data[@"tabbar4"];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor colorWithHexString:naviBGColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, self.view.frame.size.width - 200, 44)];
    label.text = tabbar;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17];
    [view addSubview:label];
    
    UIImage *img = [UIImage imageNamed:@"个人中心-标题栏-设置icon.png"];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 40, 30, 30, 30)];
    [btn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [view addSubview:btn];
    
    [self.loginView addSubview:view];
    [self.userView addSubview:view];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cart_num" object:nil];
    
}


@end
