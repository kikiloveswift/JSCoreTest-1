//
//  PersonRunTime.m
//  JSCoreTest-1
//
//  Created by kong on 16/9/3.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "PersonRunTime.h"

@implementation PersonRunTime

- (void)setName:(NSString *)name
{
    if (_name != name) {
        _name = name;
    }
}

- (void)getName
{
    NSLog(@"Person's Name is %@",self.name);
}

@end
