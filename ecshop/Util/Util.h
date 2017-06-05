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


+ (UIImage *)imageWithColor:(UIColor *)color;

#define k3DES_Ditiy_Key  @"www.ditiy.com/penngoh?#@"

//3DES加密

/**
 3DES加密

 @param plainText 需要加密的内容
 @param key 加密key
 @return <#return value description#>
 */
+(NSString*)tripleDES_Encrypt:(NSString*)plainText withKey:(NSString *)key;

//3DES解密

/**
 3DES解密

 @param encryptText 密文
 @param key 解密key
 @return <#return value description#>
 */
+(NSString*)tripleDES_Decrypt:(NSString*)encryptText withKey:(NSString *)key;



// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;
// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

@end
