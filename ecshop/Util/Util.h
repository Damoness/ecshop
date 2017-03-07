//
//  Util.h
//  ecshop
//
//  Created by 吴狄 on 2017/1/7.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Util : NSObject


+(UIImage *)captureView:(UIView*)view;


+(NSString *)imageBase64WithDataURL:(UIImage *)image;


+(NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

@end
