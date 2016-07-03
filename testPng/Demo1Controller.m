//
//  ViewController.m
//  testPng
//
//  Created by 方武显 on 16/7/2.
//  Copyright © 2016年 小五哥学Swift. All rights reserved.
//

#import "Demo1Controller.h"
#import "DragView.h"

@interface Demo1Controller ()

@end

@implementation Demo1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    DragView *pic1 = [[DragView alloc]initWithImage:[UIImage imageNamed:@"0001.png"]];
    pic1.center = self.view.center;
    [self.view addSubview:pic1];
    
    DragView *pic2 = [[DragView alloc]initWithImage:[UIImage imageNamed:@"0002.png"]];
    pic2.center = self.view.center;
    [self.view addSubview:pic2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
