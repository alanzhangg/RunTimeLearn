//
//  NSObject+KeyValue.h
//  RunTimeDemo
//
//  Created by jinxin on 16/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KeyValue)

+ (id)objectWithKeyValue:(NSDictionary *)aDictionary;
- (NSDictionary *)keyValueWithObject;

@end
