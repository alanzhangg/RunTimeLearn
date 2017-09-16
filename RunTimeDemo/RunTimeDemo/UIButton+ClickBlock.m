//
//  UIButton+ClickBlock.m
//  RunTimeDemo
//
//  Created by jinxin on 16/09/2017.
//  Copyright © 2017 jinxin. All rights reserved.
//

#import "UIButton+ClickBlock.h"
#include <objc/runtime.h>

static const void * associateKey = "associateKey";

@implementation UIButton (ClickBlock)

- (void)setClick:(block)click{
	objc_setAssociatedObject(self, associateKey, click, OBJC_ASSOCIATION_COPY_NONATOMIC);
	[self removeTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
	if (click) {
		[self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
	}
}

- (block)click{
	return objc_getAssociatedObject(self, associateKey);
}

- (void)buttonClick{
	if (self.click) {
		self.click();
	}
}

@end
