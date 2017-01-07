//
//  UIDevice+Identifier.h
//  JWCategories
//
//  Created by huangjw on 2017/1/6.
//  Copyright © 2017年 huangjw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Identifier)

/**
 网卡地址

 @return macAddress
 */
- (NSString *)jw_macAddress;

/**
 IP地址

 @return ipAddress
 */
- (NSString *)jw_ipAddress;

/**
是否wifi网络环境

 @return BOOL
 */
- (BOOL)jw_isWiFiEnabled;

/**
 网络制式

 @return networkOperation
 */
- (NSString *)jw_networkOperation;

/**
 设备类型

 @return machineType
 */
- (NSString *)jw_machineType;

@end
