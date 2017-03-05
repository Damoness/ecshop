//
//  ThirdViewController.m
//  ecshop
//
//  Created by jsyh-mac on 15/11/30.
//  Copyright © 2015年 jsyh. All rights reserved.
//第三页

#import "ThirdViewController.h"
#import "RequestModel.h"
#import "AppDelegate.h"
#import "MyGoodsViewCell.h"
#import "LoginViewController.h"
#import "OrderConfirmController.h"
#import "MyTabBarViewController.h"
#import "GoodsDetailViewController.h"
#import "MyAttentionViewController.h"
#import "SDRefresh.h"
#import "UIColor+Hex.h"
#import "AFNetworkReachabilityManager.h"
#import "ShoppingCartModel.h"
#import "ShoppingCartGoodsModel.h"
#define kViewColor [UIColor colorWithRed:1.0 green:1.0 blue:242/255.0 alpha:1.0]
@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource,SDRefreshViewAnimationDelegate>
{
    int ss;
    UIView *viewbuy;
    UIButton *btn1;//左上角返回按钮登录前
    UIButton *btn2;//左上角返回按钮登录后
}
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray<ShoppingCartGoodsModel *> *goodsModelArray;
@property (nonatomic,strong)ShoppingCartGoodsModel *model;
//判断全选按钮的状态
@property (nonatomic,assign)int tagg;
//删除判断全选按钮的状态
@property (nonatomic,assign)int tagg1;
@property (nonatomic,strong)UIButton *changeBtn;


//去结算
@property (nonatomic,strong)UILabel *labNumber;
@property (nonatomic,strong)UIButton *settleButton;



//编辑的view
@property (nonatomic,strong)UIView *editView;
//把选中的商品id放到数组
@property (nonatomic,strong) NSMutableArray *goodsArr;
//商品id的字符串
@property (nonatomic,strong)NSString *goodsIdStr;
//全选删除按钮
@property (nonatomic,strong)UIButton *changeAllBtn;
//结算的商品
@property (nonatomic,strong)NSMutableArray *orderArray;


//刷新
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (nonatomic, assign) NSInteger totalRowCount;
@property (nonatomic, weak) UIImageView *animationView;
@property (nonatomic, weak) UIImageView *boxView;
@property (nonatomic, weak) UILabel *label;
//编辑按钮
@property (nonatomic, strong)UIButton *rightBtn;



@property (nonatomic,strong)UIView *loginView;//登录前页面
@property (nonatomic,strong)UIView *shoppingCartView;//登录后页面
//结算的视图
@property (nonatomic,strong)UIView *settleView;

//合计 (优惠后的结果)
@property (nonatomic,strong)UILabel *amountLabel;

//总额
@property (nonatomic,strong)UILabel *sumLabel;

@end

@implementation ThirdViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:NO];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configLoginView];
    [self configShoppingCartView];
    [self setupHeader];
    [self setupFooter];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if ([self.temp isEqualToString:@"1"]) {

        btn1.hidden = NO;
        btn2.hidden = NO;
        MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
        
        [tabbar hideCustomTabbar:YES];
    }else{
        
        btn1.hidden = YES;
        btn2.hidden = YES;
        MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
        [tabbar hideCustomTabbar:NO];
    }
    
    _goodsArr = [[NSMutableArray alloc]init];
    _orderArray = [[NSMutableArray alloc]init];
    if (![LoginModel isLogin]) {
        
        _shoppingCartView.hidden = YES;
        _loginView.hidden = NO;
        
        
        [self.tableView reloadData];
    }else{
        _labNumber.text = @"去结算";
        _sumLabel.text = @"总额：￥0";
        _amountLabel.text = @"合计：￥0";
        
        [self myGoods];
    }
}

