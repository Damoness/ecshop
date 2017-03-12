//
//  MyTabBarViewController.h
//  ecshop
//
//  Created by jsyh-mac on 15/11/30.
//  Copyright © 2015年 jsyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabBarViewController : UITabBarController

-(void)hideCustomTabbar:(BOOL)hiden; //隐藏定制的tabBar

-(void)buttonClicked:(UIButton *)button; //


-(void)selectButtonWithIndex:(NSInteger)index; //选中第几个button


@end
