//
//  RootViewController.m
//  JSCoreTest-1
//
//  Created by kong on 16/8/30.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ROOT PAGE";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pushAction:(id)sender {
    
    ViewController *VC = [[ViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
