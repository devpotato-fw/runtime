//
//  Student+IsEdit.m
//  runtime
//
//  Created by Json on 2018/5/8.
//  Copyright © 2018年 onefboy. All rights reserved.
//

#import "Student+IsEdit.h"
#import <objc/runtime.h>

// 定义关联的key
static const char *key = "isEdit";

@implementation Student (IsEdit)

- (BOOL)isEdit
{
  // 根据关联的key，获取关联的值。
  return objc_getAssociatedObject(self, key);
}

- (void)setIsEdit:(BOOL)isEdit
{
  // 第一个参数：给哪个对象添加关联
  // 第二个参数：关联的key，通过这个key获取
  // 第三个参数：关联的value
  // 第四个参数:关联的策略
  NSNumber *number = [NSNumber numberWithBool: isEdit];
  objc_setAssociatedObject(self, key, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
