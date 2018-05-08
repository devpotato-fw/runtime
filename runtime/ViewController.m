//
//  ViewController.m
//  runtime
//
//  Created by wangfang on 2017/1/17.
//  Copyright © 2017年 onefboy. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "UIButton+property.h"
#import "Student+IsEdit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  //1.交换方法
  NSMutableArray *array = [NSMutableArray array];
  [array addObject:nil];
  [array objectAtIndex:3];
  
  
  //2.动态添加方法
  Student *s = [[Student alloc] init];
  // 默认person，没有实现eat方法，可以通过performSelector调用，但是会报错。
  // 动态添加方法就不会报错
  [s performSelector:@selector(study)];
  
  
  //3.动态添加属性
  // 给系统类添加属性
  UIButton *button = [[UIButton alloc] init];
  button.section = @"1";
  NSLog(@"section=%@", button.section);
  
  // 给自定义的类添加属性
  Student *student = [[Student alloc] init];
  student.isEdit = YES;
  NSLog(@"isEdit=%d", student.isEdit);
  
  //4.添加统计事件
  
}


@end

