//
//  HYMianTableViewController.m
//  RuntimeBase
//
//  Created by 杨小雨 on 2017/2/13.
//  Copyright © 2017年 杨小雨. All rights reserved.
//

#import "HYMianTableViewController.h"
#import "HYTXViewController.h"
#import "HYJRViewController.h"
#import "HYWYViewController.h"
#import "HYXMViewController.h"
@interface HYMianTableViewController ()

@property(nonatomic, strong) NSArray *demosArr;
@end

@implementation HYMianTableViewController

- (NSArray *)demosArr {
    if (!_demosArr) {
        _demosArr = @[@"腾讯",@"今日头条",@"网易",@"喜马拉雅"];
    }
    return _demosArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demosArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.demosArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewController *vc;
    switch (indexPath.row) {
        case 0:
            vc = (UITableViewController *)[[HYTXViewController alloc] init];
            break;
        case 1:
            vc = (UITableViewController *)[[HYJRViewController alloc] init];
             break;
        case 2:
            vc = (UITableViewController *)[[HYWYViewController alloc] init];
             break;
        case 3:
            vc = (UITableViewController *)[[HYXMViewController alloc] init];
             break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}




@end
