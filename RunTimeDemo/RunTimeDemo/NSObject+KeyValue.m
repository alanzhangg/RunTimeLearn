//
//  NSObject+KeyValue.m
//  RunTimeDemo
//
//  Created by jinxin on 16/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import "NSObject+KeyValue.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (KeyValue)

+ (id)objectWithKeyValue:(NSDictionary *)aDictionary{
	id object = [[self alloc] init];
	for (NSString * key in aDictionary.allKeys) {
		id value = aDictionary[key];
//		判断当前属性是不是model
		objc_property_t property = class_getProperty(self, key.UTF8String);
		unsigned int outCount = 0;
		objc_property_attribute_t* atributeList = property_copyAttributeList(property, &outCount);
		objc_property_attribute_t attribute = atributeList[0];
		NSString * typeString = [NSString stringWithUTF8String:attribute.value];
		if ([typeString isEqualToString:@"@\"TestModel\""]) {
			value = [self objectWithKeyValue:value];
		}
//		 生成setter方法， 并用objc_msgSend调用
		NSString * methodName = [NSString stringWithFormat:@"set%@%@", [key substringToIndex:1].uppercaseString, [key substringFromIndex:1]];
		SEL setter = sel_registerName(methodName.UTF8String);
		if ([object respondsToSelector:setter]) {
			((void (*) (id, SEL, id)) objc_msgSend)(object, setter, value);
		}
	}
	return object;
}

- (NSDictionary *)keyValueWithObject{
	unsigned int outCount = 0;
	objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
	NSMutableDictionary * dict = [NSMutableDictionary dictionary];
	for (int i = 0; i < outCount; i++) {
		objc_property_t property = propertyList[i];
		const char * propertyName = property_getName(property);
		SEL getter = sel_registerName(propertyName);
		if ([self respondsToSelector:getter]) {
			id value = ((id (*) (id, SEL)) objc_msgSend) (self, getter);
			if ([value isKindOfClass:[self class]] && value) {
				value = [value keyValueWithObject];
			}
			if (value) {
				NSString * key = [NSString stringWithUTF8String:propertyName];
				[dict setObject:value forKey:key];
			}
		}
	}
	return dict;
}

@end
