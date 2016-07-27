//
//  NSString+JWJSONString.h
//  JWCategories
//
//  Created by huangjw on 16/7/27.
//  Copyright © 2016年 huangjw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JWJSONString)

/**
 *   NSArray 或者 NSDictionary 转化成JSON字符串
 *
 *  @param 转化对象
 *
 *  @return JSON字符串
 */
+ (NSString *)jw_JSONString:(id)object;

/**
 *  JSON字符串转化成 NSArray 或者 NSDictionary
 *
 *  @return 序列化对象
 */
- (id)jw_JSONObject;

@end
