//
//  Demo2Controller.m
//  testPng
//
//  Created by 方武显 on 16/7/2.
//  Copyright © 2016年 小五哥学Swift. All rights reserved.
//

#import "Demo2Controller.h"
#import "DragView2.h"

@interface Demo2Controller ()

@end

@implementation Demo2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
   
   DragView2 *drag3 = [[DragView2 alloc]initWithImage:[UIImage imageNamed:@"0003.png"]];
    drag3.center = self.view.center;
    [self.view addSubview:drag3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
