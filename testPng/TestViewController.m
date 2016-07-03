//
//  TestViewController.m
//  testPng
//
//  Created by 方武显 on 16/7/2.
//  Copyright © 2016年 小五哥学Swift. All rights reserved.
//

#import "TestViewController.h"
#import "Demo1Controller.h"
#import "Demo2Controller.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        Demo1Controller *vc1 = [sb instantiateViewControllerWithIdentifier:@"Demo1Controller"];
        [self.navigationController pushViewController:vc1 animated:YES];
    }
    if (indexPath.row == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        Demo2Controller *vc2 = [sb instantiateViewControllerWithIdentifier:@"Demo2Controller"];
        [self.navigationController pushViewController:vc2 animated:YES];

    }
}

@end
