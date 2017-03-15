//
//  SettingGesturePasswordViewController.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/14.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "SettingGesturePasswordViewController.h"
#import "SettingConfirmGesturePasswordViewController.h"
#import "ZPUnlockView.h"

@interface SettingGesturePasswordViewController ()<ZPUnlockViewDelegate>{
    
    NSString *password;

}

@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet ZPUnlockView *unlockView;

@end

@implementation SettingGesturePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initViews];
    
}



-(void)initViews{
    
    self.title = self.promptStr;
    self.promptLabel.text = self.promptStr;
    
    self.unlockView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)ZPUnlockView:(ZPUnlockView *)ZPUnlockView didFinishDraw:(NSString *)p{
    
    
    if (p.length < 4) { //密码长度小于4
        
        self.promptLabel.text = @"至少连接4个点,请重新绘制";
        self.promptLabel.textColor = [UIColor redColor];
        
        
        [ZPUnlockView resetWrong];
        
    }else{
        
        
        [ZPUnlockView reset];
        self.promptLabel.text = self.promptStr;
        self.promptLabel.textColor = [UIColor darkGrayColor];
        
        password = p;
        
        SettingConfirmGesturePasswordViewController *vc = [SettingConfirmGesturePasswordViewController new];
        
        vc.password = p;
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }
    

    
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
