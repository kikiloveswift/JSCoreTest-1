//
//  ViewController.m
//  JSCoreTest-1
//
//  Created by kong on 16/8/29.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "SecondViewController.h"

@protocol UIButtonExport <JSExport>

- (void)setTitle:(NSString *)title forState:(UIControlState)state;

@end

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
    NSString *urlString = @"http://172.16.205.108:8080/JSCoreTest/index.html";
    [testWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [self.view addSubview:testWebView];
    
    for (int i = 1; i <= 5; i ++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWidth - 120, (i-1) * (50+20) + 84, 100, 50)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"";
        if (i == 1) {
            label.text = @"250";
        }
        if (i == 3) {
            label.text = @"249";
        }
        if (i == 2) {
            label.text = @"+";
        }
        if (i == 4) {
            label.text = @"||";
        }
        label.backgroundColor = [UIColor lightGrayColor];
        label.tag = 2000 + i;
//        [self.view addSubview:label];
    }
}

#pragma mark-DidFinishLoad---WebView加载结束
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JSValue *value = [context evaluateScript:@"sumA(1,2)"];
    NSInteger result = [value toInt32];
    __weak typeof(self) weakself = self;
    context[@"popAction"] = ^(id val){
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself popAction];
        });
    };
    
    context[@"calValueCallBackToOC"] = ^(NSInteger sum){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself calResult:sum];
        });
    };
    [context evaluateScript:@"calValueCallBackToOC(250,249)"];
    
    NSLog(@"value is %ld",result);
}

- (void)popAction
{
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)calResult:(NSInteger)result
{
    UILabel *label = (UILabel *)[self.view viewWithTag:2005];
    label.text = [NSString stringWithFormat:@"%ld",result];
}

- (void)dealloc
{
    NSLog(@"webView is %@",testWebView);
}

- (void)test
{
    class_addProtocol([UIButton class], @protocol(UIButtonExport));
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Hello Objective-C"forState:UIControlStateNormal];
    button.frame = CGRectMake(20,40,280,40);
    
    JSContext *context = [[JSContext alloc]init];
    context[@"button"] = button;
    [context evaluateScript:@"button.setTitleForState('Hello JavaScript', 0)"];
    
    [self.view addSubview:button];
    
    //JS对象
    JSValue *plugin = [context evaluateScript:@"someScript"];
    //装入ManagerValue
    JSManagedValue *managePlugin = [JSManagedValue managedValueWithValue:plugin];
    //放入虚拟机中加入引用
    [context.virtualMachine addManagedReference:managePlugin withOwner:self];
}

@end
