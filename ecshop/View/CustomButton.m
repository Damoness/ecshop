//
//  CustomButton.m
//  ecshop
//
//  Created by 吴狄 on 2017/2/28.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "CustomButton.h"


@interface CustomButton ()

@property (nonatomic,strong) UILabel *badgeLabel;

@end


@implementation CustomButton
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat midX = self.frame.size.width / 2;
    CGFloat midY = self.frame.size.height/ 2 ;
    self.titleLabel.center = CGPointMake(midX, midY + 15);
    self.imageView.center = CGPointMake(midX, midY - 10);
    
    self.badgeLabel.center = CGPointMake(self.imageView.frame.size.width /2 +  self.imageView.center.x + 5  , self.imageView.center.y - self.imageView.frame.size.height /2  - 5);
    
}
-(void)setBgColor:(UIColor *)bgColor{
    
    _bgColor = bgColor;

}

-(void)setBadgeNo:(int)badgeNo{
    
    _badgeNo = badgeNo;

    [self updateBadgeLabel];
}

-(void)updateBadgeLabel{
    
    if (_badgeNo > 0) {
        
        self.badgeLabel.text = [NSString stringWithFormat:@"%d",_badgeNo];
        self.badgeLabel.hidden = false;
        
    }else{
        
        self.badgeLabel.hidden = true;
        
    }
    
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(void)setUp {
    
    NSLog(@"%@",self.titleLabel.text);
    
    self.backgroundColor = nil;
    self.opaque = NO;
    //self.contentMode = UIViewContentModeRedraw;
    
//    [self setBackgroundImage:[self imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    
//    self.layer.borderColor = RGB(226, 226, 226).CGColor;
//    self.layer.borderWidth = 0.5;
    
    
    [self setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
    //[self setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:UIControlStateSelected];
    
    _badgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - 15, 3, 15, 15)];

    _badgeLabel.layer.borderColor = kColor_Common_RedColor.CGColor;
    _badgeLabel.layer.cornerRadius = _badgeLabel.frame.size.height / 2 ;
    _badgeLabel.layer.borderWidth = 1.0;
    _badgeLabel.font = [UIFont systemFontOfSize:8];
    _badgeLabel.text = @"0";
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    _badgeLabel.textColor = kColor_Common_RedColor;
    
     [self addSubview:_badgeLabel];

     [self updateBadgeLabel];
   
}





@end
