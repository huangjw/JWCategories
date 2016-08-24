//
//  NSObject+JWExtensions.h
//  JWCategories
//
//  Created by huangjw on 16/8/24.
//  Copyright © 2016年 huangjw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JWExtensions)

/**
 *  获取属性键值对
 *
 *  @return 键值对字典
 */
- (NSDictionary *)jw_getAllPropertiesAndVaules;

@end
