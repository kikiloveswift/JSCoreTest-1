//
//  ViewController.m
//  JSCoreTest-1
//
//  Created by kong on 16/8/29.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>
{
    //示例WebView
    UIWebView *testWebView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"First PAGE";
    [self initUI];
}

- (void)initUI
{
    testWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    testWebView.delegate = self;
    NSString *urlString = @"http://192.168.0.8:8080/JSCoreTest-1/index.html";
    [testWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [self.view addSubview:testWebView];
}

#pragma mark-DidFinishLoad---WebView加载结束
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JSValue *value = [context evaluateScript:@"sumA(1,2)"];
    NSInteger result = [value toInt32];
    __weak typeof(self) weakself = self;
    context[@"popAction"] = ^(id value){
        
//        NSArray *args = [JSContext currentArguments];
//        for (JSValue *jsVal in args) {
//            NSLog(@"%@", jsVal);
//        }
//        JSValue *this = [JSContext currentThis];
//        JSContext *currentCotext = [JSContext currentContext];
//        JSValue *value = currentCotext[@"popAction"];
//        if ([value isKindOfClass:[NSString class]]) {
//            if ([value isEqualToString:@"action.back"])
//            {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself popAction];
        });
        
//            }
//        }
    };
    NSLog(@"value is %ld",result);
}

- (void)popAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    NSLog(@"webView is %@",testWebView);
}

@end
