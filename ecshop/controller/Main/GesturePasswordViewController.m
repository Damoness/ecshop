//
//  GesturePasswordViewController.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/20.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "GesturePasswordViewController.h"
#import "ZPUnlockView.h"
#import "AppDelegate.h"
#import "VerifyPhoneCodeViewController.h"

#import "SettingGesturePasswordViewController.h"

@interface GesturePasswordViewController ()<ZPUnlockViewDelegate,SettingGesturePasswordViewControllerDelegate>

@property (nonatomic,strong) ZPUnlockView *unlockView;

@property (strong, nonatomic) UILabel *promptLabel;

@property (strong,nonatomic) UIButton *forgetButton;

@property (strong ,nonatomic) UIWindow *window;

@end

@implementation GesturePasswordViewController

-(instancetype)initWithWindow:(UIWindow *)window{
    
    self = [super init];
    
    if (self) {
        
        self.window = window;
    }
    
    return self;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initViews];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear: animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)initViews{
    
    
    
    self.unlockView = [[ZPUnlockView alloc]init];
    self.unlockView.delegate = self;
    [self.view addSubview:_unlockView];
    
    WS(ws)
    [self.unlockView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(ws.view);
        
        make.size.mas_equalTo(CGSizeMake(300, 300));
        
    }];
    
    
    self.promptLabel = [[UILabel alloc]init];
    self.promptLabel.text = @"";
    self.promptLabel.textColor = [UIColor darkGrayColor];
    self.promptLabel.font = [UIFont systemFontOfSize:14];
    self.promptLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_promptLabel];
    
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.size.mas_equalTo(CGSizeMake(200, 30));
        
        make.bottom.mas_equalTo(ws.unlockView.mas_top).offset(-20);
        
        make.centerX.equalTo(ws.view);
        
    }];
    
    
    
    self.forgetButton = ({
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        
        [button setTitle:@"忘记手势密码" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(forgetButton_Action:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.size.mas_equalTo(CGSizeMake(200, 30));
            make.centerX.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).with.offset(-30);
            
        }];
        
        
        button;
    });
    
    
    
    
    
}


-(void)forgetButton_Action:(UIButton *)button{
    
    
    
    VerifyPhoneCodeViewController *verPhoneVC = [VerifyPhoneCodeViewController new];
    
    
    verPhoneVC.nextBlock = ^(){
        
        
        SettingGesturePasswordViewController *settingGesPassVC = [SettingGesturePasswordViewController new];
        settingGesPassVC.promptStr = @"设置手势密码";
        settingGesPassVC.delegate = self;
        [self.navigationController pushViewController:settingGesPassVC animated:YES];
        
        
    };
    
    [self.navigationController pushViewController:verPhoneVC animated:YES];
    
}


#pragma mark --SettingGesturePasswordViewControllerDelegate

-(void)settingGesturePasswordViewController:(SettingGesturePasswordViewController *)vc didFinishSettingWithPassword:(NSString *)password{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}


#pragma mark - ZPUnlockViewDelegate

-(void)ZPUnlockView:(ZPUnlockView *)ZPUnlockView didFinishDraw:(NSString *)password{
    
    
    if (password.length < 4) {
        
        self.promptLabel.text = @"至少连接4个点,请重新绘制";
        self.promptLabel.textColor = [UIColor redColor];
        
        
        [ZPUnlockView resetWrong];
        
        
        
    }else if([password isEqualToString:[[SettingManager sharedManager]gesturePassword]]){
        
        self.promptLabel.text = @"";
        self.promptLabel.textColor = [UIColor darkGrayColor];
        
        
        [ZPUnlockView reset];
        
        
        
        if(self.window){
            
             [self.window makeKeyAndVisible];
            
        }
            
    
        
    }else{
        
        
        self.promptLabel.text = @"密码错误";
        self.promptLabel.textColor = [UIColor redColor];
        
        
        [ZPUnlockView resetWrong];
        
        
        
    }

    
    
    
    
    
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

@end
