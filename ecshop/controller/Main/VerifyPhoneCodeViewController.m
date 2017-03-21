//
//  VerifyPhoneCodeViewController.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/21.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "VerifyPhoneCodeViewController.h"

#import "NSString+RegularExpression.h"


@interface VerifyPhoneCodeViewController ()


@property (nonatomic,strong) UIButton *getCodeButton;

@property (nonatomic,strong) UITextField *codeTextField;

@property (nonatomic,strong) UIButton *nextButton;

@property (nonatomic,strong) NSString *phoneCodeStr;
@property (nonatomic,strong) NSString *phoneNoStr;

@end

@implementation VerifyPhoneCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViews];
    
}


-(void)initViews{
    
    
    self.title = @"重置手势密码";
    
    UIView *codeView = ({
        
        UIView *aView = [[UIView alloc]init];
        //aView.backgroundColor = [UIColor redColor];
        [self.view addSubview:aView];
        
        [aView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.view);
            make.left.equalTo(self.view).with.offset(-20);
            make.height.mas_equalTo(50);
            make.top.equalTo(self.view).with.offset(100);
            
        }];
        
        
        self.getCodeButton = ({
            
            [UIButton appearance];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font=[UIFont systemFontOfSize:14];
            [button setBackgroundImage:[self imageWithColor:kColor_Common_RedColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[self imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateSelected];
            
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            
            
            [aView addSubview:button];
            
            [button setTitle:@"获取验证码" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(getCodeButton_Action:) forControlEvents:UIControlEventTouchUpInside];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(aView).with.offset(-30);
                make.size.mas_equalTo(CGSizeMake(100, 30));
                make.centerY.equalTo(aView);
                
            }];
            
            button;
            
        });
        
        
        self.codeTextField = ({
            UITextField *textField =  [[UITextField alloc]init];
            
            [aView addSubview:textField];
            
            textField.layer.borderWidth = 0.5 ;
            textField.layer.borderColor = [UIColor grayColor].CGColor;
            
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                
                
                make.left.equalTo(aView).with.offset(30);
                make.right.equalTo(self.getCodeButton.mas_left).offset(-20);
                make.height.mas_equalTo(30);
                make.centerY.equalTo(aView);
                
            }];
            
            
            textField.placeholder = @" 请输入验证码";
            
            
            textField;
        });
        
        
        
        aView;
    });
    
    
    self.nextButton = ({
    
        UIButton *nButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.view addSubview:nButton];
        
        nButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [nButton setBackgroundImage:[self imageWithColor:kColor_Common_RedColor] forState:UIControlStateNormal];
        [nButton setBackgroundImage:[self imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateSelected];
        
        nButton.layer.cornerRadius = 5;
        nButton.layer.masksToBounds = YES;
        
        [nButton setTitle:@"下一步" forState:UIControlStateNormal];
        
        [nButton addTarget:self action:@selector(nextButton_Action:) forControlEvents:UIControlEventTouchUpInside];
        
        [nButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(150, 30));
            
        }];
        
        nButton;
    });
    

    
}


-(void)getCodeButton_Action:(UIButton *)button{
    
    
    
    self.phoneNoStr = [LoginModel currentLoginUser].mobile;
    
    if ([self.phoneNoStr isPhoneNo]) {
        
        
        [[Ditiy_NetAPIManager sharedManager]request_PhoneVerifyCode_WithParam:self.phoneNoStr andBlock:^(id data, NSError *error) {
            
           
            
            if (data) {
                
    
                
                
            }else{
                
                
                [MBProgressHUD showError:@"失败"];
                
            }
            
            
        }];
        
        
        
    }
    
    
}


-(void)nextButton_Action:(UIButton *)button{

    
    self.phoneNoStr = [LoginModel currentLoginUser].mobile;
    
    
    if (![self.codeTextField.text isPhoneVerifyCode]) {
        
        [MBProgressHUD showError:@"请填写正确的验证码"];
        return;
        
    }
    
    
    if ([self.phoneNoStr isPhoneNo] && [self.codeTextField.text isPhoneVerifyCode]) {
        

        [[Ditiy_NetAPIManager sharedManager]request_VerifyPhoneCode:self.codeTextField.text WithPhoneNo:self.phoneNoStr andBlock:^(id data, NSError *error) {
            
            
        
            if (data) {
                
                
                if ([data[@"code"]integerValue]==1) { //成功
                    
                    if (self.nextBlock) {
                        
                        self.nextBlock();
                        
                    }
                                         
                }else{
                    
                    
                    [MBProgressHUD showError:data[@"msg"]];
                    
                }
                
                
            }else{

                [MBProgressHUD showError:@"失败"];
                
            }
            
  
            
            
        }];
        
        
    }

    
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
