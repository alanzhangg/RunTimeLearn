//
//  UIButton+ClickBlock.h
//  RunTimeDemo
//
//  Created by jinxin on 16/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)();

@interface UIButton (ClickBlock)

@property (nonatomic, copy) block click;

@end
