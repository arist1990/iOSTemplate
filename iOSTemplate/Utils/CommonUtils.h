//
//  CommonUtils.h
//  Woyanyan
//
//  Created by ZH_ZZ_MAC on 13-12-11.
//  Copyright (c) 2013年 clyde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonUtils : NSObject

// 检查网络状态
+ (BOOL)checkNet;

/**
 * 获取设备MAC地址
 */
+ (NSString *)getMacAddress;

+ (NSString *)getTelNumber;

+ (NSString *)getUrl:(NSDictionary *)dic key:(NSString *)key;

+ (NSString *)getDicStr:(NSDictionary *)dic key:(NSString *)key;

+ (NSDictionary *)getDicFromString:(NSString *)str;

+ (CGFloat)getSystemOSVersion;

+ (CGFloat)getTextHeight:(NSString *)text width:(CGFloat)width font:(UIFont *)font;

+ (CGFloat)getTextWidth:(NSString *)text width:(CGFloat)width font:(UIFont *)font;

+ (UIImage *)grayscale:(UIImage *)anImage type:(char)type;

+ (UIImage *)imageFromColor:(UIColor *)color;

+ (NSString *)stringFromMillSec:(NSString *)timeStr;

+ (NSString *)stringYYYYMMddHHmmFromMillSec:(NSString *)timeStr;

// date 格式化为 string
+ (NSString*) stringFromFomate:(NSDate*)date formate:(NSString*)formate;

+ (NSString *)stringFromMillSec1:(NSString *)timeStr;

+ (NSString *) dateMMddFromFomate:(NSString *)datestring formate:(NSString*)formate;

+ (NSString *) dateHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate;

+ (NSString *) dateMMddHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate;

+ (NSString *) dateYYMMddHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate;

+ (BOOL)checkPhone:(NSString *)phone;

+ (NSString *)getDistanceString:(Float64)distance;

+ (NSString *)getTimePassString:(int32_t)timePass;

+ (BOOL)checkNeedLogin;

// 获取中文
+ (NSInteger)getStringLengthWithChinese:(NSString *)str;

@end
