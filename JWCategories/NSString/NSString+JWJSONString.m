//
//  NSString+JWJSONString.m
//  JWCategories
//
//  Created by huangjw on 16/7/27.
//  Copyright © 2016年 huangjw. All rights reserved.
//

#import "NSString+JWJSONString.h"

@implementation NSString (JWJSONString)

+ (NSString *)jw_JSONString:(id)object;
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:0
                                                         error:&error];
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (id)jw_JSONObject;
{
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                                    options:NSJSONReadingMutableContainers
                                                      error:&error];
    if (error != nil) {
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", self, error);
    }
    return jsonObject;
}

@end
