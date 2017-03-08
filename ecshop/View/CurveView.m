//
//  CurveView.m
//  LineView
//
//  Created by DongYifan on 6/2/16.
//  Copyright © 2016 vanille. All rights reserved.
//

#import "CurveView.h"

@implementation CurveView {
    NSArray<NSValue*> * points;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp {
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

-(void)setScaleFactor:(CGFloat)scaleFactor {
    _scaleFactor = scaleFactor;
    [self createCurve];
    [self setNeedsDisplay];
}

-(CGFloat) minLengthOfBound {
    return MIN(self.bounds.size.width, self.bounds.size.height);
}


-(void) drawParamter {
    
    UIFont * paramFont = [UIFont systemFontOfSize:[self minLengthOfBound] / 20];
    NSAttributedString *paramText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"scale = %.2f", self.scaleFactor]
                                                                    attributes:@{NSFontAttributeName : paramFont,
                                                                                 NSForegroundColorAttributeName : [UIColor redColor]}];
    [paramText drawAtPoint: CGPointMake([self minLengthOfBound] / 15, [self minLengthOfBound] / 15)];
}


-(void) createCurve {
    NSMutableArray<NSValue*> * a = [NSMutableArray array];
    for (CGFloat x = -[self minLengthOfBound]; x <= [self minLengthOfBound] ; ++x) {
        CGFloat r = x * M_PI / 180;
        CGFloat y = self.scaleFactor * sin(2 * r);
        CGPoint pt = CGPointMake(x, y);
        [a addObject:[NSValue valueWithCGPoint:pt]];
    }
    points = a;
}

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath * roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self minLengthOfBound] / 20];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    UIBezierPath * round = [[UIBezierPath alloc] init];
    [round addArcWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:[self minLengthOfBound] / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    round.lineWidth = 1.0;
    [round stroke];
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, rect.size.width / 2, rect.size.height / 2);
    UIBezierPath * path = [[UIBezierPath alloc] init];
    path.lineWidth = 1.0;
    [path moveToPoint:[points[0] CGPointValue]];
    [points enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            CGPoint pt = [obj CGPointValue];
            [path addLineToPoint:pt];
        }
        
    }];
    
    [self.lineColor setStroke];
    [path stroke];
    CGContextRestoreGState(context);
    
    CGContextSetShadowWithColor(context, CGSizeMake(0, 5), 5.0, [[UIColor blackColor]CGColor]);
    [self drawParamter];
    CGContextTranslateCTM(context, self.bounds.size.width,self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [self drawParamter];
    
}

@end
