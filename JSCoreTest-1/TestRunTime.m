//
//  TestRunTime.m
//  JSCoreTest-1
//
//  Created by kong on 16/9/1.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "TestRunTime.h"
#import "CustomClass.h"
#import <objc/runtime.h>

@implementation TestRunTime

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //测试copy
        [self testObjc_Copy];
        
        //测试addFunction
        [self addFunction];
        
        //测试获取全局变量
        [self testGetAllInstance];
        
    }
    return self;
}

/**
 *  测试objc_copy
 */
- (void)testObjc_Copy
{
    CustomClass *customClass = [CustomClass new];
    [customClass testLog];
    NSLog(@"customClass内存地址%p",&customClass);
    
    id testClass = object_copy(customClass,sizeof(customClass));
    [testClass testLog];
    NSLog(@"customClass拷贝的内存地址%p",&testClass);
    
    object_dispose(customClass);
    NSLog(@"customClass的引用计数为:%ld",customClass.retainCount);
//    [customClass testLog];
    [testClass release];
    [testClass testLog];
}

int cFunction(id self, SEL _cmd, NSString *str)
{
    NSLog(@"%@",str);
    return 10;
}
/**
 *  给当前类添加一个方法
 */
- (void)addFunction
{
    CustomClass *testClass = [[CustomClass alloc] init];
    
    class_addMethod([CustomClass class], @selector(ocMethod:), (IMP)cFunction, "i@:@");
    if ([testClass respondsToSelector:@selector(ocMethod:)])
    {
        NSLog(@"YES");
    }else{
    
        NSLog(@"SORRY");
    }
    int a = (int)[testClass ocMethod:@"我是一个OC的method，C函数实现"];
    NSLog(@"a:%d", a);

}

- (void)testGetAllInstance
{
    u_int count;
    Ivar *instanceList = class_copyIvarList([CustomClass class], &count);
    for (int i = 0; i < count; i++) {
        struct objc_ivar *name = instanceList[i];
        NSLog(@"name is %@",[NSString stringWithCString:name encoding:NSUTF8StringEncoding]);
    }
}


@end

