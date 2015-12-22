//
//  TTDetailController.m
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/16.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import "TTDetailController.h"
#import "UIImageView+WebCache.h"
@interface TTDetailController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageShow;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workLoadLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UITextView *aboutTheCourseTextView;

@end

@implementation TTDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

}

-(void)setupUI{
    
    [self.imageShow sd_setImageWithURL:[NSURL URLWithString:self.course.icon] placeholderImage:[UIImage imageNamed:@"bigimage.png"]];
    
    self.courseNameLabel.text = self.course.name;
    
    self.workLoadLabel.text = self.course.estimatedClassWorkload;
    
    self.languageLabel.text = self.course.language;
    
    self.aboutTheCourseTextView.text = self.course.aboutTheCourse;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
