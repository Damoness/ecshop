//
//  CurveView.h
//  LineView
//
//  Created by DongYifan on 6/2/16.
//  Copyright © 2016 vanille. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CurveView : UIView

@property (nonatomic, strong) IBInspectable UIColor* lineColor;
@property (nonatomic, assign) IBInspectable CGFloat scaleFactor;

@end
