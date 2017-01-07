//
//  Util.m
//  ecshop
//
//  Created by 吴狄 on 2017/1/7.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "Util.h"

@implementation Util


+(UIImage *)captureView:(UIView*)view{
    
    UIGraphicsBeginImageContext(view.bounds.size);
    //获取图像
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



@end