#pragma mark -- 登录视图
-(void)configLoginView{
    _loginView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self initNavigationBar];
    _loginView.hidden = NO;
    
    viewbuy = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 80)];
        view.hidden = NO;
        view.backgroundColor = kViewColor;
        
        //view上的登录按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 25, view.frame.size.width/4 - 20, 30) ;
        [button setTitle:@"登录" forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button.layer setBorderWidth:0.5];
        [button.layer setCornerRadius:8.0]; //设置矩圆角半径
        [button.layer setMasksToBounds:YES];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goTologinVC) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        
        //view上的文字
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20+view.frame.size.width/4, 0, (view.frame.size.width/4)*3 - 20, 80)];
        label.text = @"您可以在登录后同步电脑与手机购物车中的商品";
        label.font = [UIFont systemFontOfSize:15];
        //自动折行设置
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.numberOfLines = 0;
        [view addSubview:label];
        
        
        view;
    });
    

    [_loginView addSubview:viewbuy];
    
    //看看关注
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x-30, 200, 60, 60)];
    imgView.image = [UIImage imageNamed:@"cart_goods_empty.jpg"];
    [_loginView addSubview:imgView];
    //购物车肚子空空
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"购物车肚子空空";
    label1.frame = CGRectMake(self.view.center.x - 60, imgView.frame.origin.y + imgView.frame.size.height + 5, 120, 30) ;
    label1.textAlignment = NSTextAlignmentCenter;//居中
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor grayColor];
    [_loginView addSubview:label1];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"看看关注" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    [button1.layer setBorderWidth:0.5];
    [button1.layer setCornerRadius:8.0];
    [button1 addTarget:self action:@selector(goToMyAttentionVC) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(self.view.center.x - 40, label1.frame.origin.y + label1.frame.size.height + 10, 80, 35) ;
    [button1.layer setMasksToBounds:YES];
    [_loginView addSubview:button1];
    [self.view addSubview:_loginView];
}

//进入关注VC
-(void)goToMyAttentionVC{
    
    if ([LoginModel isLogin]) {
        
        MyAttentionViewController *myAttentionVC = [MyAttentionViewController new];
        [self.navigationController pushViewController:myAttentionVC animated:YES];
        
    }else{

        [self goTologinVC];
        
    }
    
}


