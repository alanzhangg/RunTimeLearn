//
//  Person.m
//  RunTimeDemo
//
//  Created by zhangalan on 17/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName:(NSString *)name andAge:(NSInteger)age{
    if (self = [super init]) {
        _name = name;
        _age = age;
    }
    return self;
}

@end
