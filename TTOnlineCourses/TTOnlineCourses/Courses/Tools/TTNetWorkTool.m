//
//  TTNetWorkTool.m
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/21.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import "TTNetWorkTool.h"
#import "TTBounceSpot.h"
#import "TTUniversities.h"
#import "TTCourses.h"

@implementation TTNetWorkTool

#pragma mark 设置网络请求类工具的单例
+(instancetype)sharedNetWorkTool{
    
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        
    });
    
    return _instance;
}


#pragma mark 加载所有学校的数据及每个学校的所有课程!
-(void)loadCourseraWithURLString:(NSString *)URLString success:(successBlock)success fail:(failBlock)fail{
    
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSURLRequest *rerquest = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:rerquest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [[TTBounceSpot sharedBounceSpot] removeAnimation];
        
        [NSThread sleepForTimeInterval:0.5];
        
        if (data.length && !error) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSMutableArray *universityArr = dict[@"elements"];
            
            [universityArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                TTUniversities *university = [TTUniversities universitiesWithDict:obj];
                
                [university.courses enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    NSNumber *ids = obj;
                    
                    [self loadingCoursesDataWithString:ids success:(successBlock)success fail:(failBlock)fail];
                }];
                
                [self.universityArr addObject:university];
            }];
            
            if (success) {
                success(data,response);
            }
            
        }else if (error){
            
            if (fail) {
                fail(error);
            }
        }
    }] resume];
}


#pragma mark 加载每个课程的信息
- (void)loadingCoursesDataWithString:(NSNumber *)ids success:(successBlock)success fail:(failBlock)fail{
    
    NSString *URCourses = [NSString stringWithFormat:@"https://api.coursera.org/api/catalog.v1/courses?fields=estimatedClassWorkload,smallIcon,language,aboutTheCourse&ids=%@",ids];
    
    NSURL *url = [NSURL URLWithString:URCourses];
    
    NSURLRequest *rerquest = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:rerquest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data.length) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSArray *coursesArr = dict[@"elements"];
            
            [coursesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                TTCourses *course = [TTCourses coursesWithDict:obj];
                
                [self.coursesDict setObject:course forKey:ids];
            }];
            
            if (success) {
                success(data,response);
            }
            
        }else if (error){
            
            if (fail) {
                fail(error);
            }
        }
        
    }] resume];
}

#pragma mark 懒加载字典，包含所有课程
-(NSMutableDictionary *)coursesDict{
    
    if (!_coursesDict) {
        
        _coursesDict = [NSMutableDictionary dictionary];
    }
    
    return _coursesDict;
}

#pragma mark 懒加载数组，包含所有学校
-(NSMutableArray *)universityArr{
    
    if (!_universityArr) {
        
        _universityArr = [NSMutableArray array];
    }
    
    return _universityArr;
}


@end
