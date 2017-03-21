//
//  MyViewController.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/5.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "MyViewController.h"
#import "CustomButton.h"
#import "UIButton+Common.h"
#import "LoginViewController.h"

#import "MemberRegisterViewController.h"
#import "AddressViewController.h"
#import "MyAttentionViewController.h"
#import "MyOrderViewController.h"
#import "SettingViewController.h"

#import "MyTabBarViewController.h"
//#import "LAContext.h"

@import LocalAuthentication;

@interface MyViewController ()


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonArray;

@property (weak, nonatomic) IBOutlet CustomButton *unpayButton;
@property (weak, nonatomic) IBOutlet CustomButton *undispatchedButton;
@property (weak, nonatomic) IBOutlet CustomButton *unreceivedButton;
@property (weak, nonatomic) IBOutlet CustomButton *finishedButton;

@property (weak, nonatomic) IBOutlet UIButton *allOrderButton;


@property (weak, nonatomic) IBOutlet CustomButton *myShareButton;

@property (weak, nonatomic) IBOutlet CustomButton *myEvaluationButton;

@property (weak, nonatomic) IBOutlet CustomButton *myCollectionButton;

@property (weak, nonatomic) IBOutlet CustomButton *myAddressButton;




@property (weak, nonatomic) IBOutlet UILabel *shareBeanLabel; //分享豆

@property (weak, nonatomic) IBOutlet UILabel *shareTicketLabel; //分享券

@property (weak, nonatomic) IBOutlet UIButton *userPhotoButton;//用户头像

@property (weak, nonatomic) IBOutlet UILabel *nameLabel; //用户名称

@property (weak, nonatomic) IBOutlet UILabel *userStatusLabel; //用户身份


@property (weak, nonatomic) IBOutlet UIImageView *sexImageView; //用户性别

@property (strong,nonatomic) UserModel *myUserModel;




//OrderAll = 0, //所有订单
//OrderUnpayed, //待付款
//OrderUndispatched , //代发货
//OrderUnreceived  ,//待收货
//OrderFinished  //已完成



@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initViews];
    
    
    if ([LoginModel isLogin]) {
        
        [self requestData];
    
    }else{
        
        LoginViewController *lVC = [LoginViewController new];
        
        [self presentViewController:lVC animated:YES completion:nil];
        
        
    }
    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    DebugLog(@"");
    self.navigationController.navigationBar.hidden = true;
    
    
    MyTabBarViewController *myTbVC = (MyTabBarViewController *) self.navigationController.tabBarController;
    [myTbVC hideCustomTabbar:NO];
    
    

}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
    DebugLog(@"");
    
//    MyTabBarViewController *myTbVC = (MyTabBarViewController *) self.navigationController.tabBarController;
//    
//    [myTbVC hideCustomTabbar:YES];
}



-(void)requestData{
    
    
    WS(ws);
    UserModel *userModel  = [UserModel new];
    
    [[Ditiy_NetAPIManager sharedManager]request_UserInfo_WithParams:[userModel toUserInfoParams] andBlock:^(id data, NSError *error) {
    
    
        if (data) {
        
            
            ws.myUserModel = [UserModel mj_objectWithKeyValues:data[@"data"][0]];
            
            
            
            [LoginModel doLogin:[ws.myUserModel mj_keyValues]];
            
            [self updateUI];
            
        
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_ShoppingCart_No object:@{@"cart_num":ws.myUserModel.cart_num}];
            
            
        }
        
    
    }];
    
}



-(void)updateUI{
    
    if (self.myUserModel) {
        
        self.shareBeanLabel.text = self.myUserModel.integration;
        self.shareTicketLabel.text = self.myUserModel.user_money;
        self.unpayButton.badgeNo = [self.myUserModel.pay intValue];
        self.undispatchedButton.badgeNo  = [self.myUserModel.shipping_send intValue];
        self.unreceivedButton.badgeNo = [self.myUserModel.shipping intValue];
        
        if ([self.myUserModel.sex intValue] == 0) {
            
            self.sexImageView.image = [UIImage imageNamed:@"my_sex_man"];
        }else{
            
            self.sexImageView.image = [UIImage imageNamed:@"my_sex_un"];
        }
        
        self.nameLabel.text = self.myUserModel.nick_name;
        
        self.userStatusLabel.text = self.myUserModel.rank_name;
        
        
    }
    
    
}

-(void)initViews{
    
    self.navigationController.navigationBar.hidden = true;
    
    
    self.userPhotoButton.layer.cornerRadius = 25;
    self.userPhotoButton.layer.masksToBounds = true;
    
    self.userStatusLabel.layer.cornerRadius = 10;
    self.userStatusLabel.layer.masksToBounds = true;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:kNotification_Login_Success object:nil];
    
}


- (IBAction)myShare_Action:(CustomButton *)sender {
    
    sender.backgroundColor = [UIColor whiteColor];
    
}

- (IBAction)my_Action:(CustomButton *)sender {

    if (![LoginModel isLogin]) {
        
        return;
    }
    

    if (sender == self.myShareButton) {
        

        MemberRegisterViewController *mrVC = [MemberRegisterViewController new];
        //mrVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mrVC animated:YES];
        
        
    }
    else if (sender == self.myEvaluationButton){
        
        
        
    }
    else if (sender == self.myCollectionButton){
        
        
        MyAttentionViewController *maVC = [MyAttentionViewController new];
        //addressVC.tempDic = self.tempDic;
        //maVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:maVC animated:YES];
        
        
    }
    else if (sender == self.myAddressButton){
        
    
        AddressViewController *addressVC = [AddressViewController new];
        //addressVC.tempDic = self.tempDic;
        //addressVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressVC animated:YES];
        
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//我的订单
- (IBAction)myOrder_Action:(CustomButton *)sender {
    
    
    if (![LoginModel isLogin]) {
        
        

        LoginViewController *lVC = [LoginViewController new];
        
        [self presentViewController:lVC animated:YES completion:nil];
        
        return;
    }
    
    MyOrderViewController *myVC = [MyOrderViewController new];
    
    if (sender == self.unpayButton) { //待付款
        
        
        myVC.tagg = @"1";
        
        
    }
    else if (sender == self.undispatchedButton){ //待发货
        
        myVC.tagg = @"3";
        
    }
    else if (sender == self.unreceivedButton){ //待收货
        
        
        myVC.tagg = @"4";
        
    }
    else if (sender == self.finishedButton){ //已完成
        
        
        myVC.tagg = @"5";
        
    }
    else if (sender == self.allOrderButton){ //全部
        
        
        myVC.tagg = @"0";
        
    }
    
    [self.navigationController pushViewController:myVC animated:YES];
    
    
    
}


- (IBAction)setting_Action:(UIButton *)sender {
    
    
    SettingViewController *sVC = [SettingViewController new];
    
    [self.navigationController pushViewController:sVC animated:YES];
    
    
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
