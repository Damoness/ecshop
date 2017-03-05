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
@interface MyViewController ()


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonArray;


@property (weak, nonatomic) IBOutlet CustomButton *unpayButton;
@property (weak, nonatomic) IBOutlet CustomButton *undispatchedButton;
@property (weak, nonatomic) IBOutlet CustomButton *unreceivedButton;
@property (weak, nonatomic) IBOutlet CustomButton *finishedButton;


@property (weak, nonatomic) IBOutlet CustomButton *myShareButton;

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

}

-(void)initViews{
    

    //self.unpayButton.badgeNo = 3;
    
}

- (IBAction)ddd:(CustomButton *)sender {
    
    //
    
}

- (IBAction)myShare_Action:(CustomButton *)sender {
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)myOrder_Action:(CustomButton *)sender {
    
    
    
    
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
