//
//  CommonUtils.m
//  Woyanyan
//
//  Created by ZH_ZZ_MAC on 13-12-11.
//  Copyright (c) 2013年 clyde. All rights reserved.
//

#import "CommonUtils.h"
#import "Reachability.h"

// getMacAddress start
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
// getMacAddress end


@implementation CommonUtils

// 检查网络状态
+ (BOOL)checkNet{
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

/**
 * 获取设备MAC地址
 */
+ (NSString *)getMacAddress{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
//        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
//        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
//        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
//        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"x:x:x:x:x:x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%x:%x:%x:%x:%x:%x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

+ (NSString *)getTelNumber{
    NSString *tel = [[NSUserDefaults standardUserDefaults] objectForKey:@"SBFormattedPhoneNumber"];
    return tel;
}

+ (NSString *)getUrl:(NSDictionary *)dic key:(NSString *)key{
    NSString *value = @"";
    if (dic != nil && [dic isKindOfClass:[NSDictionary class]] && [[dic allKeys] containsObject:key]) {
        value = [NSString stringWithFormat:@"%@", [dic objectForKey:key]];
        if (![value hasPrefix:@"http"]) {
//            value = [NSString stringWithFormat:@"%@%@", kUrlBaseForPic, value];
        }
    }
    return value;
}

+ (NSString *)getDicStr:(NSDictionary *)dic key:(NSString *)key{
    NSString *result = @"";
    if (dic != nil && [dic isKindOfClass:[NSDictionary class]] && [[dic allKeys] containsObject:key]) {
        result = [NSString stringWithFormat:@"%@", [dic objectForKey:key]];
        if ([result isEqualToString:@"<null>"]) {
            result = @"";
        }
    }
    return result;
}

+ (NSDictionary *)getDicFromString:(NSString *)str{
    // NSString to NSData
    NSData *testData = [str dataUsingEncoding: NSUTF8StringEncoding];
    
    //NSData-->NSDictionary
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:testData options:NSJSONReadingMutableContainers error:nil];
    return dic;
}

+ (CGFloat)getSystemOSVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (CGFloat)getTextHeight:(NSString *)text width:(CGFloat)width font:(UIFont *)font{
//    NSString *str = [text copy];
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    CGFloat height = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height;
    return height;
}

+ (CGFloat)getTextWidth:(NSString *)text width:(CGFloat)width font:(UIFont *)font{
//    NSString *str = [text copy];
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    CGFloat w = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width;
    return w;
}

+ (UIImage *)grayscale:(UIImage *)anImage type:(char)type {
    CGImageRef  imageRef;
    imageRef = anImage.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // ピクセルを構成するRGB各要素が何ビットで構成されている
    size_t                  bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    // ピクセル全体は何ビットで構成されているか
    size_t                  bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    // 画像の横1ライン分のデータが、何バイトで構成されているか
    size_t                  bytesPerRow;
    bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    // 画像の色空間
    CGColorSpaceRef         colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    
    // 画像のBitmap情報
    CGBitmapInfo            bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    // 画像がピクセル間の補完をしているか
    bool                    shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    // 表示装置によって補正をしているか
    CGColorRenderingIntent  intent;
    intent = CGImageGetRenderingIntent(imageRef);
    
    // 画像のデータプロバイダを取得する
    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    
    // データプロバイダから画像のbitmap生データ取得
    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);
    
    // 1ピクセルずつ画像を処理
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
            
            // RGB値を取得
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            UInt8 brightness;
            
            switch (type) {
                case 1://モノクロ
                    // 輝度計算
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                    
                case 2://セピア
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                    
                case 3://色反転
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                    
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
            
        }
    }
    
    // 効果を与えたデータ生成
    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    // 効果を与えたデータプロバイダを生成
    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    // 画像を生成
    CGImageRef  effectedCgImage;
    UIImage*    effectedImage;
    effectedCgImage = CGImageCreate(
                                    width, height,
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpace, bitmapInfo, effectedDataProvider,
                                    NULL, shouldInterpolate, intent);
    effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    // データの解放
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    
    return effectedImage;
}

