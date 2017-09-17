//
//  Person.h
//  RunTimeDemo
//
//  Created by zhangalan on 17/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) NSInteger age;

- (instancetype)initWithName:(NSString *)name andAge:(NSInteger)age;

@end
