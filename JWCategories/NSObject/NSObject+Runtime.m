//
//  NSObject+Runtime.m
//  JWCategories
//
//  Created by huangjw on 2017/5/18.
//  Copyright © 2017年 huangjw. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject(Runtime)

/**
 获取成员变量
 
 @return 返回成员变量字符串数组
 */
+ (NSArray *)fetchIvarList
{
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dictionary[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        dictionary[@"type"] = [NSString stringWithUTF8String:ivarType];
        [list addObject:dictionary];
    }
    free(ivarList);
    return [NSArray arrayWithArray:list];
}

/**
 获取类的属性列表, 包括私有和公有属性，即定义在延展中的属性
 
 @return 属性列表数组
 */
+ (NSArray *)fetchPropertyList;
{
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [list addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:list];
}

/**
 获取对象方法列表：getter, setter, 对象方法等。但不能获取类方法
 
 @return 该类的方法列表
 */
+ (NSArray *)fetchMethodList;
{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList([self class], &count);
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [list addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:list];
}

/**
 获取协议列表
 
 @return 返回该类实现的协议列表
 */
+ (NSArray *)fetchProtocolList;
{
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [list addObject:[NSString stringWithUTF8String:protocolName]];
    }
    return [NSArray arrayWithArray:list];
}

+ (void)addSelector:(SEL)selector
{
    Class class = [self class];
    Method method = class_getInstanceMethod(class, selector);
    class_addMethod(class, selector, method_getImplementation(method), method_getTypeEncoding(method));
}

/**
 方法替换

 @param originalSelector 原始SEL
 @param swizzledSelector 替换SEL
 */
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector
{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
