//
//  TTCoursesController.m
//  TTOnlineCourses
//
//  Created by 张洪毓 on 15/12/16.
//  Copyright © 2015年 张洪毓. All rights reserved.
//

#import "TTCoursesController.h"
#import "TTCourses.h"
#import "TTUniversities.h"
#import "TTCourseCell.h"
#import "TTDetailController.h"
#import "UIImageView+WebCache.h"
#import "TTBounceSpot.h"
#import "SVProgressHUD.h"
#import "TTNetWorkTool.h"

@interface TTCoursesController ()

@end

@implementation TTCoursesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepare];
}

#pragma mark 准备工作
-(void)prepare{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[TTBounceSpot sharedBounceSpot] addAnimationOnLayer:self.view.layer withColor:[UIColor darkGrayColor] withSize:CGSizeMake(80, 80)];
    
    NSString *URLUniversities = @"https://api.coursera.org/api/catalog.v1/universities?fields=name&includes=courses";
    
    [[TTNetWorkTool sharedNetWorkTool] loadCourseraWithURLString:URLUniversities success:^(NSData *data, NSURLResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } fail:^(NSError *error) {
        
    }];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [TTNetWorkTool sharedNetWorkTool].universityArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    TTUniversities *university = [TTNetWorkTool sharedNetWorkTool].universityArr[section];
    
    return university.courses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TTCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"course" forIndexPath:indexPath];
    
    TTUniversities *university = [TTNetWorkTool sharedNetWorkTool].universityArr[indexPath.section];
    
    NSNumber *tempid = university.courses[indexPath.row];
    
    TTCourses *course = [[TTNetWorkTool sharedNetWorkTool].coursesDict objectForKey:tempid];
    
    cell.course = course;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    TTUniversities *university = [TTNetWorkTool sharedNetWorkTool].universityArr[section];
    
    return university.name;
}


#pragma mark - Table view dalegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TTUniversities *university = [TTNetWorkTool sharedNetWorkTool].universityArr[indexPath.section];
    
    NSNumber *tempid = university.courses[indexPath.row];
    
    TTCourses *course = [[TTNetWorkTool sharedNetWorkTool].coursesDict objectForKey:tempid];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"TTDetail" bundle:nil];
    
    TTDetailController *detailVC = sb.instantiateInitialViewController;
    
    detailVC.course = course;
    
    detailVC.university = university;
    
    detailVC.title = university.name;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark 设置 cell 的组头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    
    if (sectionTitle==nil) { return nil; }

    UILabel *label = [[UILabel alloc] init];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.frame = CGRectMake(0, 2, tableView.bounds.size.width, 22);
    
    label.backgroundColor = [UIColor clearColor];
    
    label.textColor = [UIColor redColor];
    
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
    label.text = sectionTitle;
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)];

    [sectionView setBackgroundColor:[UIColor colorWithRed:100/255.0 green:176/255.0 blue:47/255.0 alpha:1]];
    
    [sectionView addSubview:label];
    
    return sectionView;
}


#pragma mark 处理内存告警
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
}

@end
