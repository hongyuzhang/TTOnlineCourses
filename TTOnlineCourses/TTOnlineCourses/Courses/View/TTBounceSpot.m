//
//  TTBounceSpot.m
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/21.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import "TTBounceSpot.h"
#define kAnimaDuration 0.8


@interface TTBounceSpot ()

@property (nonatomic,strong) CALayer *spotLayer;
@property (nonatomic,assign) BOOL isAnimating;

@end

@implementation TTBounceSpot

#pragma mark 单例模式
+(instancetype)sharedBounceSpot{
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark 添加等待的图层动画
- (void)addAnimationOnLayer:(CALayer *)layer withColor:(UIColor *)color withSize:(CGSize)size{
    
    self.frame = CGRectMake(0, 0, size.width, size.height);
    
    self.position = CGPointMake(layer.bounds.size.width*0.5,layer.bounds.size.height*0.4);
    
    self.backgroundColor = [UIColor clearColor].CGColor;
    
    [layer addSublayer:self];
    
    NSInteger numOfDot = 6;
    
    self.instanceCount = numOfDot;
    
    self.instanceTransform = CATransform3DMakeTranslation(size.width/5, 0, 0);
    
    self.instanceDelay = kAnimaDuration/numOfDot;
    
    [self addCyclingSpotAnimationLayerOnLayer:self withColor:color withSize:size];
}

#pragma mark 添加点图层及动画
- (void)addCyclingSpotAnimationLayerOnLayer:(CALayer *)layer withColor:(UIColor *)color withSize:(CGSize)size{
    
    CGFloat radius = size.width/6;
    
    self.spotLayer = [CALayer layer];
    
    self.spotLayer.bounds = CGRectMake(0, 0, radius, radius);
    
    self.spotLayer.position = CGPointMake(radius/2, size.height/2);
    
    self.spotLayer.cornerRadius = radius/2;
    
    self.spotLayer.backgroundColor = color.CGColor;
    
    self.spotLayer.transform = CATransform3DMakeScale(0.2, 0.2, 0.2);
    
    [layer addSublayer:self.spotLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue = @0.2;
    
    animation.toValue = @1;
    
    animation.duration = kAnimaDuration;
    
    animation.autoreverses = YES;
    
    animation.repeatCount = CGFLOAT_MAX;
    
    [self.spotLayer addAnimation:animation forKey:@"animation"];
    
    self.isAnimating = YES;
}

#pragma mark 移除动画的等待图层
- (void)removeAnimation{
    
    if (self.isAnimating == YES) {
        
        self.isAnimating = NO;
        
        [self.spotLayer removeAnimationForKey:@"animation"];
        
        [self.spotLayer removeFromSuperlayer];
        
        [self removeFromSuperlayer];
    }
}





@end
