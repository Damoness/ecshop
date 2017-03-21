//
//  VerifyPhoneCodeViewController.h
//  ecshop
//
//  Created by 吴狄 on 2017/3/21.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "BaseViewController.h"


typedef void (^NextBlock)();

@interface VerifyPhoneCodeViewController : BaseViewController


@property (nonatomic,strong)NextBlock nextBlock;


@end
