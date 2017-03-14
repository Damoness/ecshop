//
//  ZPUnlockView.h
//  手势密码解锁
//
//  Created by ios on 15-12-4.
//  Copyright (c) 2015年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZPUnlockViewDelegate <NSObject>

-(void)ZPUnlockViewDidFinishUnlock:(NSString *)password; //完成解锁

@end


@interface ZPUnlockView : UIView

@property (nonatomic,weak) id<ZPUnlockViewDelegate> delegate;

@end
