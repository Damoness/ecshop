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
#import "ChooseAddressViewController.h"
#import "SharingManModel.h"
#import "SmallDropMenu.h"
#import "GeneralSeriesModel.h"
#import "NSString+Common.h"
@interface MemberRegisterViewController ()<WDPickViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *userInfoView;

@property (strong, nonatomic) IBOutlet UIView *userIDInfoView;




@property (weak, nonatomic) IBOutlet UITextField *phoneTextField; //手机号

@property (weak, nonatomic) IBOutlet UITextField *codeTextField; //手机验证码

@property (weak, nonatomic) IBOutlet UITextField *invitationCodeTextField; //邀请码

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *generalSeriesHeightLayoutConstraint;


@property (weak, nonatomic) IBOutlet UIView *generalSeriesView;


@property (weak, nonatomic) IBOutlet UITextField *generalSeriesTextField; //将系

@property (weak, nonatomic) IBOutlet UITextField *nameTextField; //真实姓名

@property (weak, nonatomic) IBOutlet UITextField *IDCardTextField; //身份证号码



@property (weak, nonatomic) IBOutlet UIButton *frontButton; //正面照片按钮
@property (weak, nonatomic) IBOutlet UIButton *backButton; //反面照片按钮


@property (weak, nonatomic) IBOutlet UITextField *proviceTextField; //省


@property (weak, nonatomic) IBOutlet UITextField *addressTextField; //地址

@property (weak, nonatomic) IBOutlet UIButton *confirmButton; //确认按钮

@property (strong,nonatomic) UIActionSheet *actionSheet;

@property (strong,nonatomic) SharingManModel *mySharingManModel;



@end

@implementation MemberRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self initNavigationBar];
    
    [self initViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    

    if (self.proviceTextField == textField) { //省市区选择
        

    }else if (self.generalSeriesTextField == textField){ //将系选择
        
        
    }else if(self.invitationCodeTextField == textField){ //平台码
        
        
        [[Ditiy_NetAPIManager sharedManager]request_PlatformCodeBlock:^(id data, NSError *error) {
          
            if (data && [[data objectForKey:@"result"] isEqualToString:@"success"]) {
                
                self.mySharingManModel.platform_code = data[@"info"][@"platform_code"];
                

            }
            
            
        }];
        
        
    }
 

    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.invitationCodeTextField == textField){
        
           NSLog(@"shouldChangeCharactersInRange:%@",self.invitationCodeTextField.text);
        
        return  YES;
        
    }
    
    return  YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.phoneTextField == textField) {
        
        
        
        
    }else if (self.codeTextField == textField){
        

        
        
    }else if (self.invitationCodeTextField == textField){
        
  
    }else if(self.nameTextField == textField){
        
        
        
    }else if(self.IDCardTextField == textField){
        
        
        
    }else if(self.proviceTextField == textField){
        
        
        
    }else if(self.addressTextField == textField){
        
        
    }

    
}


//
-(void)invitationCodeTextFieldEditingChanged{
    
    NSLog(@"invitationCodeTextFieldValueChanged:%@",self.invitationCodeTextField.text);
    
    if ([self.invitationCodeTextField.text isEqualToString:self.mySharingManModel.platform_code]) {
        
        
        self.generalSeriesHeightLayoutConstraint.constant = 40;
        self.generalSeriesView.hidden = false;
        
    }else{
        
        
        self.generalSeriesHeightLayoutConstraint.constant = 0;
        self.generalSeriesView.hidden = true;
    }
    
    
    
}

- (void)initViews{
    
    
    self.title = @"申请分享员";
    
    self.proviceTextField.delegate = self;
    self.codeTextField.delegate = self;
    self.invitationCodeTextField.delegate = self;
    self.generalSeriesTextField.delegate = self;
    self.nameTextField.delegate = self;
    self.IDCardTextField.delegate = self;
    self.proviceTextField.delegate = self;
    self.addressTextField.delegate = self;

    
    [self.invitationCodeTextField addTarget:self action:@selector(invitationCodeTextFieldEditingChanged) forControlEvents:UIControlEventEditingChanged];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];

    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.userInfoView];
    [self.scrollView addSubview:self.userIDInfoView];
    

    self.mySharingManModel = [SharingManModel new];
    
    
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
        
            make.size.mas_equalTo(CGSizeMake(kScreenWidth,250));

    }];
    
    
    [self.userIDInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        

        make.left.equalTo(self.scrollView).with.offset(0);
        
        make.right.equalTo(self.scrollView).with.offset(0);
        
        make.top.equalTo(self.userInfoView.mas_bottom).with.offset(0);
        
        make.bottom.equalTo(self.scrollView).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(kScreenWidth,500));
        
    }];

    
    
    
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




