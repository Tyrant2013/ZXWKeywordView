//
//  ViewController.m
//  ZXWKeywordView
//
//  Created by 庄晓伟 on 16/10/9.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ViewController.h"
#import "ZXWKeywordView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZXWKeywordView *view = [[ZXWKeywordView alloc] initWithKeywords:@[@"123", @"asdfasdf", @"是顺", @"2389", @"12344567jj9", @"asdfklasdfklasdjf", @"asdf209009i90"]];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
