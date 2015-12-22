//
//  TTUniversities.m
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/16.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import "TTUniversities.h"

@interface TTUniversities ()

@property (nonatomic,strong) NSDictionary *links;

@end

@implementation TTUniversities


#pragma mark TTUniversities 的模型转字典
+(instancetype)universitiesWithDict:(NSDictionary *)dict{
    
    TTUniversities *university = [[TTUniversities alloc] init];
    
    university.ids = dict[@"id"];
    
    university.name = dict[@"name"];
    
    university.shortName = dict[@"shortName"];
    
    university.links = dict[@"links"];
    
    university.courses = university.links[@"courses"];
    
    return university;
}

@end
