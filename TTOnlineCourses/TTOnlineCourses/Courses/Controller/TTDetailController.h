//
//  TTDetailController.h
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/16.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTCourses.h"
#import "TTUniversities.h"
@interface TTDetailController : UIViewController

// 大学模型
@property (nonatomic,strong) TTUniversities *university;

// 课程模型
@property (nonatomic,strong) TTCourses *course;

@end
