//
//  MyClass.m
//  RunTimeDemo
//
//  Created by jinxin on 16/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import "MyClass.h"
#include <objc/message.h>

@interface MyClass ()

@property (nonatomic, copy) NSString * impName;

@end

@implementation MyClass{
	NSString * impInName;
}

- (instancetype)init{
	if (self = [super init]) {
		[self showUserName];
	}
	return self;
}

- (void)showUserName{
	NSLog(@"Dave Ping");
}

-(void)showAge{
	NSLog(@"24");
}
-(void)showName:(NSString *)aName{
	NSLog(@"name is %@",aName);
}
-(void)showSizeWithWidth:(float)aWidth andHeight:(float)aHeight{
	NSLog(@"size is %.2f * %.2f",aWidth, aHeight);
}
-(float)getHeight{
	return 187.5f;
}
-(NSString *)getInfo{
	return @"Hi, my name is Dave Ping, I'm twenty-four years old in the year, I like apple, nice to meet you.";
}

@end
