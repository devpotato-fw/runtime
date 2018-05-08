//
//  UIButton+property.h
//  runtime
//
//  Created by Json on 2018/5/8.
//  Copyright © 2018年 onefboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (property)
// 在列别中定义属性，只有声明方法，没有实现方法，直接访问属性会报错
@property (strong, nonatomic) NSString *section;

@end
