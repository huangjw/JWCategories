//
//  NSString+JWURLEncode.h
//  JWCategories
//
//  Created by huangjw on 16/7/27.
//  Copyright © 2016年 huangjw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JWURLEncode)

/**
 URLEncode(默认UTF8)

 @return URLEncode后的字符串
 */
- (NSString *)jw_URLEncode;

- (NSString *)jw_URLEncodeUsingEncoding:(NSStringEncoding)encoding;

/**
 URLDecode(默认UTF8)

 @return URLDecode后的字符串
 */
- (NSString *)jw_URLDecode;

- (NSString *)jw_URLDecodeUsingEncoding:(NSStringEncoding)encoding;

@end
