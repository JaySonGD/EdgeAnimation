//
//  loadingView.m
//  边缘动画
//
//  Created by czljcb on 16/2/22.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "loadingView.h"

@implementation loadingView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
 //    //画矩形
 //    //1.获取上下文
    CGContextRef ctx  = UIGraphicsGetCurrentContext();
 //2.描述路径
 //UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 100, 100)];
    
    CGPoint pointA = CGPointMake(50, 0);
    CGPoint pointB = CGPointMake([UIScreen mainScreen].bounds.size.width-50, 0);
    CGPoint pointP = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 100);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    //[path moveToPoint:pointA];
    
    //[aPath addQuadCurveToPoint:CGPointMake(120, 100) controlPoint:CGPointMake(70, 0)];
    //曲线
    //BC
    [path addQuadCurveToPoint:pointA controlPoint:pointP];
 //3.添加路径到上下文
     CGContextAddPath(ctx, path.CGPath);
     //4.渲染路径(stroke描边路径 fill:填充路径)
     //CGContextStrokePath(ctx);
    
    
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[[UIColor orangeColor] CGColor], nil]];
    
    [gradientLayer setLocations:@[@0.1,@0.5]];
    
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    
    [gradientLayer setEndPoint:CGPointMake(1, 1)];
    
    [self.layer addSublayer:gradientLayer];
    
    [[UIColor redColor] set];
    [path addClip];
//
     CGContextFillPath(ctx);
}


@end
