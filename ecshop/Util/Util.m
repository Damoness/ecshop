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



+ (NSString *)imageBase64WithDataURL:(UIImage *)image
{
    NSData *imageData =nil;
    NSString *mimeType =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x =100 / image.size.height;
    if (x >1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, x);
    mimeType = @"image/jpeg";
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions:0]];
}


@end
