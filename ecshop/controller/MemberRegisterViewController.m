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
@interface MemberRegisterViewController ()<WDPickViewDelegate>

@end

@implementation MemberRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavigationBar];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (void)initViews{
    
    WDPickView *pickView = [[WDPickView alloc]initPickViewWithPlistName:@"Address"];
    pickView.delegate = self;
//    self.kaihushengTextField.inputView = pickView;
//    self.kaihushiTextField.inputView = pickView;
    
    
    
}


//- (void)toolBarDoneBtnHaveClicked:(WDPickView *)pickView resultString:(NSString *)resultString shengfen:(NSString *)shengfen{
//    
//    self.kaihushiTextField.text = [resultString substringToIndex:[resultString length] -5];
//    NSString *areaCode  = [resultString substringFromIndex:[resultString length] -4];
//    self.kaihushengTextField.text = shengfen;
//    [KUserDefault setObject:shengfen forKey:Kkaihusheng];
//    [KUserDefault setObject:self.kaihushiTextField.text forKey:Kkaihushi];
//    //    [KUserDefault setObject:areaCode forKey:Ksuozaidibianma];
//    [KUserDefault synchronize];
//    
//    
//    //    为了解决跳转时，如果焦点停留在所在地区上，奔溃的bug
//    [self.view endEditing:YES];
//    
//}


- (void)initNavigationBar{
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.title = @"申请分享员";
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    
    
    
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
