//
//  TTNetWorkTool.h
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/21.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @param SuccessBlock 成功回调的 Block
 *  @param failBlock    失败回调的 Block
 */
typedef void(^successBlock)(NSData *data, NSURLResponse *response);
typedef void(^failBlock)(NSError *error);


@interface TTNetWorkTool : NSObject

// 使用可变字典保存所有课程
@property (nonatomic,strong) NSMutableDictionary *coursesDict;

// 使用可变数组保存所有大学
@property (nonatomic,strong) NSMutableArray *universityArr;

// 对外提供获取单例的类方法
+(instancetype)sharedNetWorkTool;

// 网络请求大学、课程数据的实例方法
-(void)loadCourseraWithURLString:(NSString *)URLString success:(successBlock)success fail:(failBlock)fail;

@end
