//
//  ChildClass.m
//  RunTimeDemo
//
//  Created by jinxin on 16/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import "ChildClass.h"

@implementation ChildClass

- (instancetype)init
{
	self = [super init];
	if (self) {
		NSLog(@"%@", NSStringFromClass([self class]));
		NSLog(@"%@", NSStringFromClass([super class]));
	}
	return self;
}

@end
