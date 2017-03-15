//
//  ZPUnlockView.h
//  手势密码解锁
//
//  Created by ios on 15-12-4.
//  Copyright (c) 2015年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZPUnlockView;
@protocol ZPUnlockViewDelegate <NSObject>

-(void)ZPUnlockView:(ZPUnlockView *)ZPUnlockView didFinishDraw:(NSString *)password;//完成手势绘制

@end


@interface ZPUnlockView : UIView


-(void)reset;

-(void)resetWrong;

@property (nonatomic,weak) id<ZPUnlockViewDelegate> delegate;

@end
