//
//  ViewController.m
//  RunTimeDemo
//
//  Created by jinxin on 16/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import "ViewController.h"
#include <objc/message.h>
#import "MyClass.h"
#import "ChildClass.h"
#import "UIButton+ClickBlock.h"
#import "Monkey.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//	[self testMsgSend];
//	[self textSuper];
//	[self testBtnCategory];
	[self forwardingTest];
}

- (void)testBtnCategory{
	UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = self.view.bounds;
	[self.view addSubview:button];
	button.click = ^(){
		NSLog(@"buttonClicked");
	};
}

- (void)textSuper{
	ChildClass * childClass = [[ChildClass alloc] init];
}

-(void)forwardingTest{
	Monkey *monkey = [[Monkey alloc] init];
	((void (*) (id, SEL)) objc_msgSend) (monkey, sel_registerName("fly"));
}


- (void)testMsgSend{
	MyClass * class = [[MyClass alloc] init];
	((void (*) (id, SEL))objc_msgSend)(class, sel_registerName("showAge"));
	((void (*) (id, SEL, NSString *)) objc_msgSend) (class, sel_registerName("showName:"), @"alan");
	((void (*) (id, SEL, float, float)) objc_msgSend) (class, sel_registerName("showSizeWithWidth:andHeight:"), 110.5f, 120.6f);
	NSString * info = ((NSString * (*) (id, SEL)) objc_msgSend) (class, sel_registerName("getInfo"));
	NSLog(@"%@", info);
	float f = ((float (*) (id, SEL)) objc_msgSend) (class, sel_registerName("getHeight"));
	NSLog(@"height is %2f", f);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
