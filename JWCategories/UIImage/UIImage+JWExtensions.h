//
//  UIImage+JWExtensions.h
//  JWCategories
//
//  Created by huangjw on 16/8/24.
//  Copyright © 2016年 huangjw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JWExtensions)

/**
 *  圆角图
 *
 *  @return 圆角图
 */
- (UIImage *)jw_circleImage;

+ (UIImage *)jw_circleImage:(NSString *)name;

/**
 *  透明度图片
 *
 *  @param alpha 透明度
 *
 *  @return 透明度图片
 */
- (UIImage *)jw_imageWithAlpha:(CGFloat)alpha;

@end
