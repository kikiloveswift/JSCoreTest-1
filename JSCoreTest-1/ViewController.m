//
//  ViewController.m
//  JSCoreTest-1
//
//  Created by kong on 16/8/29.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
{
    //示例WebView
    UIWebView *testWebView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ROOT PAGE";
    [self initUI];
}

- (void)initUI
{
    testWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    testWebView.delegate = self;
    NSString *urlString = @"http://172.16.205.108:8080/JSCoreTest/index.html";
    [testWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [self.view addSubview:testWebView];
}

@end
