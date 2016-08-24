//
//  NSObject+JWExtensions.m
//  JWCategories
//
//  Created by huangjw on 16/8/24.
//  Copyright © 2016年 huangjw. All rights reserved.
//

#import "NSObject+JWExtensions.h"
#import <objc/runtime.h>

@implementation NSObject (JWExtensions)

- (NSDictionary *)jw_getAllPropertiesAndVaules
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++){
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [props setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return props;
}

@end
