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
        
        //获取一个类的所有方法
        [self getClassAllMehtod];
        
        //获取一个类的所有属性
        [self getPropertyNameList];
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
    
    NSLog(@"%p",(IMP)cFunction);
    
    //为当前CustomClass类添加了一个ocMethod的方法 方法地址指向了C语言的Function
    class_addMethod([CustomClass class], @selector(ocMethod:), (IMP)cFunction, "i@:@");
    if ([testClass respondsToSelector:@selector(ocMethod:)])
    {
        NSLog(@"YES");
    }else{
    
        NSLog(@"SORRY");
    }
    //testClass调用C语言的Function
    int a = (int)[testClass ocMethod:@"我是一个OC的method，C函数实现"];
    NSLog(@"a:%d", a);
}

/**
 *  获取一个类里面的所有方法
 */
- (void)getClassAllMehtod
{
    u_int count;
    //取得所有的方法列表
    Method *methods = class_copyMethodList([CustomClass class], &count);
    for (int i = 0 ; i < count; i ++)
    {
        //取得方法名称
        SEL name = method_getName(methods[i]);
        //方法名称转码
        NSString *nameStr = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"nameStr is %@",nameStr);
    }
}

/**
 *  获取一个类的所有属性
 */
- (void)getPropertyNameList
{
    u_int count;
    objc_property_t * properties = class_copyPropertyList([CustomClass class], &count);
    for (int i = 0; i < count; i ++) {
        const char *name = property_getName(properties[i]);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        NSLog(@"nameStr is %@",nameStr);
    }
}


@end

