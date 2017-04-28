//
//  ViewController.m
//  LYZCAAnaimationDemo
//
//  Created by artios on 2017/4/28.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView  *contentView;

@property (nonatomic, strong) CALayer *contentLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self lyz_configViews];
}

- (void)lyz_configViews{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.contentView                 = [[UIView alloc] init];
    self.contentView.frame           = CGRectMake(100, 200, 100, 100);
    self.contentView.layer.frame     = CGRectMake(100, 200, 100, 100);
    self.contentView.layer.position  = CGPointMake(150, 250);
    self.contentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.contentView];
    
    
    
    self.contentLayer                 = [CALayer layer];
    self.contentLayer.backgroundColor = [UIColor redColor].CGColor;
    self.contentLayer.bounds          = CGRectMake(100, 200, 100, 100);
    self.contentLayer.position        = CGPointMake(150, 250);
//    [self.view.layer addSublayer:self.contentLayer];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    /**如果要实现隐式动画需直接对self.contentLayer进行操作，对self.contentView.layer操作无效，可用UIView的动画实现跟layer隐式动画类似的效果**/
    
    /*
    [CATransaction begin];
    // 关闭隐式动画
    [CATransaction setDisableActions:NO];
    
     self.contentLayer.position = CGPointMake(300, 250);
    
    [CATransaction commit];
    */
    
//    [self lyz_basicAnimation];
    
//    [self lyz_keyframeAnimatin];
    
//    [self lyz_groupAnimation];
    
    [self lyz_groupAnimationQueue];
    
}

- (void)lyz_basicAnimation{
    
    CABasicAnimation *animation   = [CABasicAnimation animationWithKeyPath:@"position.x"];
    /**removedOnCompletion        = NO 并且 fillMode = kCAFillModeForwards 的时候动画执行完毕会停留在执行后的状态**/
    animation.removedOnCompletion = NO;
    animation.fillMode            = kCAFillModeForwards;
    
    animation.fromValue           = @(150);
    animation.toValue             = @(250);
    
    //动画是否按原路径返回
    animation.autoreverses        = YES;
    
    animation.duration            = 1;
    animation.repeatCount         = 10;
    
    [self.contentView.layer addAnimation:animation forKey:@"position"];
}

- (void)lyz_keyframeAnimatin{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    animation.values               = @[@(0),@(-1),@(0),@(1),@(0)];
    
    animation.repeatCount          = 10;
    animation.duration             = 1;
    
    animation.removedOnCompletion  = NO;
    animation.fillMode             = kCAFillModeForwards;
    
    [self.contentView.layer addAnimation:animation forKey:@"rotaion"];
}

- (void)lyz_groupAnimation{
    CABasicAnimation *basicAnimation   = [CABasicAnimation animationWithKeyPath:@"position.x"];
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode            = kCAFillModeForwards;
    basicAnimation.fromValue           = @(150);
    basicAnimation.toValue             = @(250);
    basicAnimation.autoreverses        = YES;
    basicAnimation.duration            = 2;
    
    
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    keyframeAnimation.values               = @[@(0),@(-1),@(0),@(1),@(0)];
    keyframeAnimation.duration             = 2;
    keyframeAnimation.removedOnCompletion  = NO;
    keyframeAnimation.fillMode             = kCAFillModeForwards;
    keyframeAnimation.autoreverses         = YES;
    
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations        = @[basicAnimation,keyframeAnimation];
    groupAnimation.repeatCount       = 5;
    groupAnimation.duration          = 3;
    
    [self.contentView.layer addAnimation:groupAnimation forKey:@"group"];
    
}

- (void)lyz_groupAnimationQueue{
    CABasicAnimation *basicAnimation   = [CABasicAnimation animationWithKeyPath:@"position.x"];
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode            = kCAFillModeForwards;
    basicAnimation.fromValue           = @(150);
    basicAnimation.toValue             = @(250);
    basicAnimation.autoreverses        = YES;
    basicAnimation.duration            = 1;
    basicAnimation.delegate            = self;
    [basicAnimation setValue:@"basic" forKey:@"type"];
    
    [self.contentView.layer addAnimation:basicAnimation forKey:@"position"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([[anim valueForKey:@"type"] isEqualToString:@"basic"]) {
        CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        keyframeAnimation.values               = @[@(0),@(-1),@(0),@(1),@(0)];
        keyframeAnimation.duration             = 1;
        keyframeAnimation.removedOnCompletion  = NO;
        keyframeAnimation.fillMode             = kCAFillModeForwards;
        keyframeAnimation.autoreverses         = YES;
        [self.contentView.layer addAnimation:keyframeAnimation forKey:@"rotaion"];
    }
}


/*
 transform.rotation.x //以x轴为中心旋转
 transform.rotation.y //以y轴为中心旋转
 transform.rotation.z //以z轴为中心旋转
 transform.scale.x //缩放x轴方向
 transform.scale.y //缩放y轴方向
 transform.scale.z //缩放z轴方向，这个一般不会用到。
 transform.scale //x，y方向整体缩放，z方向没看到效果。
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
