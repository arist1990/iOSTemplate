//
//  UIColor+HexColor.h
// SayItAgain
//
//  Created by ARIST on 2016/10/24.
//  Copyright © 2016年 ytd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

/***
 ** 将hex解析为颜色
 **/
+(UIColor *) colorWithHexString: (NSString *) stringToConvert;
/***
 ** 实现颜色反解析
 **/
+(NSString *) changeUIColorToRGB:(UIColor *)color;
/***
 ** 通过名称设置颜色
 **/
+(UIColor *) colorNameToUIColor:(NSString *) name;

@end
