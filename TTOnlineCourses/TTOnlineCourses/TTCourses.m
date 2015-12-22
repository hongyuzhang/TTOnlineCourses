//
//  TTCourses.m
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/16.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import "TTCourses.h"

@implementation TTCourses

#pragma mark TTCourses 的模型转字典
+(instancetype)coursesWithDict:(NSDictionary *)dict{

    TTCourses *courses = [[TTCourses alloc] init];
    
    courses.ids = dict[@"id"];
    
    courses.name = dict[@"name"];
    
    courses.icon = dict[@"smallIcon"];
    
    courses.language = dict[@"language"];
    
    courses.estimatedClassWorkload = dict[@"estimatedClassWorkload"];
    
    courses.aboutTheCourse = dict[@"aboutTheCourse"];
    
    return courses;
}

@end
