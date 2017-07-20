//
//  ViewController.m
//  ShopAnmationDemo
//
//  Created by lvshasha on 2017/7/20.
//  Copyright © 2017年 com.SmallCircle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick
{
    // 创建layer
    CAShapeLayer *anmationLayer = [[CAShapeLayer alloc] init];
    anmationLayer.frame = CGRectMake(100, 100, 40, 40);
    UIImage *image = [UIImage imageNamed:@"image01"];
    anmationLayer.contents = (id)image.CGImage;
    
    //
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    UIViewController *paretVC = rootVC;
    while ((paretVC = rootVC.presentedViewController) != nil) {
        rootVC = paretVC;
    }
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    // 添加layer到顶层视图控制器
    [rootVC.view.layer addSublayer:anmationLayer];
    
    // 创建移动轨迹
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:CGPointMake(100, 100)];
    [movePath addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(200, 100)];
    // 动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat duration = 1;
    pathAnimation.duration = duration;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.path = movePath.CGPath;
    // 创建缩小动画
    CABasicAnimation *scaleAnmaion = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnmaion.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnmaion.toValue = [NSNumber numberWithFloat:0.5];
    scaleAnmaion.duration = 1.0;
    scaleAnmaion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scaleAnmaion.removedOnCompletion = NO;
    scaleAnmaion.fillMode = kCAFillModeForwards;
    
    // 添加轨迹动画
    [anmationLayer addAnimation:pathAnimation forKey:nil];
    // 添加缩小动画
    [anmationLayer addAnimation:scaleAnmaion forKey:nil];
    
    // 动画结束后执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [anmationLayer removeFromSuperlayer];
    });
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
