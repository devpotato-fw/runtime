//
//  UIButton+property.m
//  runtime
//
//  Created by Json on 2018/5/8.
//  Copyright © 2018年 onefboy. All rights reserved.
//

#import "UIButton+property.h"
#import <objc/runtime.h>

// 定义关联的key
static const char *key = "section";

@implementation UIButton (property)

- (NSString *)section
{
  // 根据关联的key，获取关联的值。
  return objc_getAssociatedObject(self, key);
}

- (void)setSection:(NSString *)section
{
  // 第一个参数：给哪个对象添加关联
  // 第二个参数：关联的key，通过这个key获取
  // 第三个参数：关联的value
  // 第四个参数:关联的策略
  objc_setAssociatedObject(self, key, section, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
