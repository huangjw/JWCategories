//
//  NSString+JWHash.h
//  JWCategories
//
//  Created by huangjw on 2017/1/7.
//  Copyright © 2017年 huangjw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JWHash)

- (NSString *)jw_md5String;
- (NSString *)jw_sha1String;
- (NSString *)jw_sha256String;
- (NSString *)jw_sha512String;

- (NSString *)jw_hmacMD5StringWithKey:(NSString *)key;
- (NSString *)jw_hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)jw_hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)jw_hmacSHA512StringWithKey:(NSString *)key;

@end
