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

@end

@implementation ViewController

-(CAShapeLayer *)shapL{
    
    if(_shapL == nil){
        //形状图层(可以根据一个路径,生成一个形状.)
        CAShapeLayer *shap = [CAShapeLayer layer];
        shap.fillColor = [UIColor blackColor].CGColor;
        [self.anView.layer insertSublayer:shap atIndex:0];
        _shapL = shap;
    }
    return  _shapL;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    UIView *anView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 1)];
    anView.backgroundColor = [UIColor redColor];
    _anView = anView;

//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.colors = @[  (id)[UIColor greenColor].CGColor , (id)[UIColor blueColor].CGColor ];
//    gradient.frame = anView.bounds;
//    
//    gradient.locations = @[@(0.1) , @(0.6)];
//    gradient.startPoint = CGPointMake(0, 0);
//    gradient.endPoint = CGPointMake(0, 1);
//    
//    gradient.type = kCAGradientLayerAxial;
//    
//    [anView.layer addSublayer:gradient];
//    _gradient = gradient;
    
    anView.layer.masksToBounds = YES;
    
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
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -65);
    }
    
   CGPoint curpoint = [scrollView.panGestureRecognizer translationInView:scrollView];
    
    NSLog(@"%f",curpoint.y);
    
    if (curpoint.y <100) {
        self.shapL.path = ([self pathWithH:(curpoint.y / 100 *100)]).CGPath;
        _anView.height =  curpoint.y / 100 *100 ;
        _gradient.frame = CGRectMake(0, 0, self.view.frame.size.width, _anView.height);
    }
}

//给定两个圆,返回一个不规则的路径
- (UIBezierPath *)pathWithH :(CGFloat) h
{
    

    
    CGPoint pointA = CGPointMake(0, 0);
    CGPoint pointB = CGPointMake(self.view.frame.size.width, 0);
    CGPoint pointP = CGPointMake(self.view.frame.size.width/2, 0 + h);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //AB
    //[path moveToPoint:pointA];
    //[path addLineToPoint:pointB];
    [path moveToPoint:CGPointMake(0, 0)];
    
    //[aPath addQuadCurveToPoint:CGPointMake(120, 100) controlPoint:CGPointMake(70, 0)];
    //曲线
    //BC
    [path addQuadCurveToPoint:pointB controlPoint:pointP];
    
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
        _anView.height = 1;

        _gradient.frame = CGRectMake(0, 0, self.view.frame.size.width, _anView.height);

        _shapL.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.view.frame.size.width, 1)].CGPath;
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
