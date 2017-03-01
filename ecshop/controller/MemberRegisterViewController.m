//
//  MemberRegisterViewController.m
//  ecshop
//
//  Created by 吴狄 on 2017/2/27.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "MemberRegisterViewController.h"
#import "UIColor+Hex.h"
#import "WDPickView.h"
#import "Masonry.h"
@interface MemberRegisterViewController ()<WDPickViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *userInfoView;

@property (strong, nonatomic) IBOutlet UIView *userIDInfoView;




@property (weak, nonatomic) IBOutlet UITextField *phoneTextField; //手机号

@property (weak, nonatomic) IBOutlet UITextField *codeTextField; //手机验证码

@property (weak, nonatomic) IBOutlet UITextField *invitationCodeTextField; //邀请码

@property (weak, nonatomic) IBOutlet UITextField *nameTextField; //真实姓名

@property (weak, nonatomic) IBOutlet UITextField *IDCardTextField; //身份证号码



@property (weak, nonatomic) IBOutlet UIButton *frontButton; //正面照片按钮
@property (weak, nonatomic) IBOutlet UIButton *backButton; //反面照片按钮


@property (weak, nonatomic) IBOutlet UITextField *proviceTextField; //省

@property (weak, nonatomic) IBOutlet UITextField *cityTextField; //市

@property (weak, nonatomic) IBOutlet UITextField *addressTextField; //地址

@property (weak, nonatomic) IBOutlet UIButton *confirmButton; //确认按钮


@end

@implementation MemberRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavigationBar];
    
    [self initViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (void)initViews{
    
    WDPickView *pickView = [[WDPickView alloc]initPickViewWithPlistName:@"Address"];
    pickView.delegate = self;
    self.proviceTextField.inputView = pickView;
    self.cityTextField.inputView = pickView;
    
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    //self.scrollView.contentSize = CGSizeMake(kScreenWidth, 800);
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.userInfoView];
    [self.scrollView addSubview:self.userIDInfoView];
    

    
    
//    [self.confirmButton setTitleColor:RGB(0, 255, 0) forState:UIControlStateNormal];
    
    
//    [self.confirmButton setBackgroundColor:RGB(0, 255, 0)];

    
    //[self.scrollView updateConstraints];
//
//
    
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        
//        make.top.left.bottom.right.equalTo(self.view);
//        
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth,800));
//        
//        
//    }];
    
    
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.scrollView).with.offset(0);
        
            make.right.equalTo(self.scrollView).with.offset(0);
        
            make.top.equalTo(self.scrollView).with.offset(0);
        
            make.size.mas_equalTo(CGSizeMake(kScreenWidth,210));

    }];
    
    
    [self.userIDInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        

        make.left.equalTo(self.scrollView).with.offset(0);
        
        make.right.equalTo(self.scrollView).with.offset(0);
        
        make.top.equalTo(self.userInfoView.mas_bottom).with.offset(0);
        
        make.bottom.equalTo(self.scrollView).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(kScreenWidth,500));
        
    }];

    
    
    



    
    
    
}


- (void)toolBarDoneBtnHaveClicked:(WDPickView *)pickView resultString:(NSString *)resultString shengfen:(NSString *)shengfen{
    
//    self.kaihushiTextField.text = [resultString substringToIndex:[resultString length] -5];
//    NSString *areaCode  = [resultString substringFromIndex:[resultString length] -4];
//    self.kaihushengTextField.text = shengfen;
//    [KUserDefault setObject:shengfen forKey:Kkaihusheng];
//    [KUserDefault setObject:self.kaihushiTextField.text forKey:Kkaihushi];
//    //    [KUserDefault setObject:areaCode forKey:Ksuozaidibianma];
//    [KUserDefault synchronize];
    
    
    //    为了解决跳转时，如果焦点停留在所在地区上，奔溃的bug
    [self.view endEditing:YES];
    
}


- (void)initNavigationBar{
    
    
    
    self.title = @"申请分享员";
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}


-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
