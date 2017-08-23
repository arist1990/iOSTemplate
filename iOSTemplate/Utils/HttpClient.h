//
//  ZYHttpClient
//
//  Created by ZH_ZZ_MAC on 13-10-13.
//  Copyright (c) 2014年 ZZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestFinishBlock)(NSDictionary *result);

@interface HttpClient: NSObject

//@property (nonatomic, strong) NSMutableArray *tasks; // 保存taskIdentify，要取消任务时，将taskIdentify从这里移除

+ (instancetype)shareInstance;

//- (void)cancel:(NSUInteger)taskIdentify;
//- (void)cancelTask:(NSURLSessionTask *)task;

- (NSURLSessionTask *)getWithURL:(NSString *)urlString completeBlock:(RequestFinishBlock)block;

- (NSURLSessionTask *)postWithURL:(NSString *)urlString httpBody:(NSString *)httpBody completeBlock:(RequestFinishBlock)block;

- (NSURLSessionTask *)postWithURL:(NSString *)urlString params:(NSMutableDictionary *)params completeBlock:(RequestFinishBlock)block;

@end
