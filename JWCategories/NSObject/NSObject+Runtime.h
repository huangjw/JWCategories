//
//  NSObject+Runtime.h
//  JWCategories
//
//  Created by huangjw on 2017/5/18.
//  Copyright © 2017年 huangjw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject(Runtime)

/**
 获取成员变量
 
 @return 返回成员变量字符串数组
 */
+ (NSArray *)fetchIvarList;

/**
 获取类的属性列表, 包括私有和公有属性，即定义在延展中的属性
 
 @return 属性列表数组
 */
+ (NSArray *)fetchPropertyList;

/**
 获取对象方法列表：getter, setter, 对象方法等。但不能获取类方法
 
 @return 该类的方法列表
 */
+ (NSArray *)fetchMethodList;

/**
 获取协议列表
 
 @return 返回该类实现的协议列表
 */
+ (NSArray *)fetchProtocolList;

/**
 方法替换
 
 @param originalSelector 原始SEL
 @param swizzledSelector 替换SEL
 */
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector;

@end
