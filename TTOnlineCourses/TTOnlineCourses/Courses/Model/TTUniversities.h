//
//  TTUniversities.h
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/16.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTUniversities : NSObject

@property (nonatomic,copy) NSNumber *ids;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray *courses;
@property (nonatomic,copy) NSString *shortName;

+(instancetype)universitiesWithDict:(NSDictionary *)dict;

@end
