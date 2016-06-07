//
//  ViewController.m
//  YWProgressHUD
//
//  Created by yanyuewen on 16/5/30.
//  Copyright © 2016年 yanyuewen. All rights reserved.
//

#import "ViewController.h"
#import "YWProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"show" style:UIBarButtonItemStylePlain target:self action:@selector(showHud)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"hide" style:UIBarButtonItemStylePlain target:self action:@selector(hideHud)];
}

- (void)showHud {

    [YWProgressHUD showHUD:self.view text:@"正在提交..." animated:YES];

}

- (void)hideHud {

    [YWProgressHUD hideAllHUD:self.view animated:YES];
}

@end