//进入登录VC
-(void)goTologinVC{
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
    
}
#pragma mark -- 登录后的
-(void)configShoppingCartView{
    _shoppingCartView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self initNavigationBar];
    _shoppingCartView.hidden = YES;
    
    if ([self.temp isEqualToString:@"1"]) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 116) style:UITableViewStylePlain];
    }else{
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 160) style:UITableViewStylePlain];
    }
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_tableView setTableFooterView:view];
    [_shoppingCartView addSubview:_tableView];
    //结算的view
    if ([self.temp isEqualToString:@"1"]){
        _settleView = [[UIView alloc]initWithFrame:CGRectMake(0, _tableView.frame.size.height + 64, self.view.frame.size.width, 52)];
    }else{
        _settleView = [[UIView alloc]initWithFrame:CGRectMake(0, _tableView.frame.size.height + 64, self.view.frame.size.width, 52)];
    }
    
    _settleView.backgroundColor = [UIColor redColor];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (_settleView.frame.size.width/3)*2, _settleView.frame.size.height)];
    view1.backgroundColor = [UIColor darkGrayColor];
    //全选按钮
    _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _changeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _changeBtn.frame = CGRectMake(0, 0, 80, view1.frame.size.height);
    [_changeBtn setTitle:@"全选" forState:UIControlStateNormal];
    [_changeBtn setImage:[UIImage imageNamed:@"select_cart_goods2.png"] forState:UIControlStateNormal];
    _tagg = 1;
    [_changeBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:_changeBtn];
    //合计
    _amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, view1.frame.size.width - 90, view1.frame.size.height/2)];
    _amountLabel.textColor = [UIColor whiteColor];
    _amountLabel.text = @"合计：￥0";
    _amountLabel.font = [UIFont systemFontOfSize:14];
    [view1 addSubview:_amountLabel];
    //总额
    _sumLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, view1.frame.size.height/2, view1.frame.size.width - 90, view1.frame.size.height/2)];
    _sumLabel.textColor = [UIColor whiteColor];
    _sumLabel.text = @"总额：￥0";
    
    _sumLabel.font = [UIFont systemFontOfSize:9];
    [view1 addSubview:_sumLabel];
    //去结算
    _labNumber = [[UILabel alloc]initWithFrame:CGRectMake((_settleView.frame.size.width/3)*2, 0, _settleView.frame.size.width/3, _settleView.frame.size.height)];
    _labNumber.text = @"去结算";
    
    _labNumber.textAlignment = NSTextAlignmentCenter;
    _labNumber.textColor = [UIColor whiteColor];
    [_settleView addSubview:_labNumber];
    [_settleView addSubview:view1];
    //去结算按钮
    _settleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _settleButton.frame = CGRectMake((_settleView.frame.size.width/3)*2, 20, _settleView.frame.size.width/3, 40);
    _settleButton.backgroundColor = [UIColor clearColor];
    [_settleButton addTarget:self action:@selector(changeToOrder:) forControlEvents:UIControlEventTouchUpInside];
    [_settleView addSubview:_settleButton];
    [_shoppingCartView addSubview:_settleView];
    
    //编辑的view
    if ([self.temp isEqualToString:@"1"]){
        _editView = [[UIView alloc]initWithFrame:CGRectMake(0, _tableView.frame.size.height + 64, self.view.frame.size.width, self.view.frame.size.height - _tableView.frame.size.height - 64)];
    }else{
        _editView = [[UIView alloc]initWithFrame:CGRectMake(0, _tableView.frame.size.height + 64, self.view.frame.size.width, self.view.frame.size.height - _tableView.frame.size.height - 108)];
    }
    
    _editView.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
    //全选按钮
    _changeAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _changeAllBtn.frame = CGRectMake(0, 0, 80, _editView.frame.size.height);
    _changeAllBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [_changeAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [_changeAllBtn setImage:[UIImage imageNamed:@"select_cart_goods2.png"] forState:UIControlStateNormal];
    _tagg1 = 1;
    [_changeAllBtn addTarget:self action:@selector(changeAll:) forControlEvents:UIControlEventTouchUpInside];
    [_editView addSubview:_changeAllBtn];
    //移入关注
    UIButton *attentionBtn = [[UIButton alloc]initWithFrame:CGRectMake(_settleView.frame.size.width/3+10, 10, _settleView.frame.size.width/3-20, 30)];
    attentionBtn.hidden = YES;
    [attentionBtn setTitle:@"移入关注" forState:UIControlStateNormal];
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [attentionBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
    [attentionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [attentionBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    
    [attentionBtn.layer setCornerRadius:8];
    
    [attentionBtn.layer setBorderWidth:0.5];//设置边界的宽度
    [_editView addSubview:attentionBtn];
    //删除
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake((_settleView.frame.size.width/3)*2+10, 10, _settleView.frame.size.width/3-20, 30)];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [deleteBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn.layer setCornerRadius:8];
    
    [deleteBtn.layer setBorderWidth:0.5];//设置边界的宽度
    [_editView addSubview:deleteBtn];
    _editView.hidden = YES;
    [_shoppingCartView addSubview:_editView];
    [self.view addSubview:_shoppingCartView];
}
#pragma mark --编辑事件
-(void)editAction:(id)sender{
    
    if ([LoginModel isLogin] && _goodsModelArray.count != 0) {
        if ([self.rightBtn.titleLabel.text isEqualToString:@"编辑"]) {
            _settleView.hidden = YES;
            _editView.hidden = NO;
            self.tagg1 = 1;
            self.tagg = 0;
            [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        }else{
            _settleView.hidden = NO;
            _editView.hidden = YES;
            self.tagg = 1;
            self.tagg1 = 0;
            [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        }
        
    }
    
    
}
#pragma mark --跳转结算界面
-(void)changeToOrder:(id)sender{
    if ([self.labNumber.text isEqualToString:@"去结算"]) {
        return;
    }else{
        OrderConfirmController *orderVC = [OrderConfirmController alloc];
        orderVC.tempArr = _orderArray;
        orderVC.priccc=[NSString stringWithFormat:@"%d",ss];
        MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
        [tabbar hideCustomTabbar:YES];
        orderVC.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:orderVC animated:YES];
    }
    
}
#pragma mark --删除商品
-(void)deleteAction:(id)sender{

    if (_goodsArr.count == 0) {
        
        return;
    }
    
    ShoppingCartModel *model = [ShoppingCartModel new];
    model.deletedGoodsIds = [_goodsArr copy];
    
    WS(ws)
    [[Ditiy_NetAPIManager sharedManager]request_DeleteGoodsFromShoppingCart_WithParams:[model toDeleteGoodsFromShoppingCartParams] andBlock:^(id data, NSError *error) {
       
    
        if (data) {
            
            [MBProgressHUD showSuccess:data[@"msg"]];
            
            [ws myGoods];
            [ws.goodsArr removeAllObjects];
            
        }
        
        
    }];
    
}
#pragma mark --移入关注
-(void)attentionAction:(id)sender{
    if (_goodsArr.count == 0) {
        
        return;
    }
    _goodsIdStr = nil;
    _goodsIdStr = self.goodsArr[0];
    for (int i = 1; i < self.goodsArr.count; i++) {
        _goodsIdStr = [NSString stringWithFormat:@"%@,%@",_goodsIdStr,self.goodsArr[i]];
    }
    
    NSString *api_token = [RequestModel model:@"goods" action:@"collect"];
    
    NSDictionary *dict = @{@"api_token":api_token,@"key":[LoginModel key],@"goods_id":_goodsIdStr};
    __weak typeof(self) weakSelf = self;
    [RequestModel requestWithDictionary:dict model:@"goods" action:@"collect" block:^(id result) {
        NSDictionary *dic = result;
        NSLog(@"获得的数据：%@",dic);
        [weakSelf myGoods];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:dic[@"msg"] delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        [weakSelf.goodsArr removeAllObjects];
        
    }];
    
}
//全选
-(void)change:(id)sender{
    self.tagg1 = 0;
    if (self.tagg == 1) {
        //选中状态
        [_changeBtn setImage:[UIImage imageNamed:@"select_cart_goods1.png"] forState:UIControlStateNormal];
        _orderArray = [_goodsModelArray mutableCopy];
        int a = 0;
        int b = 0;
        for (int i = 0; i < _goodsModelArray.count; i++) {
            _model = _goodsModelArray[i];
            a = a+[_model.goods_price intValue]*_model.number;
            b = b +_model.number ;
        }
        self.labNumber.text = [NSString stringWithFormat:@"去结算%d",b];
        
        self.amountLabel.text = [NSString stringWithFormat:@"合计：￥%d",a];
        //总额
        self.sumLabel.text = [NSString stringWithFormat:@"总额：￥%d",a];
        
        self.tagg = 2;
        [self.tableView reloadData];
    }else if (self.tagg == 2){
        [_changeBtn setImage:[UIImage imageNamed:@"select_cart_goods2.png"] forState:UIControlStateNormal];
        [_orderArray removeAllObjects];
        self.labNumber.text = @"去结算0";
        self.amountLabel.text = @"合计：￥0";
        //总额
        self.sumLabel.text = @"总额：￥0";
        self.tagg = 1;
        [self.tableView reloadData];
    }
    
}
//编辑状态下的全选
-(void)changeAll:(id)sender{
    
    self.tagg = 0;
    
    if (self.tagg1 == 1) {
        [_changeAllBtn setImage:[UIImage imageNamed:@"select_cart_goods1.png"] forState:UIControlStateNormal];
        _orderArray = _goodsModelArray;
        for (int i = 0; i<_goodsModelArray.count; i++) {
            ShoppingCartGoodsModel *goodsmodel = _goodsModelArray[i];
            NSString *rec_id = goodsmodel.rec_id;
            [_goodsArr addObject:rec_id];
        }
        
        [self.tableView reloadData];
        self.tagg1 = 2;
        
        
    }else if (self.tagg1 == 2){
        [_changeAllBtn setImage:[UIImage imageNamed:@"select_cart_goods2.png"] forState:UIControlStateNormal];
        [self.tableView reloadData];
        self.tagg1 = 1;
        [_goodsArr removeAllObjects];
        [_orderArray removeAllObjects];
    }
}
#pragma mark-购物车数据
-(void)myGoods{
//    UIApplication *appli=[UIApplication sharedApplication];
//    AppDelegate *app=appli.delegate;
//    NSString *api_token = [RequestModel model:@"goods" action:@"cartlist"];
//    NSDictionary *dict = @{@"api_token":api_token,@"key":app.tempDic[@"data"][@"key"]};
    
    WS(weakSelf)
    ShoppingCartModel *model  = [ShoppingCartModel new];
    
    [[Ditiy_NetAPIManager sharedManager]request_ShoppingCart_WithParams:[model toShoppingCartParams] andBlock:^(id data, NSError *error) {
       
        if (data) {
    
            weakSelf.goodsModelArray = [NSMutableArray array];
            weakSelf.goodsModelArray = [ShoppingCartGoodsModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
            
            if (weakSelf.goodsModelArray.count == 0) {
                viewbuy.hidden = YES;
                weakSelf.loginView.hidden = NO;
                weakSelf.shoppingCartView.hidden = YES;
                
                
            }else{
                weakSelf.shoppingCartView.hidden = NO;
                weakSelf.loginView.hidden = YES;
                
            }
            int numOfGoods = 0;
            for (int i = 0; i < weakSelf.goodsModelArray.count; i++) {
                weakSelf.model = _goodsModelArray[i];
                numOfGoods = numOfGoods +weakSelf.model.number ;
            }
            NSString * cc=[NSString stringWithFormat:@"%d",numOfGoods];
#pragma mark- 创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"123" object:nil userInfo:@{@"1234":cc}];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            [self.tableView reloadData];
        }
        
 
        
    }];
    
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
#pragma mark --tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _goodsModelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string = @"MyGoodsViewCell";
    MyGoodsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyGoodsViewCell" owner:self options:nil]lastObject];
        
    }
    if (self.tagg == 1 ) {
        cell.taggg = 1;
        self.tagg1 = 1;
        [cell.changeBtn setImage:[UIImage imageNamed:@"select_cart_goods2.png"] forState:UIControlStateNormal];
        if (indexPath.section == _goodsModelArray.count) {
            self.tagg1 = 1;
        }
    }else if(self.tagg == 2){
        cell.taggg = 2;
        self.tagg1 = 1;
        [cell.changeBtn setImage:[UIImage imageNamed:@"select_cart_goods1.png"] forState:UIControlStateNormal];
        if (indexPath.section == _goodsModelArray.count) {
            self.tagg1 = 1;
        }
    }
    else if (self.tagg1 == 1 ) {
        cell.taggg = 1;
        
        [cell.changeBtn setImage:[UIImage imageNamed:@"select_cart_goods2.png"] forState:UIControlStateNormal];
        if (indexPath.section == _goodsModelArray.count) {
            self.tagg = 1;
        }
    }else if(self.tagg1 == 2){
        cell.taggg = 2;
        
        [cell.changeBtn setImage:[UIImage imageNamed:@"select_cart_goods1.png"] forState:UIControlStateNormal];
        if (indexPath.section == _goodsModelArray.count) {
            self.tagg = 1;
        }
    }
    
    
    
    cell.model = self.goodsModelArray[indexPath.section];
    [cell.changeBtn addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
#pragma mark --改变cell上面的button
-(void)changeState:(UIButton *)button{
    MyGoodsViewCell * cell = (MyGoodsViewCell *)button.superview.superview;
    NSUInteger section = [_tableView indexPathForCell:cell].section;
    NSString *num = cell.goods_number.titleLabel.text;
#pragma mark-数量增加或者减少
    int anum = [num intValue];
    
    int bnum = [[self.labNumber.text substringFromIndex:3] intValue];
    int aPrice = [[cell.goods_sum.text substringFromIndex:4]intValue];
    int bPrice = [[self.amountLabel.text substringFromIndex:4]intValue];
    ShoppingCartGoodsModel *goodsmodel = [ShoppingCartGoodsModel new];
    goodsmodel.goods_price = cell.goods_price.text;
    goodsmodel.goods_img = cell.url;
    goodsmodel.number = [cell.goods_number.titleLabel.text intValue];
    goodsmodel.goods_name = cell.goods_name.text;
    goodsmodel.goods_id = cell.goods_id;
    if (cell.taggg == 2) {
        //去结算
        int c = anum+bnum;
        self.labNumber.text = [NSString stringWithFormat:@"去结算%d",c];
        //合计
        int d = aPrice + bPrice;
        self.amountLabel.text = [NSString stringWithFormat:@"合计：￥%d",d];
        ss=d;
        //总额
        self.sumLabel.text = [NSString stringWithFormat:@"总额：￥%d",d];
        //把选中的商品id放到数组
        NSString *good_id = cell.rec_id;
        [_goodsArr addObject:good_id];
        [_orderArray addObject:goodsmodel];
    }else{
        int c = bnum - anum;
        self.labNumber.text = [NSString stringWithFormat:@"去结算%d",c];
        //合计
        int d = bPrice - aPrice;
        self.amountLabel.text = [NSString stringWithFormat:@"合计：￥%d",d];
        //总额
        self.sumLabel.text = [NSString stringWithFormat:@"总额：￥%d",d];
        ss=d;
        //把选中的商品id移除
        [_goodsArr removeObject:cell.rec_id];
        [_orderArray removeObject:goodsmodel];
    }
    NSLog(@"%@",_goodsArr);
    NSLog(@"------%@",cell.goods_number.titleLabel.text);
    NSLog(@"%lu",(unsigned long)section);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCartGoodsModel *model = [ShoppingCartGoodsModel new];
    model =_goodsModelArray[indexPath.section];
    GoodsDetailViewController *goodVC = [GoodsDetailViewController new];
    goodVC.goodID = model.goods_id;
    MyTabBarViewController * tabbar =(MyTabBarViewController *)self.navigationController.tabBarController;
    [tabbar hideCustomTabbar:YES];
    goodVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goodVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
#pragma mark --购物车数量请求数据
-(void)myGoodsNum{
    UIApplication *appli=[UIApplication sharedApplication];
    AppDelegate *app=appli.delegate;
    NSString *api_token = [RequestModel model:@"goods" action:@"cartnum"];
    NSDictionary *dict = @{@"api_token":api_token,@"key":app.tempDic[@"data"][@"key"]};
    __weak typeof(self) weakSelf = self;
    
    [RequestModel requestWithDictionary:dict model:@"goods" action:@"cartnum" block:^(id result) {
        NSDictionary *dic = result;
        
        NSString *num = dic[@"data"];
        weakSelf.labNumber.text = [NSString stringWithFormat:@"去结算%@",num];
    }];
}
-(void)dealloc{
    self.temp = @"2";
}
- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshViewWithStyle:SDRefreshViewStyleCustom];
    refreshHeader.backgroundColor = [UIColor whiteColor];
    refreshHeader.delegate = self;
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置
    //    refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:self.tableView];
    _refreshHeader = refreshHeader;
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    __weak typeof(self) weakSelf = self;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.totalRowCount += 3;
            [weakSelf.tableView reloadData];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    // 动画view
    UIImageView *animationView = [[UIImageView alloc] init];
    
    animationView.frame = CGRectMake(30, 45, 40, 40);
    animationView.image = [UIImage imageNamed:@"a0v"];
    [refreshHeader addSubview:animationView];
    _animationView = animationView;
    
    NSArray *images = @[[UIImage imageNamed:@"a0v"],
                        [UIImage imageNamed:@"a0w"],
                        [UIImage imageNamed:@"a0x"],
                        [UIImage imageNamed:@"a0y"]
                        ];
    _animationView.animationImages = images;
    
    
    UIImageView *boxView = [[UIImageView alloc] init];
    boxView.frame = CGRectMake(150, 10, 15, 8);
    boxView.image = [UIImage imageNamed:@"box"];
    [refreshHeader addSubview:boxView];
    _boxView = boxView;
    
    UILabel *label= [[UILabel alloc] init];
    label.text = @"下拉加载最新数据";
    label.frame = CGRectMake((self.view.bounds.size.width - 200) * 0.5, 5, 200, 20);
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [refreshHeader addSubview:label];
    _label = label;
    
    // 进入页面自动加载一次数据
    [refreshHeader autoRefreshWhenViewDidAppear];
}

- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    [refreshFooter addToScrollView:self.tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


- (void)footerRefresh
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.totalRowCount += 2;
        [weakSelf.tableView reloadData];
        [weakSelf.refreshFooter endRefreshing];
    });
}

#pragma mark - SDRefreshView Animation Delegate

- (void)refreshView:(SDRefreshView *)refreshView didBecomeNormalStateWithMovingProgress:(CGFloat)progress
{
    refreshView.hidden = NO;
    
    if (progress == 0) {
        _animationView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        _boxView.hidden = NO;
        
        _label.text = @"下拉可以刷新";
        
        [_animationView stopAnimating];
    }
    //    self.animationView.transform = CGAffineTransformMakeTranslation(progress * 20, -20 * progress);
    self.animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(progress * 30, -20 * progress), CGAffineTransformMakeScale(progress, progress));
    self.boxView.transform = CGAffineTransformMakeTranslation(- progress * 65, progress * 35);
    
}

- (void)refreshView:(SDRefreshView *)refreshView didBecomeRefreshingStateWithMovingProgress:(CGFloat)progress
{
    _label.text = @"正在加载数据...";
    [UIView animateWithDuration:1.5 animations:^{
        //        self.animationView.transform = CGAffineTransformMakeTranslation(200, -20);
    }];
}

- (void)refreshView:(SDRefreshView *)refreshView didBecomeWillRefreshStateWithMovingProgress:(CGFloat)progress
{
    _boxView.hidden = YES;
    _label.text = @"松开后刷新";
    _animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(30, -20), CGAffineTransformMakeScale(1, 1));
    [_animationView startAnimating];
}
#pragma mark -- 自定义导航栏
- (void)initNavigationBar{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *naviBGColor = data[@"navigationBGColor"];
    NSString *navigationRightColor = data[@"navigationRightColor"];
    NSString *tabbar = data[@"tabbar3"];
    NSString *navigationRightFont = data[@"navigationRightFont"];
    int navigationRFont = [navigationRightFont intValue];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view1.backgroundColor = [UIColor colorWithHexString:naviBGColor];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, self.view.frame.size.width - 200, 44)];
    label1.text = tabbar;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:17];
    [view1 addSubview:label1];
    
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor colorWithHexString:naviBGColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, self.view.frame.size.width - 200, 44)];
    label.text = tabbar;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17];
    [view addSubview:label];
    
    
    //    UIImage *img = [UIImage imageNamed:@"个人中心-标题栏-设置icon.png"];
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(label.frame.size.width + label.frame.origin.x + 30, 25, 60, 32)];
    [_rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:navigationRightColor] forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:navigationRFont];
    [_rightBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    //    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [view addSubview:_rightBtn];
    
    UIImage *img = [UIImage imageNamed:@"back.png"];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 20, 20)];
    imgView.image = img;
    btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
    //    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    if ([self.temp isEqualToString:@"1"]) {
        btn1.hidden = NO;
    }else{
        btn1.hidden = YES;
    }
    //    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn1 addSubview:imgView];
    [view addSubview:btn1];
    
    
    UIImage *img1 = [UIImage imageNamed:@"back.png"];
    UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 20, 20)];
    imgView1.image = img1;
    btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    //    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    if ([self.temp isEqualToString:@"1"]) {
        btn2.hidden = NO;
    }else{
        btn2.hidden = YES;
    }
    //    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn2 addSubview:imgView1];
    [view1 addSubview:btn2];
    [self.shoppingCartView addSubview:view];
    [self.loginView addSubview:view1];
    
    
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
