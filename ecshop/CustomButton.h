//
//  CustomButton.h
//  ecshop
//
//  Created by 吴狄 on 2017/2/28.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE
@interface CustomButton : UIButton

//IBInspectable
@property (nonatomic, strong) IBInspectable UIColor *bgColor;


@property (nonatomic, assign) IBInspectable int badgeNo;

@end
