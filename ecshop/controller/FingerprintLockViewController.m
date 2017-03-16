//
//  FingerprintLockViewController.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/15.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "FingerprintLockViewController.h"
#import "Masonry.h"


@import LocalAuthentication;

@interface FingerprintLockViewController (){
    
    
    UIButton *fingerButton;
    UILabel *promptLabel;
}



@end

@implementation FingerprintLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    

    [self initViews];
    
}


-(void)initViews{
    
    fingerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [fingerButton setImage:[UIImage imageNamed:@"fingerprint"] forState:UIControlStateNormal];
    
    [self.view addSubview:fingerButton];
    
    [fingerButton addTarget:self action:@selector(fingerprint_Action:) forControlEvents:UIControlEventTouchUpInside];
    
    WS(ws)
    
    [fingerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //make.center.equalTo(ws.view);
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(ws.view).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(100,100));
    }];
    
    
    promptLabel = ({
    
        UILabel *label = [[UILabel alloc]init];
        label.text = @"点击进行指纹识别";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(fingerButton);
            make.centerY.mas_equalTo(fingerButton).with.offset(60);
            make.size.mas_equalTo(CGSizeMake(200, 30));
            
            
        }];
        
        label;
    });

}



-(void)fingerprint_Action:(UIButton *)button{
    
    
    [self evaluatePolicy];
    
}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [self evaluatePolicy];
    
}


- (void)evaluatePolicy {
    
    LAContext *context = [[LAContext alloc] init];
    __block  NSString *message;
    
    // Show the authentication UI with our reason string.
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"通过Home键验证已有手机指纹" reply:^(BOOL success, NSError *authenticationError) {
        if (success) {
            message = @"evaluatePolicy: succes";
            
            
        }
        else {
            message = [NSString stringWithFormat:@"evaluatePolicy: %@", authenticationError.localizedDescription];
        }
        
    }];
}



-(void)viewDidLayoutSubviews{
    
    
    
    
    
    
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