//获取验证码按钮 响应
- (IBAction)phoneVerifyCode_Action:(UIButton *)sender {
    
    if([self.phoneTextField.text isEmptyStr]){
        
        [self showAlertWithMessage:@"请填写手机号"];
        return;
        
    }

    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    

    [[Ditiy_NetAPIManager sharedManager]request_PhoneVerifyCode_WithParam:self.phoneTextField.text andBlock:^(id data, NSError *error) {
        
       
        if(data){
            
            [MBProgressHUD hideHUDForView:self.view];
            
        }else{
            
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"获取验证码失败"];
        }
        
        
    }];
    
    
}

//获取将系按钮 响应
- (IBAction)generalSeries_Action:(UIButton *)sender {
    
    SmallDropMenu *smallMenu = [[SmallDropMenu alloc]initWithShowFrame:CGRectMake(sender.frame.origin.x , sender.superview.frame.origin.y + sender.superview.frame.size.height + 64, 100, 200) ShowStyle:MYPresentedViewShowStyleSuddenStyle callback:^(id callback) {
        
        
        if([callback isKindOfClass:[GeneralSeriesModel class]]){
            
            GeneralSeriesModel *model = callback;
            
            self.generalSeriesTextField.text = model.ag_name;
            
            self.mySharingManModel.edi_general_id = model.ag_id;
            
        }
        
    }];
    
    [self presentViewController:smallMenu animated:YES completion:nil];
    
    
    
    [[Ditiy_NetAPIManager sharedManager]request_KingSeriesBlock:^(id data, NSError *error) {
        
        if (data) {
            
            NSArray *dataArray = [GeneralSeriesModel mj_objectArrayWithKeyValuesArray:data[@"general_list"]];
            
            smallMenu.handles = dataArray;
            
            
            
        }
        
        
    }];
    
    
}

