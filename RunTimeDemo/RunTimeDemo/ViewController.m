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
#import "Person.h"

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
    
    __block int multiplier = 7;
    int (^myblock)(int) = ^(int num){
        multiplier++;
        return num * multiplier;
    };
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"a",@"b",@"abc",nil];
    NSMutableArray *mArrayCount = [NSMutableArray arrayWithCapacity:1];
    [mArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock: ^(id obj,NSUInteger idx, BOOL *stop){
        [mArrayCount addObject:[NSNumber numberWithInt:[obj length]]];
    }];
    
    NSLog(@"%@",mArrayCount);
    //手动kvo
//    [self willChangeValueForKey:@"now"];
//    [self didChangeValueForKey:@"now"];
    
    //keyPath 集合运算
    Person *p1 = [[Person alloc] initWithName:@"xiaoming" andAge:10];
    Person *p2 = [[Person alloc] initWithName:@"xiaoming" andAge:15];
    Person *p3 = [[Person alloc] initWithName:@"xiaohong" andAge:20];
    Person *p4 = [[Person alloc] initWithName:@"xiaoli" andAge:30];
    Person *p5 = [[Person alloc] initWithName:@"xiaoli" andAge:55];
    NSArray *perArray = @[p1, p2, p3, p4, p5];
    
    NSInteger avg = [[perArray valueForKeyPath:@"@avg.age"] integerValue];
    NSInteger sum = [[perArray valueForKeyPath:@"@sum.age"] integerValue];
    NSInteger max = [[perArray valueForKeyPath:@"@max.age"] integerValue];
    NSInteger min = [[perArray valueForKeyPath:@"@min.age"] integerValue];
    
    //数组中元素个数
    NSInteger count = [[perArray valueForKeyPath:@"@count.age"] integerValue];
    NSInteger count1 = [[perArray valueForKeyPath:@"@count"] integerValue];
    NSInteger count2 = perArray.count;
    
    // 对象操作符：对数组对象进行操作
    // @unionOfObjects：返回指定属性的值的数组，不去重
    // @distinctUnionOfObjects：返回指定属性去重后的值的数组
    
    NSArray<NSString *> * nameArray = [perArray valueForKeyPath:@"@unionOfObjects.name"];
    NSArray<NSString *> * nameArray1 = [perArray valueForKeyPath:@"@distinctUnionOfObjects.name"];
    
    // 数组 / 集体操作符 ： 对由NSArray和NSSet所组成的集合操作
    // unionOfArrays：返回一个数组，值由各个子数组的元素组成，不去重
    // distinctUnionOfArrays：返回一个数组，值由各个子数组的元素组成，去重
    // distinctUnionOfSets：和distinctUnionOfArrays差不多, 只是它期望的是一个包含着NSSet对象的NSSet，并且会返回一个NSSet对象。因为集合不能包含重复的值，所以它只有distinct操作。
    Person *P1 = [[Person alloc] initWithName:@"PP1" andAge:10];
    Person *P2 = [[Person alloc] initWithName:@"PP1" andAge:20];
    Person *P3 = [[Person alloc] initWithName:@"PP2" andAge:30];
    Person *P4 = [[Person alloc] initWithName:@"PP3" andAge:40];
    Person *P5 = [[Person alloc] initWithName:@"PP3" andAge:50];
    
    NSArray *perArray2 = @[P1, P2, P3, P4, P5];
    
    NSArray * arr1 = [@[perArray, perArray2] valueForKeyPath:@"@unionOfArrays.name"];
    NSArray * arr2 = [@[perArray, perArray2] valueForKeyPath:@"@distinctUnionOfArrays.name"];
    
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });
//    NSLog(@"3");
    
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
