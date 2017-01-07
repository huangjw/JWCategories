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
 NSArray 或者 NSDictionary 转化成JSON字符串

 @param object object
 @return jsonString
 */
+ (NSString *)jw_JSONString:(id)object;

/**
 JSON字符串转化成 NSArray 或者 NSDictionary

 @return object
 */
- (id)jw_JSONObject;

@end
