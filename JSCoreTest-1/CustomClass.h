//
//  CustomClass.h
//  JSCoreTest-1
//
//  Created by kong on 16/9/1.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomClass : NSObject


/**
 *  1.class_copyPropertiesList只可以获取.h中的属性。
 *  2.class_getInstaceVariable这个可以获取整个类的全局变量，包括.m文件中的
 */
@property (nonatomic, copy) NSString *name;

/**
 *  测试输出
 */
- (void)testLog;

@end
