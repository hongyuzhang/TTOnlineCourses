//
//  TTBounceSpot.h
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/21.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface TTBounceSpot : CAReplicatorLayer

// 单例获取等待动画的图层
+(instancetype)sharedBounceSpot;

// 添加等待动画图层
- (void)addAnimationOnLayer:(CALayer *)layer withColor:(UIColor *)color withSize:(CGSize)size;

//移除等待动画图层
- (void)removeAnimation;

@end