//提交按钮 响应
- (IBAction)confirmButton_Action:(UIButton *)sender {
    
    
//    SharingManModel *model = [SharingManModel new];
//    model.edi_mobile = @"13202264036";
//    model.edi_mobile_vali_code = @"621908";
//    model.edi_invite_code = @"9999";
//    model.edi_general_id = @"1";
//    model.edi_real_name = @"wudi";
//    model.edi_card = @"429005199109013437";
//    model.edi_card_face = @"1";
//    model.edi_card_back = @"2";
//    model.addr_provinces = @"1";
//    model.addr_city = @"2";
//    model.addr_detail  = @"石景山";

    
//    @property (weak, nonatomic) IBOutlet UITextField *nameTextField; //真实姓名
//    
//    @property (weak, nonatomic) IBOutlet UITextField *IDCardTextField; //身份证号码

    
    
    
    self.mySharingManModel.edi_mobile = self.phoneTextField.text;
    self.mySharingManModel.edi_mobile_vali_code = self.codeTextField.text;
    self.mySharingManModel.edi_invite_code = self.invitationCodeTextField.text;
    self.mySharingManModel.edi_real_name = self.nameTextField.text;
    self.mySharingManModel.edi_card = self.IDCardTextField.text;
    self.mySharingManModel.addr_detail  = self.addressTextField.text;
    
    if ([self.mySharingManModel.edi_mobile isEmptyStr]) {
        
        [self showAlertWithMessage:@"请填写正确的手机号"];
        
        return;
        
    }
    
    if ([self.mySharingManModel.edi_mobile_vali_code isEmptyStr]) {
        
        [self showAlertWithMessage:@"请填写正确的验证码"];
        
        return;
        
    }
    
    if ([self.mySharingManModel.edi_invite_code isEmptyStr] ) {
        
        [self showAlertWithMessage:@"请填写正确的邀请码"];
        
        return;
        
    }
    
    if(self.mySharingManModel.edi_invite_code != self.mySharingManModel.platform_code && [self.mySharingManModel.edi_general_id isEmptyStr]){
        
        [self showAlertWithMessage:@"请选着将系"];
        
        return;
        
    }
    
    if ([self.mySharingManModel.edi_real_name isEmptyStr] ) {
        
        [self showAlertWithMessage:@"请填写正确的姓名"];
        
        return;
        
    }
    
    if ([self.mySharingManModel.edi_card isEmptyStr] ) {
        
        [self showAlertWithMessage:@"请填写正确的身份证号"];
        
        return;
        
    }
    
    if (self.mySharingManModel.edi_card_face == nil) {//照片正面
        
        
        [self showAlertWithMessage:@"请选择身份证正面"];
        
        return;
        
    }
   
    if (self.mySharingManModel.edi_card_back == nil){//照片背面
        
        [self showAlertWithMessage:@"请选择身份证背面"];
        return;
        
    }
    
    if ([self.mySharingManModel.addr_city isEmptyStr] || [self.mySharingManModel.addr_provinces  isEmptyStr]) {
        
        [self showAlertWithMessage:@"请选择省市区"];
        
        return;
        
    }
    
    
    
    if ([self.mySharingManModel.addr_detail isEmptyStr] ) {
        
        [self showAlertWithMessage:@"请填写正确的详细地址"];
        
        return;
        
    }
    

    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    [[Ditiy_NetAPIManager sharedManager]request_RegisterSharingMan_WithParams:[self.mySharingManModel toRegisterParams] andBlock:^(id data, NSError *error) {
       
        
        if(data){
            
            [MBProgressHUD hideHUDForView:self.view];
            
            if([data[@"code"] integerValue] == 1){
                
                [MBProgressHUD showSuccess:@"注册成功"];
                
                
            }else{
                
                [MBProgressHUD showError:data[@"msg"]];
            }
            
        }else{
            
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"失败"];
        }
        
        
    }];
    
}



-(void)showAlertWithMessage:(NSString *)str{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:str message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:cancelAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


//选中照片按钮 响应
- (IBAction)frontButton_Action:(UIButton *)sender {
    
    
    sender.selected = YES;
    self.backButton.selected = NO;
    
    self.actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册获取",@"拍照", nil];
    
    [self.actionSheet showInView:self.view];
    
    
}


//选中照片按钮 响应
- (IBAction)backButton_Action:(UIButton *)sender {
    
    sender.selected = YES;
    self.frontButton.selected = NO;
    
    self.actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册获取",@"拍照", nil];
    
    [self.actionSheet showInView:self.view];
    
}

//选择省市区按钮 响应
- (IBAction)proviceCityArea_Action:(UIButton *)sender {
    
    
    
    ChooseAddressViewController *chooseVC = [[ChooseAddressViewController alloc]init];
    
    WS(ws)
    
    chooseVC.returnTextBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proId, NSString *cityId, NSString *areaId) {
        
        ws.proviceTextField.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
        
        self.mySharingManModel.addr_provinces = proId;
        self.mySharingManModel.addr_city = cityId;
        
        
    };
    
    [self.navigationController pushViewController:chooseVC animated:YES];
    
    
}



#pragma mark -- UIActionSheetDelegate -- start
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //从相册选择
            [self OpenLocalPhoto];
            break;
        case 1:
            //拍照
            [self takePhoto];
            break;
        default:
            break;
    }


    
}



#pragma mark -- UIActionSheetDelegate --end

-(void)takePhoto{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void)OpenLocalPhoto{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"imagePickerControllerDidCancel");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo{
    
    NSLog(@"didFinishPickingImage");
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {

        if (self.frontButton.selected) {
            
            [self.frontButton setImage:image forState:UIControlStateNormal];
            
            self.mySharingManModel.edi_card_face = image;
            
            
        }else{
            
            [self.backButton setImage:image forState:UIControlStateNormal];
            
            
            self.mySharingManModel.edi_card_back = image;
        }
    
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
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
