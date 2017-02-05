//
//  NewAddressViewController.h
//  ecshop
//
//  Created by Jin on 15/12/21.
//  Copyright © 2015年 jsyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@interface NewAddressViewController : UIViewController
@property(nonatomic,strong)NSDictionary *tempDic;
@property (nonatomic,strong)NSString *tempId;
@property (nonatomic,strong)AddressModel *revisedModel; //需要修改的地址model
@end
