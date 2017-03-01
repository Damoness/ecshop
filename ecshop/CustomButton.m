//
//  CustomButton.m
//  ecshop
//
//  Created by 吴狄 on 2017/2/28.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}


-(void)setBgColor:(UIColor *)bgColor{
    
    _bgColor = bgColor;
    
    //self set
}

-(void)setUp {
    self.backgroundColor = nil;
    self.opaque = NO;
    //self.contentMode = UIViewContentModeRedraw;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}



@end
