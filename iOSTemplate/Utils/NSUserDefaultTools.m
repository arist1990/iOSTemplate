//
//  NSUserDefaultTools.m
//  Woyanyan
//
//  定义 NSUserDefault 相关操作类
//
//  Created by ZH_ZZ_MAC on 13-12-10.
//  Copyright (c) 2013年 clyde. All rights reserved.
//

#import "NSUserDefaultTools.h"

@implementation NSUserDefaultTools

+ (void)setStringValueWithKey:(NSString *)value key:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}
+ (NSString *)getStringValueWithKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (void)setBooleanValueWithKey:(BOOL)value key:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}
+ (BOOL)getBooleanValueWithKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:key];
}

+ (void)setUserInfo:(NSDictionary *)userInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[userInfo JSONString] forKey:@"userInfo"];
    [defaults synchronize];
}

+ (NSDictionary *)getUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userInfoStr = [defaults stringForKey:@"userInfo"];
    NSDictionary *userInfo = [userInfoStr objectFromJSONString];
    if (userInfo != nil && [userInfo isKindOfClass:[NSDictionary class]]) {
        return userInfo;
    }
    return nil;
}

+ (NSString *)getToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userInfoStr = [defaults stringForKey:@"userInfo"];
    NSDictionary *userInfo = [userInfoStr objectFromJSONString];
    if (userInfo != nil && [userInfo isKindOfClass:[NSDictionary class]]) {
        return [CommonUtils getDicStr:userInfo key:@"token"];
    }
    return @"";
}

+ (NSString *)getUserID {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userInfoStr = [defaults stringForKey:@"userInfo"];
    NSDictionary *userInfo = [userInfoStr objectFromJSONString];
    if (userInfo != nil && [userInfo isKindOfClass:[NSDictionary class]]) {
        return [CommonUtils getDicStr:userInfo key:@"id"];
    }
    return @"";
}

+ (void)setDataWithKey:(NSData *)data key:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:data forKey:key];
    [defaults synchronize];
}

+ (NSData *)getDataWithKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (NSInteger)getRequestID {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger requestID = [defaults integerForKey:@"request_id"];
    if (requestID < INT16_MAX) {
        requestID++;
    } else
        requestID = 0;
    [defaults setInteger:requestID forKey:@"request_id"];
    [defaults synchronize];
    return requestID;
}

@end

