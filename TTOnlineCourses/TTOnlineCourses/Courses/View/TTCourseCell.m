//
//  TTCourseCell.m
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/16.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import "TTCourseCell.h"
#import "UIImageView+WebCache.h"

@interface TTCourseCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workloadLabel;

@end

@implementation TTCourseCell

#pragma mark 设置cell
-(void)setCourse:(TTCourses *)course{
    
    _course = course;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:course.icon] placeholderImage:[UIImage imageNamed:@"smallImage.png"]];
    
    self.icon.layer.cornerRadius = 40;
    
    self.icon.clipsToBounds = YES;
    
    self.courseNameLabel.text = course.name;
    
    self.workloadLabel.text = course.estimatedClassWorkload;
}


@end
