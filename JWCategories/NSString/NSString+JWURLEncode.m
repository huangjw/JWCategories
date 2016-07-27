//
//  NSString+JWURLEncode.m
//  JWCategories
//
//  Created by huangjw on 16/7/27.
//  Copyright © 2016年 huangjw. All rights reserved.
//

#import "NSString+JWURLEncode.h"

/*
Returns a percent-escaped string following RFC 3986 for a query string key or value.
RFC 3986 states that the following characters are "reserved" characters.
- General Delimiters: ":", "#", "[", "]", "@", "?", "/"
- Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
*/

@implementation NSString (JWURLEncode)

- (NSString *)jw_URLEncode;
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    return [self jw_URLEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)jw_URLEncodeUsingEncoding:(NSStringEncoding)encoding;
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)self,NULL,(CFStringRef)@"!#$&'()*+,/:;=?@[]%",CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString *)jw_URLDecode;
{
    return [self stringByRemovingPercentEncoding];
//    return [self jw_URLDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)jw_URLDecodeUsingEncoding:(NSStringEncoding)encoding;
{
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,(__bridge CFStringRef)self,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(encoding));
}

@end
