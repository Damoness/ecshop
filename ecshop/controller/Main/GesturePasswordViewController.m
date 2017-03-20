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

@interface GesturePasswordViewController ()<ZPUnlockViewDelegate>

@property (nonatomic,strong) ZPUnlockView *unlockView;

@property (strong, nonatomic) UILabel *promptLabel;


@end

@implementation GesturePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initViews];
    
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
}


#pragma mark - ZPUnlockViewDelegate

-(void)ZPUnlockView:(ZPUnlockView *)ZPUnlockView didFinishDraw:(NSString *)password{
    
    
    if (password.length < 4) {
        
        self.promptLabel.text = @"至少连接4个点,请重新绘制";
        self.promptLabel.textColor = [UIColor redColor];
        
        
        [ZPUnlockView resetWrong];
        
        
        
    }else if([password isEqualToString:[[SettingManager sharedManager]gesturePassword]]){
        
        self.promptLabel.text = @"成功";
        self.promptLabel.textColor = [UIColor darkGrayColor];
        
        
        [ZPUnlockView reset];
        
        AppDelegate *appDelegate =  [UIApplication sharedApplication].delegate;
        
        [appDelegate.window makeKeyAndVisible];
        
        
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
