//
//  ViewController.m
//  边缘动画
//
//  Created by czljcb on 16/2/21.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"

@interface ViewController ()

/** <##> */
@property (nonatomic, weak) UIView *anView;
/** <##> */
@property (nonatomic, weak) CAGradientLayer *gradient;

@property (nonatomic ,weak)CAShapeLayer *shapL;

/** <##> */
@property (nonatomic, weak)    CALayer * grain ;
@end

@implementation ViewController

-(CAShapeLayer *)shapL{
    
    if(_shapL == nil){
        [[UIColor redColor] setStroke]; // stroke 画线的意思，也就是画笔的笔头颜色

        //形状图层(可以根据一个路径,生成一个形状.)
        CAShapeLayer *shap = [CAShapeLayer layer];
        shap.fillColor = [UIColor clearColor].CGColor;
        shap.strokeColor=[UIColor redColor].CGColor;

        shap.lineCap = kCALineCapRound;
        [self.anView.layer insertSublayer:shap atIndex:1];
        _shapL = shap;
    }
    return  _shapL;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    UIView *anView = [[UIView alloc] initWithFrame:CGRectMake(0, 164, self.view.frame.size.width, 100)];
    _anView = anView;
    anView.backgroundColor = [UIColor redColor];


    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    _grain = gradientLayer;
    gradientLayer.frame = _anView.bounds;
    
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[[UIColor orangeColor] CGColor], nil]];
    
    [gradientLayer setLocations:@[@0.1,@0.5]];
    
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    
    [gradientLayer setEndPoint:CGPointMake(1, 1)];

    //用progressLayer来截取渐变层 遮罩
    //[gradientLayer setMask:_shapL];
    [_anView.layer addSublayer:gradientLayer];
    
    NSLog(@"%@",self.parentViewController);
    
    [self.parentViewController.view addSubview:anView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   // NSLog(@"%f",scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y <= -65) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -64);
    }
    
   CGPoint curpoint = [scrollView.panGestureRecognizer translationInView:scrollView];
    
    if (curpoint.y <100 && curpoint.y > 0) {
        self.shapL.path = ([self pathWithH:(curpoint.y / 100 *100)]).CGPath;
        _anView.height =  curpoint.y / 100 *100 ;
        
        _gradient.frame = _anView.bounds;
        _grain.frame = _gradient.bounds;
    }
}

//给定两个圆,返回一个不规则的路径
- (UIBezierPath *)pathWithH :(CGFloat) h
{
    

    
    CGPoint pointA = CGPointMake(50, 0);
    CGPoint pointB = CGPointMake(self.view.frame.size.width-50, 0);
    CGPoint pointP = CGPointMake(self.view.frame.size.width/2, 0 + h);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    //[path moveToPoint:pointA];
    
    //[aPath addQuadCurveToPoint:CGPointMake(120, 100) controlPoint:CGPointMake(70, 0)];
    //曲线
    //BC
    [path addQuadCurveToPoint:pointA controlPoint:pointP];
    
    //CD
    //[path addLineToPoint:pointD];
    //曲线
    //DA
    //[path addQuadCurveToPoint:pointA controlPoint:pointO];
    //[path addClip];
    return path;
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"%s", __func__);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

 -(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"%s", __func__);
    [UIView animateWithDuration:0.55 animations:^{
        _anView.height = 0;

        _gradient.frame = _anView.bounds;

        _shapL.path = [UIBezierPath bezierPathWithRect:_anView.bounds].CGPath;
    }];
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}



@end
