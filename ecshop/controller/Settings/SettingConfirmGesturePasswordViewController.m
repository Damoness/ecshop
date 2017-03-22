
//
//  SettingConfirmGesturePasswordViewController.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/14.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "SettingConfirmGesturePasswordViewController.h"
#import "ZPUnlockView.h"
#import "ZPFmdbTool.h"
#import "GestureModel.h"

@interface SettingConfirmGesturePasswordViewController ()<ZPUnlockViewDelegate>

@property (weak, nonatomic) IBOutlet ZPUnlockView *unlockView;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@end

@implementation SettingConfirmGesturePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.unlockView.delegate = self;
    
    self.title = @"修改手势密码";

    //self.navigationItem.backBarButtonItem.title = @"";
    
    self.promptLabel.text = @"请再次绘制手势密码";
    
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
        self.promptLabel.text = @"请再次绘制手势密码";
        self.promptLabel.textColor = [UIColor darkGrayColor];
        
    
        if ([p integerValue] == [self.password integerValue]) {
            
            //设置成功
            
            [[ZPFmdbTool sharedDatabaseQueue]insertPassword:p];
            
            [[SettingManager sharedManager] setGesturePassword:p];
            [[SettingManager sharedManager] setGestureLock:true];
            
            [MBProgressHUD showSuccess:@"设置手势密码成功"];
            
            GestureModel *model =  [GestureModel new];
            
            model.mobile_phone = [LoginModel currentLoginUser].mobile;
            model.gesture_pass = self.password;
            
            
            
            
//            [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3] animated:YES];
            

            
            if (_delegate && [_delegate respondsToSelector:@selector(settingGesturePasswordViewController:didFinishSettingWithPassword:)]) {
                
                [_delegate settingGesturePasswordViewController:nil didFinishSettingWithPassword:p];
            
                
            }
            

            if (kH5_Version) {
                
                model.user_id = [LoginModel currentLoginUser].user_id;
                
                
                [[Ditiy_NetAPIManager sharedManager]request_H5_SaveGestureCode_WithParams:[model toH5SaveGestureCodeParams] andBlock:^(id data, NSError *error){
            
                }];
                
                
            }else{
                
                [[Ditiy_NetAPIManager sharedManager]request_SaveGestureCode_WithParams:[model toSaveGestureCodeParams] andBlock:^(id data, NSError *error) {
                    
                    
                }];

            }
            

            
            
            
    
            
            
        }else{
            
            //
            self.promptLabel.text = @"与上次绘制不一致，请重新绘制";
            self.promptLabel.textColor = [UIColor redColor];

            [ZPUnlockView resetWrong];
            
            
        }
        
        
    }
    
    
    
}


- (IBAction)reset_Action:(id)sender {
    
    
    
    
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
