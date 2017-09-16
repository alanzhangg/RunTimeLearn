//
//  TestModel.m
//  RunTimeDemo
//
//  Created by jinxin on 16/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import "TestModel.h"
#import <objc/runtime.h>

@implementation TestModel

- (void)encodeWithCoder:(NSCoder *)coder{
	unsigned int outCount = 0;
	Ivar * vars = class_copyIvarList([self class], &outCount);
	for (int i = 0; i < outCount; i++) {
		Ivar var = vars[i];
		const char * name = ivar_getName(var);
		NSString * key = [NSString stringWithUTF8String:name];
		id value = [self valueForKey:key];
		[coder encodeObject:value forKey:key];
	}
	free(vars);
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if (self) {
		unsigned int outCount = 0;
		Ivar *vars = class_copyIvarList([self class], &outCount);
		for (int i = 0; i < outCount; i ++) {
			Ivar var = vars[i];
			const char *name = ivar_getName(var);
			NSString *key = [NSString stringWithUTF8String:name];
			id value = [coder decodeObjectForKey:key];
			[self setValue:value forKey:key];
		}
		free(vars);
	}
	return self;
}

@end
