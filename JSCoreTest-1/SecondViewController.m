//
//  SecondViewController.m
//  JSCoreTest-1
//
//  Created by kong on 16/8/30.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "SecondViewController.h"
#import "TestRunTime.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self testRuntime];
    
}

- (void)testRuntime
{
    TestRunTime *testRuntime = [[TestRunTime alloc] init];
    
}



@end
