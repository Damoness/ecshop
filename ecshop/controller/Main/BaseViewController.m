//
//  BaseViewController.m
//  ecshop
//
//  Created by jsyh-mac on 15/11/30.
//  Copyright © 2015年 jsyh. All rights reserved.
//

#import "BaseViewController.h"


#define kColor_BaseView

@interface BaseViewController ()

@end

@implementation BaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColor_UIView_BackgroundColor ;
    
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