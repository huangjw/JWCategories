//
//  UIDevice+Identifier.m
//  JWCategories
//
//  Created by huangjw on 2017/1/6.
//  Copyright © 2017年 huangjw. All rights reserved.
//

#import "UIDevice+Identifier.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <sys/utsname.h>
#include <net/if.h>
#include <net/if_dl.h>

#include <ifaddrs.h>
#include <arpa/inet.h>

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation UIDevice (Identifier)

- (NSString *)jw_macAddress
{
    NSString *key = @"macAddress";
    NSString *macAddress = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (macAddress.length == 0) {
        macAddress = [self localMAC];
        if (macAddress.length > 0){
            [[NSUserDefaults standardUserDefaults] setObject:macAddress forKey:key];
        }
    }
    
    return macAddress;
}

- (NSString *)jw_ipAddress
{
    NSArray *searchArray =
    @[ IOS_WIFI @"/" IP_ADDR_IPv4,
       IOS_WIFI @"/" IP_ADDR_IPv6,
       IOS_CELLULAR @"/" IP_ADDR_IPv4,
       IOS_CELLULAR @"/" IP_ADDR_IPv6 ];
    NSDictionary *addresses = [self getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

- (BOOL)jw_isWiFiEnabled
{
    NSCountedSet * cset = [NSCountedSet new];
    struct ifaddrs *interfaces;
    if( ! getifaddrs(&interfaces) ) {
        for( struct ifaddrs *interface = interfaces; interface; interface = interface->ifa_next) {
            if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
                [cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
            }
        }
    }
    return [cset countForObject:@"awdl0"] > 1 ? YES : NO;
}

- (NSString *)jw_networkOperation
{
    //network_operator
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *ctCarrier = networkInfo.subscriberCellularProvider;
    //    00 China Mobile
    //    01 China Unicom
    //    02 China Mobile
    //    03 China Telcom
    //    05 China Telcom
    //    06 China Unicom
    //    07 China Mobile
    //    20 China Tietong
    NSString *mobileNetworkCode = ctCarrier.mobileNetworkCode;
    return mobileNetworkCode;
}

- (NSString *)jw_machineType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([machineType isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([machineType isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([machineType isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([machineType isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([machineType isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([machineType isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([machineType isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([machineType isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([machineType isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([machineType isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([machineType isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([machineType isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([machineType isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([machineType isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([machineType isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([machineType isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([machineType isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([machineType isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([machineType isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([machineType isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    
    //iPod
    if ([machineType isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([machineType isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([machineType isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([machineType isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([machineType isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([machineType isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    //iPad
    if ([machineType isEqualToString:@"iPad1,1"])      return @"iPad";
    
    if ([machineType isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([machineType isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([machineType isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([machineType isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([machineType isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([machineType isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([machineType isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([machineType isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([machineType isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([machineType isEqualToString:@"iPad3,3"])      return @"iPad 3 (4G)";
    if ([machineType isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([machineType isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([machineType isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([machineType isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([machineType isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([machineType isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([machineType isEqualToString:@"iPad4,4"])      return @"iPad mini 2";
    if ([machineType isEqualToString:@"iPad4,5"])      return @"iPad mini 2";
    if ([machineType isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    if ([machineType isEqualToString:@"iPad4,7"])      return @"iPad mini 3";
    if ([machineType isEqualToString:@"iPad4,8"])      return @"iPad mini 3";
    if ([machineType isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    if ([machineType isEqualToString:@"iPad5,1"])      return @"iPad mini 4";
    if ([machineType isEqualToString:@"iPad5,2"])      return @"iPad mini 4";
    if ([machineType isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([machineType isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([machineType isEqualToString:@"iPad6,3"])      return @"iPad Pro (9.7 inch)";
    if ([machineType isEqualToString:@"iPad6,4"])      return @"iPad Pro (9.7 inch)";
    if ([machineType isEqualToString:@"iPad6,7"])      return @"iPad Pro (12.9 inch)";
    if ([machineType isEqualToString:@"iPad6,8"])      return @"iPad Pro (12.9 inch)";
    
    //Simulator
    if ([machineType isEqualToString:@"i386"])         return @"Simulator";
    if ([machineType isEqualToString:@"x86_64"])       return @"Simulator";
    
    return machineType;
}

- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

- (NSString *)localMAC
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

@end