+ (UIImage *)imageFromColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 10, 10);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

// 毫秒 格式化为 string
+ (NSString *)stringFromMillSec:(NSString *)timeStr{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([timeStr doubleValue]/1000)];
    return [self stringFromFomate:date formate:@"MM-dd  HH:mm"];
}

+ (NSString *)stringYYYYMMddHHmmFromMillSec:(NSString *)timeStr{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([timeStr doubleValue]/1000)];
    return [self stringFromFomate:date formate:@"YYYY-MM-dd  HH:mm"];
}

+ (NSString *)stringFromMillSec1:(NSString *)timeStr{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([timeStr doubleValue]/1000)];
    return [self stringFromFomate:date formate:@"HH:mm"];
}

+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSString *) dateMMddFromFomate:(NSString *)datestring formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter setDateFormat:@"MM/dd"];
    return [formatter stringFromDate:date];
}

+ (NSString *) dateHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:date];
}

+ (NSString *) dateMMddHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}

+ (NSString *) dateYYMMddHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}


+ (NSString *)networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}

+ (BOOL)checkPhone:(NSString *)phoneStr{
    if (phoneStr == nil || ![phoneStr isKindOfClass:[NSString class]]) {
        return NO;
    }
    NSString *phone = [phoneStr copy];
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([phone hasPrefix:@"1"] && phone.length == 11) {
        return YES;
    }
    return NO;
}

+ (BOOL)checkChineseName:(NSString *)nameStr{
    if (nameStr == nil || ![nameStr isKindOfClass:[NSString class]]) {
        return NO;
    }
    NSString *name = [nameStr copy];
    name = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (name.length < 2) {
        return NO;
    }
    for(int i=0; i< [name length];i++){
        int a = [name characterAtIndex:i];
        if( a < 0x4e00 || a > 0x9fff) {
            return NO;
        }
    }
    return YES;
}

+ (NSString *)getDistanceString:(Float64)distance{
    /*
     ￼￼
     */
    distance *= 1000;
    NSString *str = @"";
    
    if (distance < 50) {
        str = @"<50米";
    } else if (distance < 1000) {
        str = [NSString stringWithFormat:@"%.0f米", distance];
    } else if (distance < 20*1000) {
        str = [NSString stringWithFormat:@"%.1f千米", distance/1000];
    } else if (distance < 100*1000) {
        str = @">20千米";
    } else if (distance < 1000*1000) {
        str = @">100千米";
    } else {
        str = @">1000千米";
    }
    
    return str;
}

+ (NSString *)getTimePassString:(int32_t)timePass{
    
    int32_t timeNow = [NSDate date].timeIntervalSince1970;
    int32_t timeSpace = timeNow - timePass;     // 单位为秒
    
    NSString *str = @"";
    
    if (timeSpace < 60*60) {
        // 一小时以内，显示分钟
        str = [NSString stringWithFormat:@"%@分钟前", @((int32_t)timeSpace/60)];
    } else if (timeSpace < 60*60*24) {
        // 一天之内，显示小时
        str = [NSString stringWithFormat:@"%@小时前", @((int32_t)timeSpace/60/60)];
    } else if (timeSpace < 60*60*24*30) {
        // 一个月之内，显示多少天
        str = [NSString stringWithFormat:@"%@天前", @((int32_t)timeSpace/60/60/24)];
    } else if (timeSpace < 60*60*24*30*12) {
        // 一年之内，显示多少月
        str = [NSString stringWithFormat:@"%@月前", @((int32_t)timeSpace/60/60/24/30)];
    } else {
        str = @"很久以前";
    }
    
    return str;
}

+ (NSInteger)getStringLengthWithChinese:(NSString *)str{
    NSInteger count = 0;
    for(int i = 0; i < [str length]; i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            count += 2;
        } else {
            count++;
        }
    }
    return count;
}

@end

