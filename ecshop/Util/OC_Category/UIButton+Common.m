//
//  UIButton+Common.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/5.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "UIButton+Common.h"

@implementation UIButton (Common)


- (void)verticalImageAndTitle:(CGFloat)spacing
{
    //self.titleLabel.backgroundColor = [UIColor greenColor];
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

-(void)verticalImageAndTitle2:(CGFloat)spacing{
    
    CGFloat midX = self.frame.size.width / 2;
    CGFloat midY = self.frame.size.height/ 2 ;
    self.titleLabel.center = CGPointMake(midX, midY + spacing/2);
    self.imageView.center = CGPointMake(midX, midY - spacing/2);
    
    [self layoutSubviews];
    
}

@end
