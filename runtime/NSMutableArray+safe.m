//
//  NSMutableArray+safe.m
//  runtime
//
//  Created by wangfang on 2017/1/17.
//  Copyright © 2017年 onefboy. All rights reserved.
//

#import "NSMutableArray+safe.h"
#import <objc/runtime.h>

@implementation NSMutableArray (safe)

+ (void)load {
  static dispatch_once_t oneToken;
  dispatch_once(&oneToken, ^{
    id obj = [[self alloc] init];
    [obj swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];
    [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
  });
}

/*safeAddObject
 代码看起来可能有点奇怪，像递归不是么。
 当然不会是递归，因为在 runtime 的时候，函数实现已经被交换了。
 */
- (void)safeAddObject:(id)anObject {
  if (anObject) {
    [self safeAddObject:anObject];
  } else {
    NSLog(@"obj is nil");
  }
}

/*
 objectAtIndex: 会调用你实现的 safeObjectAtIndex:，
 而在 NSMutableArray: 里调用 safeObjectAtIndex:
 实际上调用的是原来的 objectAtIndex:
 */
- (id)safeObjectAtIndex:(NSInteger)index {
  if (index<[self count]) {
    return [self safeObjectAtIndex:index];
  } else {
    NSLog(@"index is beyond bounds");
  }
  return nil;
}

/*
 class_addMethod 。要先尝试添加原 selector 是为了做一层保护，因为如果这个类没有实现 originalSelector ，但其父类实现了，那 class_getInstanceMethod 会返回父类的方法。这样 method_exchangeImplementations 替换的是父类的那个方法，这当然不是你想要的。所以我们先尝试添加 orginalSelector ，如果已经存在，再用 method_exchangeImplementations 把原方法的实现跟新的方法实现给交换掉。
 */
- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector {
  Class class = [self class];
  
  Method originalMethod = class_getInstanceMethod(class, origSelector);
  Method swizzledMethod = class_getInstanceMethod(class, newSelector);
  
  BOOL didAddMethod = class_addMethod(class,
                                      origSelector,
                                      method_getImplementation(swizzledMethod),
                                      method_getTypeEncoding(swizzledMethod));
  
  if (didAddMethod) {
    class_replaceMethod(class,
                        newSelector,
                        method_getImplementation(originalMethod),
                        method_getTypeEncoding(originalMethod));
  } else {
    method_exchangeImplementations(originalMethod, swizzledMethod);
  }
}

@end

