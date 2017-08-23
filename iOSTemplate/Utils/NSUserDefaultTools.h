//
//  NSUserDefaultTools.h
//  Woyanyan
//
//  定义 NSUserDefault 相关操作类
//
//  Created by ZH_ZZ_MAC on 13-12-10.
//  Copyright (c) 2013年 clyde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultTools : NSObject

+ (void)setBooleanValueWithKey:(BOOL)value key:(NSString *)key;
+ (BOOL)getBooleanValueWithKey:(NSString *)key;

+ (void)setStringValueWithKey:(NSString *)value key:(NSString *)key;
+ (NSString *)getStringValueWithKey:(NSString *)key;

+ (void)setUserInfo:(NSDictionary *)userInfo;
/**
 返回值为空时，可以看做未登录
 */
+ (NSDictionary *)getUserInfo;

+ (NSString *)getToken;
+ (NSString *)getUserID;

+ (void)setDataWithKey:(NSData *)data key:(NSString *)key;
+ (NSData *)getDataWithKey:(NSString *)key;

+ (NSInteger)getRequestID;

@end
