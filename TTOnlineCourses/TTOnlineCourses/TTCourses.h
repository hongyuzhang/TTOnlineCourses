//
//  TTCourses.h
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/16.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCourses : NSObject

@property (nonatomic,copy) NSNumber *ids;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *estimatedClassWorkload;
@property (nonatomic,copy) NSString *language;
@property (nonatomic,copy) NSString *aboutTheCourse;

+(instancetype)coursesWithDict:(NSDictionary *)dict;

@end
