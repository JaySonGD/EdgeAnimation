//
//  ViewController.m
//  边缘动画
//
//  Created by czljcb on 16/2/21.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import "loadingView.h"

@interface ViewController ()

/** <##> */
@property (nonatomic, weak) UIView *anView;
@property (nonatomic, weak) UIView *anView1;

@property (nonatomic ,weak)CAShapeLayer *shapL1;

@end

@implementation ViewController


-(CAShapeLayer *)shapL1{
    
    if(_shapL1 == nil){
        [[UIColor redColor] setStroke]; // stroke 画线的意思，也就是画笔的笔头颜色
        
        //形状图层(可以根据一个路径,生成一个形状.)
        CAShapeLayer *shap = [CAShapeLayer layer];
        //shap.fillColor = [UIColor colorWithRed:187/255.0 green:222/255.0 blue:231/255.0 alpha:1].CGColor;
        shap.fillColor = [UIColor colorWithRed:84/255.0 green:184/255.0 blue:213/255.0 alpha:1].CGColor;

        
        shap.lineCap = kCALineCapRound;
        [self.anView1.layer insertSublayer:shap atIndex:1];
        _shapL1 = shap;
    }
    return  _shapL1;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    


    UIView *anView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 0)];
    _anView1 = anView1;

    anView1.layer.shadowOffset= CGSizeMake(0, 5);
    anView1.layer.shadowOpacity = 1;
    anView1.layer.shadowRadius = 5;
    anView1.layer.shadowColor = [UIColor colorWithRed:126/255.0 green:192/255.0 blue:231/255.0 alpha:1].CGColor;

    
    
    [self.parentViewController.view addSubview:anView1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y <= -65) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -64);
        
    }
    
   CGPoint curpoint = [scrollView.panGestureRecognizer translationInView:scrollView];
    [self.shapL1 removeAllAnimations];
    if (curpoint.y <100 && curpoint.y > 0){
        self.shapL1.path = ([self pathWithH:(curpoint.y / 100 *10)]).CGPath;

        _anView1.height =  curpoint.y / 100 *10 ;

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

    //BC
    [path addQuadCurveToPoint:pointA controlPoint:pointP];
    
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

        _anView1.height = 0;
 


    //1.初始化一个核心动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    //2.设置属性值.
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0.0;
    anim.duration = 0.25;
    //设置执行完毕,不要删除动画
    anim.removedOnCompletion = NO;
    //设置让动画效果最后执行样子
    anim.fillMode = kCAFillModeForwards;
    //3.添加动画
    [self.shapL1 addAnimation:anim forKey:nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}



@end
